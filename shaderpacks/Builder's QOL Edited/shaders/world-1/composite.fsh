#version 120

#define BLUR_ENABLED //Is blur enabled at all?
#define GLASS_BLUR 8 //Blurs things behind stained glass [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define ICE_BLUR 4 //Blurs things behind ice [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define ICE_REFRACT //Distorts things behind ice
#define UNDERWATER_BLUR 8 //Blurs the world while underwater [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define WATER_BLUR 4 //Blurs things behind water [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define WATER_REFRACT //Distorts things behind water

uniform float aspectRatio;
uniform float far;
uniform float frameTimeCounter;
uniform int isEyeInWater;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gaux1;
uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying float eyeAdjust; //How much brighter to make the world
varying vec2 texcoord;

/*
const float eyeBrightnessHalflife = 20.0;

const int gcolorFormat = RGBA16;
const int gaux1Format = RGBA16;
const int gaux2Format = RGBA16;
const int gnormalFormat = RGB16;
*/

/*
//possibly required for optifine's option-parsing logic:
#ifdef BLUR_ENABLED
#endif
*/

struct Position {
	bool isSky;
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist; //distance measured in blocks
	float viewDist; //blockDist / far
};

const int noiseTextureResolution = 64;
const float invNoiseRes = 1.0 / float(noiseTextureResolution);

//sines and cosines of multiples of the golden angle (~2.4 radians)
const vec2 goldenOffset0 = vec2( 0.675490294261524, -0.73736887807832 ); //2.39996322972865332
const vec2 goldenOffset1 = vec2(-0.996171040864828,  0.087425724716963); //4.79992645945731
const vec2 goldenOffset2 = vec2( 0.793600751291696,  0.608438860978863); //7.19988968918596
const vec2 goldenOffset3 = vec2(-0.174181950379306, -0.98471348531543 ); //9.59985291891461
const vec2 goldenOffset4 = vec2(-0.53672805262632,   0.843755294812399); //11.9998161486433
const vec2 goldenOffset5 = vec2( 0.965715074375778, -0.259604304901489); //14.3997793783719
const vec2 goldenOffset6 = vec2(-0.887448429245268, -0.460907024713344); //16.7997426081006

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }

vec2 waterNoise(vec2 coord, float time) {
	coord *= invNoiseRes;

	vec2 noise = vec2(0.0);
	noise += (texture2D(noisetex, (coord + goldenOffset0 * time)      ).rg - 0.5);          //1.0 / 1.0
	noise += (texture2D(noisetex, (coord + goldenOffset1 * time) * 1.5).rg - 0.5) * 0.6666; //1.0 / 1.5
	noise += (texture2D(noisetex, (coord + goldenOffset2 * time) * 2.0).rg - 0.5) * 0.5;    //1.0 / 2.0
	noise += (texture2D(noisetex, (coord + goldenOffset3 * time) * 2.5).rg - 0.5) * 0.4;    //1.0 / 2.5
	noise += (texture2D(noisetex, (coord + goldenOffset4 * time) * 3.0).rg - 0.5) * 0.3333; //1.0 / 3.0
	noise += (texture2D(noisetex, (coord + goldenOffset5 * time) * 3.5).rg - 0.5) * 0.2857; //1.0 / 3.5
	noise += (texture2D(noisetex, (coord + goldenOffset6 * time) * 4.0).rg - 0.5) * 0.25;   //1.0 / 4.0
	return noise;
}

vec2 waterNoiseLOD(vec2 coord, float distance) {
	float lod = log2(distance * 0.0625); //level of detail
	float scale = floor(lod);
	coord *= exp2(-scale); //each time the distance doubles, so will the scale factor
	float middle = fract(lod);
	float time = frameTimeCounter * invNoiseRes * 2.0;

	vec2 noise1 = waterNoise(coord, time / max(scale, 1.0));
	vec2 noise2 = waterNoise(coord * 0.5, time / max(scale + 1.0, 1.0));

	return mix(noise1, noise2, interpolateSmooth1(middle));
}
vec3 iceNoise(vec2 coord) {
	coord *= invNoiseRes;

	vec3 noise = vec3(0.0);
	noise += texture2D(noisetex, coord        ).rgb;
	noise += texture2D(noisetex, coord * 0.5  ).rgb;
	noise += texture2D(noisetex, coord * 0.25 ).rgb;
	noise += texture2D(noisetex, coord * 0.125).rgb;
	noise -= 2.0; //0.5 * 4.0
	return noise;
}

vec3 iceNoiseLOD(vec2 coord, float distance) {
	float lod = log2(distance); //level of detail
	float scale = exp2(-floor(lod)); //each time the distance doubles, so will the scale factor
	coord *= scale;
	float middle = fract(lod);

	vec3 noise1 = iceNoise(coord      );
	vec3 noise2 = iceNoise(coord * 0.5);

	return mix(noise1, noise2, interpolateSmooth1(middle));
}

Position posFromDepthtex() {
	Position pos;
	float depth = texture2D(depthtex0, texcoord).r;
	pos.isSky = depth == 1.0;
	vec3 screen = vec3(texcoord, depth);
	vec4 tmp = gbufferProjectionInverse * vec4(screen * 2.0 - 1.0, 1.0);
	pos.view = tmp.xyz / tmp.w;
	pos.player = mat3(gbufferModelViewInverse) * pos.view;
	pos.world = pos.player + eyePosition;
	pos.blockDist = length(pos.view);
	pos.viewDist = pos.blockDist / far;
	pos.viewNorm = pos.view / pos.blockDist;
	pos.playerNorm = pos.player / pos.blockDist;
	return pos;
}

void main() {
	if (isEyeInWater == 2) { //under lava
		vec2 coord = floor(vec2(texcoord.x, texcoord.y / aspectRatio) * 24.0 + vec2(0.0, frameTimeCounter)) + 0.5; //24.0 is the resolution of the generated lava texture.
		float noise = 0.0;
		noise += (texture2D(noisetex, (coord * 0.25 + vec2(0.0, frameTimeCounter)) * invNoiseRes).r - 0.5);
		noise += (texture2D(noisetex, (coord * 0.5  + vec2(0.0, frameTimeCounter)) * invNoiseRes).r - 0.5) * 0.5;
		noise += (texture2D(noisetex, (coord        + vec2(0.0, frameTimeCounter)) * invNoiseRes).r - 0.5) * 0.25;
		vec3 color = vec3(1.0, 0.5, 0.0) + noise * vec3(0.375, 0.5, 0.5);
		gl_FragData[0] = vec4(color, 1.0);
		return; //don't need to calculate anything else since the lava overlay covers the entire screen.
	}

	vec2 tc = texcoord;
	vec3 normal = texture2D(gnormal, tc).xyz * 2.0 - 1.0;
	vec4 aux = texture2D(gaux1, tc);

	Position pos = posFromDepthtex();

	int id = int(aux.b * 10.0 + 0.1);

	float blur = 0.0;

	#if defined(BLUR_ENABLED) && UNDERWATER_BLUR != 0
		if (isEyeInWater == 1) blur = float(UNDERWATER_BLUR);
	#endif

	if (id == 1) {
		#if defined(BLUR_ENABLED) && WATER_BLUR != 0
			if (isEyeInWater == 0) blur = max(blur, float(WATER_BLUR));
		#endif

		#ifdef WATER_REFRACT
			vec3 newPos = pos.world;
			ivec2 swizzles;
			if (abs(normal.y) > 0.1) { //top/bottom surface
				if (abs(normal.y) < 0.999) newPos.xz -= normalize(normal.xz) * frameTimeCounter * 3.0;
				swizzles = ivec2(0, 2);
			}
			else {
				newPos.y += frameTimeCounter * 4.0;
				if (abs(normal.x) < 0.001) swizzles = ivec2(0, 1);
				else swizzles = ivec2(2, 1);
			}

			vec2 offset = waterNoiseLOD(vec2(newPos[swizzles[0]], newPos[swizzles[1]]), pos.blockDist) / 64.0; //witchcraft.
			vec2 newtc = tc + vec2(offset.x, offset.y * aspectRatio) / max(pos.blockDist * 0.0625, 1.0);
			vec3 newnormal = texture2D(gnormal, newtc).xyz * 2.0 - 1.0;
			if (dot(normal, newnormal) > 0.9) { //don't offset on the edges of water
				tc = newtc;
			}
		#endif
	}
	else if (id == 2) { //stained glass
		#if defined(BLUR_ENABLED) && GLASS_BLUR != 0
			blur = max(blur, float(GLASS_BLUR));
		#endif
	}
	else if (id == 3 || id == 4) { //ice and held ice
		#if defined(BLUR_ENABLED) && ICE_BLUR != 0
			blur = max(blur, float(ICE_BLUR));
		#endif

		#ifdef ICE_REFRACT
			vec3 offset;
			if (id == 3) {
				vec2 coord = (abs(normal.y) < 0.001 ? vec2(pos.world.x + pos.world.z, pos.world.y) : pos.world.xz);
				offset = iceNoiseLOD(coord * 256.0, pos.blockDist) * 0.0078125;
			}
			else {
				vec2 coord = gl_FragCoord.xy + 0.5;
				offset = iceNoise(coord * 0.5) * 0.0078125;
			}

			vec2 newtc = tc + vec2(offset.x, offset.y * aspectRatio);
			vec3 newnormal = texture2D(gnormal, newtc).xyz * 2.0 - 1.0;
			if (dot(normal, newnormal) > 0.9) tc = newtc;
		#endif
	}

	if (abs(texture2D(gaux1, tc).b - aux.b) > 0.02) tc = texcoord;

	vec3 color = texture2D(gcolor, tc).rgb;

	color *= mix(vec3(eyeAdjust), vec3(1.0), color);

	#ifdef BLUR_ENABLED
		blur /= 256.0;
	#endif

/* DRAWBUFFERS:5 */
	gl_FragData[0] = vec4(color, 1.0 - blur); //gcolor
}