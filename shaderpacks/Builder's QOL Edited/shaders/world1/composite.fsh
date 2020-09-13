#version 120

#define BLUR_ENABLED //Is blur enabled at all?
#define GLASS_BLUR 8 //Blurs things behind stained glass [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define ICE_BLUR 4 //Blurs things behind ice [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define ICE_REFRACT //Distorts things behind ice
#define UNDERWATER_BLUR 8 //Blurs the world while underwater [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define VOID_CLOUD_HEIGHT 128.0 //Y level of void clouds [-64.0 -48.0 -32.0 -16.0 0.0 16.0 32.0 48.0 64.0 80.0 96.0 112.0 128.0 144.0 160.0 176.0 192.0 208.0 224.0 240.0 256.0 272.0 288.0 304.0 320.0 336.0 352.0 368.0 384.0 400.0 416.0 432.0 448.0 464.0 480.0 496.0 512.0]
#define VOID_CLOUDS //Dark ominous clouds in the end
#define WATER_BLUR 4 //Blurs things behind water [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]
#define WATER_REFRACT //Distorts things behind water

uniform float aspectRatio;
uniform float blindness;
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

varying vec2 texcoord;

#ifdef VOID_CLOUDS
	varying vec4 voidCloudInsideColor; //Color to render over your entire screen when inside a void cloud.
#endif

/*
const int gcolorFormat  = RGBA16;
const int gaux1Format   = RGBA16;
const int gaux2Format   = RGBA16;
const int gnormalFormat = RGB16;
*/

/*
//used to be required for optifine's option parsing logic:
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
const vec2 goldenOffset7 = vec2( 0.343038630874082,  0.939321296324125); //19.1997058378292

float lengthSquared2(vec2 v) { return dot(v, v); }
float lengthSquared3(vec3 v) { return dot(v, v); }

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }
vec2  interpolateSmooth2(vec2 v)  { return v * v * (3.0 - 2.0 * v); }

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

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

vec3 hue(float h) {
	h = fract(h) * 6.0;
	return clamp(
		vec3(
			abs(h - 3.0) - 1.0,
			2.0 - abs(h - 2.0),
			2.0 - abs(h - 4.0)
		),
		0.0,
		1.0
	);
}

float thresholdSample(vec2 coord, vec2 threshold) {
	vec2 middle = fract(coord);
	vec4 corners = vec4(coord - middle + 0.5, 0.0, 0.0);
	corners.zw = corners.xy + 1.0;
	corners *= invNoiseRes;
	//vec4 corners = (vec4(floor(coord), ceil(coord)) + 0.5) * invNoiseRes;

	vec4 samples = vec4(
		texture2D(noisetex, corners.xy).r, //random value at the (0, 0) corner
		texture2D(noisetex, corners.xw).r, //random value at the (0, 1) corner
		texture2D(noisetex, corners.zy).r, //random value at the (1, 0) corner
		texture2D(noisetex, corners.zw).r  //random value at the (1, 1) corner
	);

	/*
	ivec4 corners = ivec4(mod(vec4(floor(coord), ceil(coord)), noiseTextureResolution));

	vec4 sample = vec4(
		texelFetch2D(noisetex, corners.xy, 0).r, //random value at the (0, 0) corner
		texelFetch2D(noisetex, corners.xw, 0).r, //random value at the (0, 1) corner
		texelFetch2D(noisetex, corners.zy, 0).r, //random value at the (1, 0) corner
		texelFetch2D(noisetex, corners.zw, 0).r  //random value at the (1, 1) corner
	);
	*/

	vec4 high = vec4(greaterThan(samples, threshold.xxxx));
	vec4 low = vec4(lessThan(samples, threshold.yyyy));

	vec2 mixlvl = interpolateSmooth2(middle); //non-linear interpolation

	return
		mix(mix(high.x, high.y, mixlvl.y), mix(high.z, high.w, mixlvl.y), mixlvl.x) -
		mix(mix(low.x,  low.y,  mixlvl.y), mix(low.z,  low.w,  mixlvl.y), mixlvl.x);
}

vec4 drawVoidClouds(in vec3 cloudPosPlayer, inout float volumetric) {
	if (blindness > 0.999) return vec4(0.0);
	float noise = 512.0 / (lengthSquared2(cloudPosPlayer.xz / cloudPosPlayer.y) + 256.0) - 3.0; //reduce cloud density in the distance
	float noiseTime = frameTimeCounter * invNoiseRes;

	vec3 cloudPosWorld = cloudPosPlayer + eyePosition;
	vec2 clumpPos = (cloudPosWorld.xz + vec2(frameTimeCounter * 2.0, 0.0)) / 256.0; //divide into 256-block-long cells
	float clumpingFactor = thresholdSample(clumpPos, vec2(0.75, 0.25)); //pick a random value for each cell. if it's above 0.75, it gets +1 density. if it's below 0.25, it gets -1 density.
	noise += clumpingFactor;

	//now to add some randomness so they look roughly cloud-shaped
	float speed = noiseTime * 2.0;
	vec2 cloudPos = cloudPosWorld.xz * invNoiseRes;
	cloudPos.x += noiseTime * 0.5; //multiplying by 0.5 instead of 2 so that clouds look like they're "spreading" as well as being blown around
	noise += texture2D(noisetex, (cloudPos + goldenOffset0 * speed) * 0.015625).r;
	noise += texture2D(noisetex, (cloudPos + goldenOffset1 * speed) * 0.03125 ).r * 0.6;
	noise += texture2D(noisetex, (cloudPos + goldenOffset2 * speed) * 0.0625  ).r * 0.36;
	noise += texture2D(noisetex, (cloudPos + goldenOffset3 * speed) * 0.125   ).r * 0.216;
	noise += texture2D(noisetex, (cloudPos + goldenOffset4 * speed) * 0.25    ).r * 0.1296;
	noise += texture2D(noisetex, (cloudPos + goldenOffset5 * speed) * 0.5     ).r * 0.07776;
	noise += texture2D(noisetex, (cloudPos + goldenOffset6 * speed)           ).r * 0.046656;
	noise += texture2D(noisetex, (cloudPos + goldenOffset7 * speed) * 2.0     ).r * 0.0279936;

	if (noise > 0.0) { //there are indeed clouds here
		vec3 color = vec3(noise * 0.0625); //base cloud color
		bool speckles = volumetric < 0.0;
		if (volumetric > 0.0) {
			volumetric = 1.0 - volumetric / (1.0 - fogify(noise, 0.125));
			if (volumetric < 0.0) return vec4(0.0);
		}

		//lightning effects:
		if (clumpingFactor > 0.0) { //only apply lightning to high-density cloud areas
			float lightningMultiplier = interpolateSmooth1(max(1.0 - length(fract(clumpPos + 0.5) * 2.0 - 1.0), 0.0)); //1.0 at the centers of cells (cells referring to the sample points collected by clumpingFactor), and 0.0 at the edges.
			vec2 lightningOffset = (texture2D(noisetex, (floor(clumpPos + 0.5) + 0.5) * invNoiseRes).gb * 0.5 + 0.5) * noiseTime; //random position to sample from
			float lightningAmt = max(texture2D(noisetex, lightningOffset).r * 8.0 - 7.0, 0.0); //do sample on that position to get lightning amount
			lightningAmt *= texture2D(noisetex, lightningOffset.yx * 32.0).r; //multiply by another value that changes more rapidly, this makes the lightning flicker instead of just fading in/out
			color += lightningAmt * lightningMultiplier * clumpingFactor * noise; //add final value.
		}

		//sparkly square confetti things:
		if (speckles) {
			vec3 data = texture2D(noisetex, (floor((cloudPosWorld.xz + vec2(frameTimeCounter, 0.0)) * 2.0) + 0.5) * invNoiseRes).rgb; //r = hue, gb = another random offset
			float amt = texture2D(noisetex, data.gb * noiseTime * 0.25).r; //base brightness of square
			amt = max(amt * 8.0 - 8.0 + noise, 0.0); //add bias so that there are more squares where cloud density is high
			color += hue(data.r * 0.35 + 0.45) * amt; //color of square
		}

		noise = min(noise * 1.5, 1.0); //add bias to noise so that clouds reach 100% opacity in highly dense regions
		return vec4(color, interpolateSmooth1(noise)) * (1.0 - blindness);
	}
	else return vec4(0.0);
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
	vec3 normal = texture2D(gnormal, tc).xyz;
	#ifdef VOID_CLOUDS
		bool isTransparent = lengthSquared3(normal) > 0.1;
	#endif
	normal = normal * 2.0 - 1.0;
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

	#ifdef VOID_CLOUDS
		float cloudDiff = VOID_CLOUD_HEIGHT - eyePosition.y;
		bool cloudy = sign(cloudDiff) == sign(pos.player.y) && isTransparent;

		if (cloudy) {
			vec3 baseCloudPos = vec3(pos.playerNorm.xz * (cloudDiff / pos.playerNorm.y), cloudDiff).xzy;
			float opacityModifier = -1.0;

			if (pos.blockDist * pos.blockDist < lengthSquared3(baseCloudPos)) {
				opacityModifier = abs(pos.world.y - VOID_CLOUD_HEIGHT) / 4.0;
				if (opacityModifier < 1.0) {
					baseCloudPos = pos.player;
				}
				else {
					cloudy = false;
				}
			}

			if (cloudy) {
				vec4 cloudclr = drawVoidClouds(baseCloudPos, opacityModifier);

				if (cloudclr.a > 0.001) {
					if (opacityModifier > 0.0 && opacityModifier < 1.0) { //in the fadeout range
						cloudclr.a *= interpolateSmooth1(opacityModifier);
					}
					color = mix(color, cloudclr.rgb, cloudclr.a);
				}
			}
		}

		color = mix(color, voidCloudInsideColor.rgb, voidCloudInsideColor.a);
	#endif

	#ifdef BLUR_ENABLED
		blur /= 256.0;
	#endif

	color *= color * -0.5 + 1.5; //mix(vec3(1.5), vec3(1.0), color);

/* DRAWBUFFERS:5 */
	gl_FragData[0] = vec4(color, 1.0 - blur); //gcolor
}