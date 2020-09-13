#version 120

#include "/lib/defines.glsl"

uniform float adjustedTime;
uniform float blindness;
uniform float day;
uniform float frameTimeCounter;
uniform float night;
uniform float phase;
uniform float rainStrength;
uniform float sunset;
uniform float wetness;
uniform int worldDay;
uniform int worldTime;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 sunPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;
vec3 sunPosNorm = normalize(sunPosition);

#ifdef CLOUDS
	varying float cloudDensityModifier; //Random fluctuations every few minutes.
#endif

varying float eyeAdjust; //How much brighter to make the world
varying vec2 texcoord;

#ifdef CLOUDS
	varying vec3 cloudColor; //Color of the side of clouds facing away from the sun.
	varying vec3 cloudIlluminationColor; //Color of the side of clouds facing towards the sun.
	varying vec4 cloudInsideColor; //Color to render over your entire screen when inside a cloud.
#endif

#include "/lib/noiseres.glsl"

#include "/lib/goldenOffsets.glsl"

#include "/lib/math.glsl"

#ifdef CLOUDS
	#ifdef OLD_CLOUDS
		#include "lib/drawClouds_old.glsl"
	#else
		#include "lib/drawClouds.glsl"
	#endif
#endif

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	gl_Position = ftransform();

	#ifdef CLOUDS
		if (wetness < 0.999) {
			//avoid some floating point precision errors on old worlds by modulus-ing the world day.
			//would just do the modulo on ints instead of floats, but if I've learned anything about GLSL, it's that it really doesn't like ints.
			//as such, I'll do it float-wise instead in hopes that it won't randomly break on someone else's GPU.
			float randTime = (mod(float(worldDay), float(noiseTextureResolution)) + worldTime / 24000.0) * 5.0;
			randTime = floor(randTime) + interpolateSmooth1(fract(randTime)) + 0.5;
			cloudDensityModifier = ((texture2D(noisetex, vec2(randTime, 0.5) * invNoiseRes).r * 2.0 - 1.0) * CLOUD_DENSITY_VARIANCE + CLOUD_DENSITY_AVERAGE) * (1.0 - wetness);
			//float r0 = texelFetch2D(noisetex, ivec2(int(randTime)     % noiseTextureResolution, 0), 0).r;
			//float r1 = texelFetch2D(noisetex, ivec2(int(randTime + 1) % noiseTextureResolution, 0), 0).r;
			//cloudDensityModifier = (mix(r0, r1, interpolateSmooth1(fract(randTime))) * 3.0 - 1.5) * (1.0 - wetness);
		}
		else {
			cloudDensityModifier = 0.0;
		}

		cloudColor              = mix(vec3(0.48, 0.5, 0.55) * day, fogColor * 0.5, wetness);
		cloudIlluminationColor = mix(vec3(1.0, 1.0, 1.0), vec3(0.45, 0.5, 0.6), wetness) * day;

		if (sunset > 0.001) {
			vec3 sunsetColor = clamp(vec3(SUNSET_COEFFICIENT_RED + 0.2, SUNSET_COEFFICIENT_GREEN + 0.2, SUNSET_COEFFICIENT_BLUE + 0.2) - adjustedTime, 0.0, 1.0);
			cloudIlluminationColor = mix(cloudIlluminationColor, sunsetColor, sunset * (1.0 - rainStrength * 0.5));
		}

		float d = abs(eyePosition.y - CLOUD_HEIGHT) / 4.0;
		if (d < 1.0) {
			cloudInsideColor = drawClouds(vec3(0.0), vec3(0.0), d, true);
			if (cloudInsideColor.a > 0.001) {
				if (d > 0.001 && d < 0.999) cloudInsideColor.a *= interpolateSmooth1(d); //in the fadeout range
			}
		}
		else cloudInsideColor = vec4(0.0);
	#endif

	#ifdef EYE_ADJUST
		float eyeBlocklight = eyeBrightnessSmooth.x / 240.0;
		float eyeSkylight = eyeBrightnessSmooth.y / 240.0;
		eyeSkylight *= 1.0 - night;
		eyeAdjust = 3.0 - 1.5 * max(eyeBlocklight, eyeSkylight);
		//eyeAdjust = 3.0 - 1.5 * max(float(eyeBrightnessSmooth.x), float(eyeBrightnessSmooth.y) * (1.0 - night)) / 240.0;
	#else
		eyeAdjust = 1.5;
	#endif
}