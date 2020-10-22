#version 120

#include "/lib/defines.glsl"

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

#include "/lib/noiseres.glsl"

#include "/lib/goldenOffsets.glsl"

#include "/lib/math.glsl"

#include "/lib/noiseLOD.glsl"

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
	#include "/lib/lavaOverlay.glsl"

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