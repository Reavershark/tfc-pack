#version 120

#include "/lib/defines.glsl"

uniform float blindness;
uniform float far;
uniform float fov;
uniform float frameTimeCounter;
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float screenBrightness;
uniform int blockEntityId;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D gaux1; //Overworld texture
uniform sampler2D gaux2; //End island texture
uniform sampler2D lightmap;
uniform sampler2D noisetex;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

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

#include "/lib/math.glsl"

#include "lib/calcMainLightColor.glsl"

#include "lib/calcFogColor.glsl"

#ifdef END_PORTAL_EFFECTS_NETHER
	#include "/lib/hue.glsl"

	#if END_PORTAL_BACKGROUND_NETHER == 2
		#include "/lib/endEffects.glsl"
	#endif

	#if END_PORTAL_CLOUDS_NETHER == 1
		#ifdef OLD_CLOUDS
			#include "/lib/fastDrawClouds_old.glsl"
		#else
			#include "/lib/fastDrawClouds.glsl"
		#endif
	#elif END_PORTAL_CLOUDS_NETHER == 2
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

	vec4 color = texture2D(texture, texcoord) * glcolor;

	float blocklight = lmcoord.x * lmcoord.x;
	float heldlight = 0.0;

	#ifdef END_PORTAL_EFFECTS_NETHER
		if (blockEntityId == 119) {
			#include "lib/endPortalEffects.glsl"
		}
		else {
	#endif
			color.rgb *= calcMainLightColor(blocklight, heldlight, pos);
	#ifdef END_PORTAL_EFFECTS_NETHER
		}
	#endif

	#include "/lib/crossprocess.glsl"

	#include "lib/fog.glsl"

	#include "/lib/blindness.glsl"

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}