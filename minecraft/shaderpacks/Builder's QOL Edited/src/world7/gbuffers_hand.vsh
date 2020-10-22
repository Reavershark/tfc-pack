#version 120

#include "/lib/defines.glsl"

uniform float frameTimeCounter;
uniform int heldBlockLightValue;
uniform int heldItemId;
uniform int heldItemId2;
uniform ivec2 eyeBrightnessSmooth;
uniform sampler2D noisetex;

varying float mcentity;
varying vec2 lmcoord;
varying vec2 texcoord;

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 normal;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

#include "/lib/noiseres.glsl"

#include "/lib/calcHeldLightColor.glsl"

void main() {
	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	#ifdef IDLE_HANDS
		if (heldItemId != 359 && heldItemId2 != 359) { //no hand sway when holding a map.
			vPosView.xy += sin(frameTimeCounter * vec2(1.6, 1.2)) * (sign(gl_ModelViewMatrix[3][0] + 0.3125) * 0.015625);
		}
	#endif
	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor  =  gl_Color;

	#include "lib/colors.glsl"

	int id = gl_ModelViewMatrix[3][0] > -0.3125 ? heldItemId : heldItemId2;
	if (id == 95 || id == 160) mcentity = 2.1; //stained glass
	else if (id == 79) mcentity = 4.1; //ice
	else mcentity = 0.0;

	normal = normalize(gl_Normal) * 0.5 + 0.5;
}