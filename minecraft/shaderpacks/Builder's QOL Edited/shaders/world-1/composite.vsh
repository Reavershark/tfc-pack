#version 120

#define EYE_ADJUST //Allows your eyes to "adjust" to darkness

uniform ivec2 eyeBrightnessSmooth;

varying float eyeAdjust; //How much brighter to make the world
varying vec2 texcoord;

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	gl_Position = ftransform();

	#ifdef EYE_ADJUST
		eyeAdjust = 2.5 - eyeBrightnessSmooth.x / 240.0;
	#else
		eyeAdjust = 1.5;
	#endif
}