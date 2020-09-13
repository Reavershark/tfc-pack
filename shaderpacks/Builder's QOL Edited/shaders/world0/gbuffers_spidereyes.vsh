#version 120

varying vec2 texcoord;
varying vec3 vPosView;
varying vec4 glcolor;

void main() {
	gl_Position = ftransform();
	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}