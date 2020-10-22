#version 120

#include "/lib/defines.glsl"

uniform float adjustedTime;
uniform float blindness;
uniform float day;
uniform float far;
uniform float fov;
uniform float night;
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float rainStrength;
uniform float screenBrightness;
uniform float sunset;
uniform float wetness;
uniform int isEyeInWater;
uniform ivec2 eyeBrightness;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D gaux3;
uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform vec3 sunPosition;
uniform vec3 upPosition;
vec3 sunPosNorm = normalize(sunPosition);
vec3 upPosNorm = normalize(upPosition);
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying float glmult;
varying float mcentity;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 normal;
varying vec3 shadowColor; //Color of shadows. Sky-colored, to simulate indirect lighting.
varying vec3 skyLightColor; //Color of sky light. Is usually white during the day, and very dark blue at night.
varying vec3 vPosPlayer;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

struct Position {
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist;
	float viewDist;
};

#include "lib/colorConstants.glsl"

#include "/lib/math.glsl"

#include "lib/calcMainLightColor.glsl"

#include "lib/calcFogColor.glsl"

#include "lib/calcUnderwaterFogColor.glsl"

#include "lib/calcUnderwaterFogColorInfinity.glsl"

void main() {
	Position pos;
	pos.view = vPosView;
	pos.player = vPosPlayer;
	pos.world = vPosPlayer + eyePosition;
	pos.blockDist = length(pos.view);
	pos.viewDist = pos.blockDist / far;
	pos.viewNorm = pos.view / pos.blockDist;
	pos.playerNorm = pos.player / pos.blockDist;

	vec4 color = texture2D(texture, texcoord);
	int id = int(mcentity);
	if (id == 2 && color.a > THRESHOLD_ALPHA) id = 0; //opacity threshold for border of stained glass

	#include "lib/initLightLevels.glsl"

	color.rgb *= calcMainLightColor(blocklight, skylight, heldlight, pos);
	vec4 multiplier = glcolor;
	multiplier.rgb *= mix(glmult, 1.0, max(blocklight, heldlight) * 0.5);
	color *= multiplier;

	if (id == 1) {
		if (isEyeInWater == 0) {
			vec2 tc = gl_FragCoord.xy * vec2(pixelSizeX, pixelSizeY);
			//deferred transfers depthtex to gaux3
			vec3 behindViewPos = vec3(tc, texture2D(gaux3, tc).r);
			bool sky = behindViewPos.z == 1.0;
			vec4 tmp = gbufferProjectionInverse * vec4(behindViewPos * 2.0 - 1.0, 1.0);
			behindViewPos = tmp.xyz / tmp.w;

			vec4 origColor = color;

			if (sky) {
				color = vec4(calcUnderwaterFogColorInfinity(0.9384765625 /* (31 / 32) ^ 2 */), 1.0);
			}
			else {
				#ifdef UNDERWATER_FOG
					vec3 fogclr = calcUnderwaterFogColorInfinity(eyeBrightnessSmooth.y / 240.0);
					float opacity = 1.0 - exp2((pos.blockDist - length(behindViewPos)) * mix(0.125, 0.25, rainStrength));
					color = vec4(fogclr, opacity);
				#else
					color = vec4(0.0);
				#endif
			}

			#ifndef CLEAR_WATER
				color.rgb = mix(color.rgb, origColor.rgb, origColor.a);
				color.a = mix(color.a, 1.0, origColor.a);
			#endif
		}
		#ifdef CLEAR_WATER
			else color = vec4(0.0);
		#endif
	}

	#include "lib/desaturate.glsl"

	#include "/lib/crossprocess.glsl"

	if (id == 0) {
		#include "lib/fog.glsl"
	}

	#include "/lib/blindness.glsl"

/* DRAWBUFFERS:204 */
	gl_FragData[0] = vec4(normal, 1.0); //gnormal; writing here first to ensure that it ALWAYS writes ID data, even when opacity is 0.
	gl_FragData[1] = color; //gcolor
	gl_FragData[2] = vec4(lmcoord, id * 0.1, 1.0); //gaux1
}