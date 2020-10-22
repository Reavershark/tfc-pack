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
uniform sampler2D lightmap;
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

void main() {
	Position pos;
	pos.view = vPosView;
	pos.player = vPosPlayer;
	pos.world = vPosPlayer + eyePosition;
	pos.blockDist = length(pos.view);
	pos.viewNorm = pos.view / pos.blockDist;
	pos.playerNorm = pos.player / pos.blockDist;
	pos.blockDist = 1.0; //spoof
	pos.viewDist = pos.blockDist / far;

	vec4 color = texture2D(texture, texcoord);
	int id = int(mcentity);
	if (id == 2 && color.a > THRESHOLD_ALPHA) id = 0; //opacity threshold for border of stained glass

	#include "lib/initLightLevels.glsl"

	color.rgb *= calcMainLightColor(blocklight, skylight, heldlight, pos);
	vec4 multiplier = glcolor;
	multiplier.rgb *= mix(glmult, 1.0, max(blocklight, heldlight) * 0.5);
	color *= multiplier;

	#include "lib/desaturate.glsl"

	#include "/lib/crossprocess.glsl"

	#ifdef REFLECT
		if (id == 0) {
	#endif
			#include "lib/fog.glsl"
	#ifdef REFLECT
		}
	#endif

	#include "/lib/blindness.glsl"

/* DRAWBUFFERS:024 */
	gl_FragData[0] = color; //gcolor
	gl_FragData[1] = vec4(normal, 1.0); //gnormal
	gl_FragData[2] = vec4(lmcoord, id * 0.1, 1.0); //gaux1
}