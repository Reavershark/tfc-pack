#version 120

varying vec2 texcoord;
varying vec3 vPosView;
varying vec4 glcolor;

void main() {
	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}