#version 120

#include "/lib/defines.glsl"

uniform float frameTimeCounter;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 vPosView;
varying vec4 glcolor;

void main() {
	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;

	#ifdef IDLE_HANDS
		if (gl_ProjectionMatrix[2][2] > -0.5) {
			vPosView.xy += sin(frameTimeCounter * vec2(1.6, 1.2)) * (sign(gl_ModelViewMatrix[3][0] + 0.3125) * 0.015625);
		}
	#endif
	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor  =  gl_Color;
}