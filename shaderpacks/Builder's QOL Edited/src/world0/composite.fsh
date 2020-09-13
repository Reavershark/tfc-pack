#version 120

#include "/lib/defines.glsl"

uniform float blindness;
uniform float day;
uniform float rainStrength;
uniform int isEyeInWater;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gaux1;
uniform sampler2D gcolor;
uniform sampler2D gnormal;
uniform vec3 cameraPosition;
uniform vec3 upPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 texcoord;

const float actualSeaLevel = SEA_LEVEL - 0.1111111111111111; //water source blocks are 8/9'ths of a block tall, so SEA_LEVEL - 1/9.

#include "lib/calcUnderwaterFogColorInfinity.glsl"

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;
	vec3 normal = texture2D(gnormal, texcoord).xyz * 2.0 - 1.0;
	vec3 aux = texture2D(gaux1, texcoord).rgb;

	float oceanFlag = 1.0;

	//pre-processing for infinite oceans
	#ifdef INFINITE_OCEANS
		float depth = texture2D(depthtex0, texcoord).r;
		if (depth == 1.0) { //sky
			vec3 screenPos = vec3(texcoord, depth);
			vec4 tmp = gbufferProjectionInverse * vec4(screenPos * 2.0 - 1.0, 1.0);
			bool top = dot(tmp.xyz, upPosition) > 0.0; //don't care about dot product being normalized
			bool aboveSeaLevel = eyePosition.y > actualSeaLevel;

			if (top) {
				if (!aboveSeaLevel && isEyeInWater == 1) {
					normal = vec3(0.0, -1.0, 0.0);
					aux = vec3(0.0, 1.0, 0.1);
					oceanFlag = 0.0;
				}
			}
			else {
				if (aboveSeaLevel) {
					color = calcUnderwaterFogColorInfinity(0.9384765625 /* (31 / 32) ^ 2 */) * (1.0 - blindness);
					normal = vec3(0.0, 1.0, 0.0);
					aux = vec3(0.0, 0.96875, 0.1);
					oceanFlag = 0.0;
				}
				else if (isEyeInWater == 1) color = calcUnderwaterFogColorInfinity(eyeBrightnessSmooth.y / 240.0) * (1.0 - blindness);
			}
		}
	#endif

/* DRAWBUFFERS:024 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
	gl_FragData[1] = vec4(normal * 0.5 + 0.5, 1.0); //gnormal
	gl_FragData[2] = vec4(aux, oceanFlag); //gaux1
}