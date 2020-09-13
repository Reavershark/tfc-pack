#version 120

#include "/lib/defines.glsl"

uniform float blindness;
uniform float frameTimeCounter;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 texcoord;

#ifdef VOID_CLOUDS
	varying vec4 voidCloudInsideColor; //Color to render over your entire screen when inside a void cloud.
#endif

#include "/lib/noiseres.glsl"

#include "/lib/goldenOffsets.glsl"

#include "/lib/math.glsl"

#include "/lib/hue.glsl"

#include "lib/drawVoidClouds.glsl"

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	gl_Position = ftransform();

	#ifdef VOID_CLOUDS
		float d = abs(eyePosition.y - VOID_CLOUD_HEIGHT) / 4.0;
		if (d < 1.0) {
			voidCloudInsideColor = drawVoidClouds(vec3(0.0, 1.0, 0.0), d);
			if (voidCloudInsideColor.a > 0.001) {
				if (d > 0.0 && d < 1.0) { //in the fadeout range
					voidCloudInsideColor.a *= interpolateSmooth1(d) * 0.9; //0.9 makes it not completely opaque in the middles of clouds.
				}
			}
		}
		else voidCloudInsideColor = vec4(0.0);
	#endif
}