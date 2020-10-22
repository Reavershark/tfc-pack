#version 120

#include "/lib/defines.glsl"

uniform float adjustedTime;
uniform float blindness;
uniform float day;
uniform float far;
uniform float fov;
uniform float frameTimeCounter;
uniform float night;
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float rainStrength;
uniform float screenBrightness;
uniform float sunset;
uniform float wetness;
uniform int blockEntityId;
uniform int isEyeInWater;
uniform ivec2 eyeBrightness;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D gaux1; //Overworld texture
uniform sampler2D gaux2; //End island texture
uniform sampler2D lightmap;
uniform sampler2D noisetex;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform vec3 sunPosition;
uniform vec3 upPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;
vec3 sunPosNorm = normalize(sunPosition);
vec3 upPosNorm = normalize(upPosition);

varying float glmult;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

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

#include "/lib/noiseres.glsl"

#include "/lib/goldenOffsets.glsl"

#include "lib/colorConstants.glsl"

#include "/lib/math.glsl"

#include "lib/calcMainLightColor.glsl"

#include "lib/calcFogColor.glsl"

#include "lib/calcUnderwaterFogColor.glsl"

#ifdef END_PORTAL_EFFECTS_OVERWORLD
	#include "/lib/hue.glsl"

	#if END_PORTAL_BACKGROUND_OVERWORLD == 2
		#include "/lib/endEffects.glsl"
	#endif

	#if END_PORTAL_CLOUDS_OVERWORLD == 1
		#ifdef OLD_CLOUDS
			#include "/lib/fastDrawClouds_old.glsl"
		#else
			#include "/lib/fastDrawClouds.glsl"
		#endif
	#elif END_PORTAL_CLOUDS_OVERWORLD == 2
		#include "/lib/fastDrawVoidClouds.glsl"
	#endif
#endif

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

	#include "lib/initLightLevels.glsl"

	#ifdef END_PORTAL_EFFECTS_OVERWORLD
		if (blockEntityId == 119) {
			#include "lib/endPortalEffects.glsl"
		}
		else {
	#endif
			color.rgb *= calcMainLightColor(blocklight, skylight, heldlight, pos);
			vec4 multiplier = glcolor;
			multiplier.rgb *= mix(glmult, 1.0, max(blocklight, heldlight) * 0.5);
			color *= multiplier;
	#ifdef END_PORTAL_EFFECTS_OVERWORLD
		}
	#endif

	#include "lib/desaturate.glsl"

	#include "/lib/crossprocess.glsl"

	#include "lib/fog.glsl"

	#include "/lib/blindness.glsl"

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}