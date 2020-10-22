#version 120

#include "/lib/defines.glsl"

uniform float frameTimeCounter;
uniform float nightVision;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gcolor;
uniform sampler2D noisetex;
uniform vec3 fogColor;

varying vec2 texcoord;

struct Position {
	vec3 view;
	//viewNorm not needed by anything.
	vec3 player;
	vec3 playerNorm;
	float blockDist;
	//viewDist not needed by anything.
};

#include "/lib/noiseres.glsl"

#include "/lib/math.glsl"

#include "lib/calcFogColor.glsl"

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	//no skybasic program in the nether. use deferred instead.
	#ifdef FOG_ENABLED_NETHER
		float depth = texture2D(depthtex0, texcoord).r;
		if (depth == 1.0) {
			Position pos;
			vec3 screenPos = vec3(texcoord, depth);
			vec4 tmp = gbufferProjectionInverse * vec4(screenPos * 2.0 - 1.0, 1.0);
			pos.view = tmp.xyz / tmp.w;
			pos.player = mat3(gbufferModelViewInverse) * pos.view;
			pos.blockDist = length(pos.view);
			pos.playerNorm = pos.player / pos.blockDist;

			color = calcFogColor(pos);
		}
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}