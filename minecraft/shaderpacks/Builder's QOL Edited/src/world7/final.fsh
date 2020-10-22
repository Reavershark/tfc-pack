#version 120

#include "/lib/defines.glsl"

uniform float pixelSizeY;
uniform float viewHeight;
uniform sampler2D gaux1;
#define inputSampler gaux1

varying vec2 texcoord;

#include "/lib/math.glsl"

void main() {
	#include "/lib/verticalBlur.glsl"

	gl_FragColor = color; //screen output
}