#version 120

#include "/lib/defines.glsl"

uniform float adjustedTime;
uniform float aspectRatio;
uniform float blindness;
uniform float day;
uniform float far;
uniform float frameTimeCounter;
uniform float night;
uniform float nightVision;
uniform float phase;
uniform float rainStrength;
uniform float sunset;
uniform float wetness;
uniform int isEyeInWater;
uniform ivec2 eyeBrightness;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gaux1;
uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform vec3 sunPosition;
uniform vec3 upPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;
vec3 sunPosNorm = normalize(sunPosition);
vec3 upPosNorm = normalize(upPosition);

#ifdef CLOUDS
	varying float cloudDensityModifier; //Random fluctuations every few minutes.
#endif

varying float eyeAdjust; //How much brighter to make the world
varying vec2 texcoord;

#ifdef CLOUDS
	varying vec3 cloudColor; //Color of the side of clouds facing away from the sun.
	varying vec3 cloudIlluminationColor; //Color of the side of clouds facing towards the sun.
	varying vec4 cloudInsideColor; //Color to render over your entire screen when inside a cloud.
#endif

/*
const float eyeBrightnessHalflife = 20.0;
const float wetnessHalflife = 250.0;
const float drynessHalflife = 60.0;

const int gcolorFormat = RGBA16;
const int gaux1Format = RGBA16;
const int gaux2Format = RGBA16;
const int gaux3Format = R32F;
const int gnormalFormat = RGB16;
*/

/*
//used to be required for optifine's option parsing logic:
#ifdef BLUR_ENABLED
#endif
*/

const float actualSeaLevel = SEA_LEVEL - 0.1111111111111111; //water source blocks are 8/9'ths of a block tall, so SEA_LEVEL - 1/9.

struct Position {
	bool isSky;
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist;
	float viewDist;
};

#include "/lib/noiseres.glsl"

#include "/lib/goldenOffsets.glsl"

#include "lib/colorConstants.glsl"

#include "/lib/math.glsl"

#include "lib/calcFogColor.glsl"

#include "lib/calcUnderwaterFogColor.glsl"

#include "lib/calcSkyColorBasic.glsl"

#include "/lib/noiseLOD.glsl"

#ifdef CLOUDS
	#ifdef OLD_CLOUDS
		#include "lib/drawClouds_old.glsl"
	#else
		#include "lib/drawClouds.glsl"
	#endif
#endif

Position getPosition() {
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
	vec3 normal = texture2D(gnormal, tc).xyz;
	#ifdef CLOUDS
		bool isTransparent = lengthSquared3(normal) > 0.1;
	#endif
	normal = normal * 2.0 - 1.0;
	vec4 aux = texture2D(gaux1, tc);

	Position pos = getPosition();

	int id = int(aux.b * 10.0 + 0.1);

	#ifdef REFLECT
		float reflective = 0.0;
	#endif

	float blur = 0.0;

	#if defined(BLUR_ENABLED) && UNDERWATER_BLUR != 0
		if (isEyeInWater == 1) blur = float(UNDERWATER_BLUR);
	#endif

	#if defined(BLUR_ENABLED) && WATER_BLUR != 0
		float waterBlur = 0.0;
	#endif

	if (id == 1) {
		#ifdef REFLECT
			reflective = 0.5;
		#endif

		#if defined(BLUR_ENABLED) && WATER_BLUR != 0
			if (isEyeInWater == 0) waterBlur = float(WATER_BLUR);
		#endif

		#ifdef INFINITE_OCEANS
			if (pos.isSky) {
				float diff = actualSeaLevel - eyePosition.y;
				pos.player = vec3(pos.playerNorm.xz * (diff / pos.playerNorm.y), diff).xzy;
				pos.world = pos.player + eyePosition;
				pos.blockDist = length(pos.player);
				pos.viewDist = pos.blockDist / far;
				pos.isSky = false;
			}
		#endif

		#if defined(WATER_REFRACT) || (defined(WATER_NORMALS) && defined(REFLECT))
			vec3 newPos = pos.world;
			ivec2 swizzles;
			float multiplier = 1.0;
			if (abs(normal.y) > 0.1) { //top/bottom surface
				if (abs(normal.y) < 0.999) newPos.xz -= normalize(normal.xz) * frameTimeCounter * 3.0;
				else multiplier = (aux.g * (0.75 - night * 0.375) + 0.25) + (aux.g * min(rainStrength, wetness) * 1.5);
				swizzles = ivec2(0, 2);
			}
			else {
				newPos.y += frameTimeCounter * 4.0;
				if (abs(normal.x) < 0.001) swizzles = ivec2(0, 1);
				else swizzles = ivec2(2, 1);
			}

			vec2 offset = waterNoiseLOD(vec2(newPos[swizzles[0]], newPos[swizzles[1]]), pos.blockDist) * (multiplier * 0.015625); //witchcraft.
			#ifdef WATER_NORMALS
				normal[swizzles[0]] += offset[0] * 4.0;
				normal[swizzles[1]] += offset[1] * 4.0;
				normal = normalize(normal);
			#endif

			#ifdef WATER_REFRACT
				vec2 newtc = tc + vec2(offset.x, offset.y * aspectRatio) / max(pos.blockDist * 0.0625, 1.0);
				vec3 newnormal = texture2D(gnormal, newtc).xyz * 2.0 - 1.0;
				if (dot(normal, newnormal) > 0.9) { //don't offset on the edges of water
					tc = newtc;
				}
			#endif
		#endif
	}
	else if (id == 2) { //stained glass
		#ifdef REFLECT
			reflective = 0.25;
		#endif

		#if defined(BLUR_ENABLED) && GLASS_BLUR != 0
			blur = max(blur, float(GLASS_BLUR));
		#endif
	}
	else if (id == 3 || id == 4) { //ice and held ice
		#ifdef REFLECT
			reflective = 0.25;
		#endif

		#if defined(BLUR_ENABLED) && ICE_BLUR != 0
			blur = max(blur, float(ICE_BLUR));
		#endif

		#if defined(ICE_REFRACT) || (defined(ICE_NORMALS) && defined(REFLECT))
			vec3 offset;
			if (id == 3) {
				vec2 coord = (abs(normal.y) < 0.001 ? vec2(pos.world.x + pos.world.z, pos.world.y) : pos.world.xz);
				offset = iceNoiseLOD(coord * 256.0, pos.blockDist) * 0.0078125;
			}
			else {
				vec2 coord = gl_FragCoord.xy + 0.5;
				offset = iceNoise(coord * 0.5) * 0.0078125;
			}

			#ifdef ICE_REFRACT
				vec2 newtc = tc + vec2(offset.x, offset.y * aspectRatio);
				vec3 newnormal = texture2D(gnormal, newtc).xyz * 2.0 - 1.0;
				if (dot(normal, newnormal) > 0.9) tc = newtc; //don't offset on the edges of ice
			#endif

			#ifdef ICE_NORMALS
				normal = normalize(normal + offset * 8.0);
			#endif
		#endif
	}


	if (abs(texture2D(gaux1, tc).b - aux.b) > 0.02) tc = texcoord;

	vec3 color = texture2D(gcolor, tc).rgb;

	#ifdef REFLECT
		reflective *= aux.g * aux.g * (1.0 - blindness);
		vec3 reflectedPos;
		if (isEyeInWater == 0 && reflective > 0.001) {
			//sky reflections
			vec3 newnormal = mat3(gbufferModelView) * normal;
			reflectedPos = reflect(pos.viewNorm, newnormal);
			vec3 skyclr = calcSkyColor(reflectedPos);
			float posDot = dot(-pos.viewNorm, newnormal);
			color += skyclr * square(square(1.0 - max(posDot, 0.0))) * reflective;
		}
	#endif

	#ifdef FOG_ENABLED_OVERWORLD
		if (id >= 1) {
			//fog
			vec2 lmcoord = aux.rg;
			float skylight = lmcoord.y * lmcoord.y * (1.0 - rainStrength * 0.5);

			#include "lib/compositeFog.glsl"

			#include "/lib/blindness.glsl"
		}
	#endif

	#ifdef REFLECT
		//sun reflection
		reflective *= day * day * (1.0 - rainStrength);
		if (isEyeInWater == 0 && reflective > 0.001) {
			vec3 reflectionColor = mix(vec3(2.0, 1.0, 0.5), vec3(1.0, 0.9, 0.8), day);
			float sunDot = dot(reflectedPos, sunPosNorm);
			float reflectionAmt = 0.00003 / square(1.001 - sunDot);
			color += reflectionAmt * reflectionColor * reflective;

			#if defined(BLUR_ENABLED) && WATER_BLUR != 0
				waterBlur = clamp((sunDot - 0.75) * 16.0, waterBlur, float(WATER_BLUR)); //no more than WATER_BLUR, and no less than what it was originally.
			#endif
		}

		color = min(color, 1.0);
	#endif

	#ifdef CLOUDS
		float cloudDiff = CLOUD_HEIGHT - eyePosition.y;
		vec3 baseCloudPos = pos.player;

		#ifdef CUBIC_CHUNKS
			bool cloudy = sign(cloudDiff) == sign(baseCloudPos.y) && isTransparent;
		#else
			bool cloudy = eyePosition.y > 0.0 && sign(cloudDiff) == sign(baseCloudPos.y) && isTransparent;
		#endif

		if (cloudy) {
			baseCloudPos = normalize(baseCloudPos);
			baseCloudPos = vec3(baseCloudPos.xz * (cloudDiff / baseCloudPos.y), cloudDiff).xzy;
			float opacityModifier = -1.0;

			if (pos.blockDist * pos.blockDist < lengthSquared3(baseCloudPos)) {
				opacityModifier = abs(pos.world.y - CLOUD_HEIGHT) / 4.0;
				if (opacityModifier < 1.0) {
					baseCloudPos = pos.player;
				}
				else {
					cloudy = false;
				}
			}

			if (cloudy) {
				vec4 cloudclr = drawClouds(baseCloudPos, pos.viewNorm, opacityModifier, false);
				cloudclr.a *= 64.0 / (lengthSquared2(baseCloudPos.xz / baseCloudPos.y) + 64.0); //reduce opacity in the distance

				if (cloudclr.a > 0.001) {
					if (opacityModifier > 0.0 && opacityModifier < 1.0) { //in the fadeout range
						cloudclr.a *= interpolateSmooth1(opacityModifier);
					}
					color = mix(color, cloudclr.rgb, cloudclr.a);
				}
			}
		}
		color = mix(color, cloudInsideColor.rgb, cloudInsideColor.a);
	#endif

	#if defined(BLUR_ENABLED) && WATER_BLUR != 0
		if (id == 1 && isEyeInWater == 0) blur += waterBlur;
	#endif

	#ifdef BLUR_ENABLED
		blur /= 256.0;
	#endif

	color *= mix(vec3(eyeAdjust), vec3(1.0), color);

/* DRAWBUFFERS:5 */
	gl_FragData[0] = vec4(color, 1.0 - blur); //gcolor
}