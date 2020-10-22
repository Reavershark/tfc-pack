#version 120

#include "/lib/defines.glsl"

uniform float pixelSizeX;
uniform float viewWidth;
uniform sampler2D gaux2; //output from previous stage
#define inputSampler gaux2

varying vec2 texcoord;

#include "/lib/math.glsl"

void main() {
	#include "/lib/horizontalBlur.glsl"

/* DRAWBUFFERS:4 */
	gl_FragData[0] = color; //composite
}