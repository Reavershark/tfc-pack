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
uniform int entityId;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec4 entityColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

struct Position {
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist;
	float viewDist;
};

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

#include "/lib/math.glsl"

#ifdef RAINBOW_XP
	#include "/lib/hue.glsl"
#endif

#include "lib/calcMainLightColor.glsl"

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
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);

	float blocklight = lmcoord.x * lmcoord.x;
	float heldlight = 0.0;

	vec4 multiplier = glcolor;

	#include "/lib/rainbowXP.glsl"

	multiplier.rgb *= calcMainLightColor(blocklight, heldlight, pos);
	color *= multiplier;

	if (color.a < 0.01) discard; //fix phantoms

	#include "lib/desaturate.glsl"

	#include "/lib/crossprocess.glsl"

	#include "lib/fog.glsl"

	#include "/lib/blindness.glsl"

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}