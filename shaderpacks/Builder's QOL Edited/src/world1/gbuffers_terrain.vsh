#version 120

#include "/lib/defines.glsl"

attribute vec2 mc_midTexCoord;
attribute vec3 mc_Entity;

uniform float frameTimeCounter;
uniform int heldBlockLightValue;
uniform int heldItemId;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying float ao;
varying float isLava;
varying vec2 lmcoord;
varying vec2 randCoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 vPosPlayer;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

#include "/lib/noiseres.glsl"

#include "/lib/calcHeldLightColor.glsl"

void main() {
	ao = 1.0;
	isLava = 0.0;

	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
	vec3 worldPos = vPosPlayer + eyePosition;

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor  = gl_Color;

	//Using IDs above 10000 to represent all blocks that I care about
	//if the ID is less than 10000, then I don't need to do extra logic to see if it has special effects.
	if (mc_Entity.x > 10000.0) {
		int id = int(mc_Entity.x) - 10000;
		if (id == 2 || id == 3 || id == 4) { //plants and double plants
			#ifdef REMOVE_Y_OFFSET
				worldPos.y = floor(worldPos.y + 0.5);
			#endif

			#ifdef REMOVE_XZ_OFFSET
				wordPos.xz = floor(worldPos.xz + 0.5);
			#endif

			#ifdef GRASS_AO
				ao = float(texcoord.y < mc_midTexCoord.y);
				if (id == 175) {
					ao = (ao + float(mc_Entity.z >= 8.0)) * 0.5;
				}
			#endif
		}

		#ifdef GRASS_AO
			else if (id == 5) { //crops
				ao = float(texcoord.y < mc_midTexCoord.y);
			}
		#endif

		#ifdef LAVA_PATCHES
			else if (id == 7) { //lava
				isLava = 1.0;
				if (abs(gl_Normal.y) > 0.1) randCoord = worldPos.xz * 2.0;
				else randCoord = vec2((worldPos.x + worldPos.z) * 4.0, worldPos.y + frameTimeCounter);
			}
		#endif
	}

	#include "lib/colors.glsl"

	vPosPlayer = worldPos - eyePosition;
	vPosView = mat3(gbufferModelView) * vPosPlayer;
	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);

	float glmult = dot(vec4(abs(gl_Normal.x), abs(gl_Normal.z), max(gl_Normal.y, 0.0), max(-gl_Normal.y, 0.0)), vec4(0.6, 0.8, 1.0, 0.5));
	glmult = mix(glmult, 1.0, lmcoord.x * lmcoord.x); //increase brightness when block light is high
	glcolor.rgb *= glmult;
}