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
uniform mat4 gbufferModelViewInverse;
uniform sampler2D lightmap;
uniform sampler2D noisetex;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying float mcentity;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 normal;
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

#include "/lib/math.glsl"

#include "lib/calcMainLightColor.glsl"

#include "lib/calcFogColor.glsl"

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

	#ifdef CLEAR_WATER
		if (id == 1) color = vec4(0.0);
		else {
	#endif
			float blocklight = lmcoord.x * lmcoord.x;
			float heldlight = 0.0;

			color.rgb *= calcMainLightColor(blocklight, heldlight, pos);

			color *= glcolor;

			#include "/lib/crossprocess.glsl"

			#include "lib/fog.glsl"

			#include "/lib/blindness.glsl"

	#ifdef CLEAR_WATER
		}
	#endif


/* DRAWBUFFERS:204 */
	gl_FragData[0] = vec4(normal, 1.0); //gnormal; writing here first to ensure that it ALWAYS writes ID data, even when opacity is 0.
	gl_FragData[1] = color; //gcolor
	gl_FragData[2] = vec4(lmcoord, id * 0.1, 1.0); //gaux1
}