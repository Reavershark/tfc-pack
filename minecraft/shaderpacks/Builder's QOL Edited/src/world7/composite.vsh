#version 120

#include "/lib/defines.glsl"

uniform ivec2 eyeBrightnessSmooth;

varying float eyeAdjust; //How much brighter to make the world
varying vec2 texcoord;

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	gl_Position = ftransform();

	#ifdef EYE_ADJUST
		eyeAdjust = 3.0 - 1.5 * max(float(eyeBrightnessSmooth.x), float(eyeBrightnessSmooth.y)) / 240.0;
	#else
		eyeAdjust = 1.5;
	#endif
}