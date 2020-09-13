#version 120

#define CLOUD_DENSITY_AVERAGE 0.0 //Average cloud density. Higher value means more clouds [-2.0 -1.9 -1.8 -1.7 -1.6 -1.5 -1.4 -1.3 -1.2 -1.1 -1.0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define CLOUD_DENSITY_VARIANCE 1.5 //How far above or below the average cloud density will go [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define CLOUD_HEIGHT 256.0 //Y level of fancy clouds [128.0 144.0 160.0 176.0 192.0 208.0 224.0 240.0 256.0 272.0 288.0 304.0 320.0 336.0 352.0 368.0 384.0 400.0 416.0 432.0 448.0 464.0 480.0 496.0 512.0]
#define CLOUD_NORMALS //Dynamically light clouds based on weather they're facing towards or away from the sun. Mild performance impact!
#define CLOUDS //3D clouds (partially volumetric too). Mild performance impact!
#define EYE_ADJUST //Allows your eyes to "adjust" to darkness
//#define OLD_CLOUDS //Uses old cloud rendering method from earlier versions, for people who don't like pretty things.
#define SUNSET_COEFFICIENT_BLUE 6.2 //Blue sunset coefficient. Higher values will result in the blue color of sunset starting earlier and persisting longer. A change of 0.1 corresponds to about 5 seconds real-world time. [6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
#define SUNSET_COEFFICIENT_GREEN 6.7 //Green sunset coefficient. Higher values will result in the green color of sunset starting earlier and persisting longer. A change of 0.1 corresponds to about 5 seconds real-world time. [6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
#define SUNSET_COEFFICIENT_RED 7.2 //Red sunset coefficient. Higher values will result in the red color of sunset starting earlier and persisting longer. A change of 0.1 corresponds to about 5 seconds real-world time. [6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]

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

const int noiseTextureResolution = 64;
const float invNoiseRes = 1.0 / float(noiseTextureResolution);

//sines and cosines of multiples of the golden angle (~2.4 radians)
const vec2 goldenOffset0 = vec2( 0.675490294261524, -0.73736887807832 ); //2.39996322972865332
const vec2 goldenOffset1 = vec2(-0.996171040864828,  0.087425724716963); //4.79992645945731
const vec2 goldenOffset2 = vec2( 0.793600751291696,  0.608438860978863); //7.19988968918596
const vec2 goldenOffset3 = vec2(-0.174181950379306, -0.98471348531543 ); //9.59985291891461
const vec2 goldenOffset4 = vec2(-0.53672805262632,   0.843755294812399); //11.9998161486433
const vec2 goldenOffset5 = vec2( 0.965715074375778, -0.259604304901489); //14.3997793783719
const vec2 goldenOffset6 = vec2(-0.887448429245268, -0.460907024713344); //16.7997426081006
const vec2 goldenOffset7 = vec2( 0.343038630874082,  0.939321296324125); //19.1997058378292
const vec2 goldenOffset8 = vec2( 0.38155640847493,  -0.924345556137807); //21.5996690675579
const vec2 goldenOffset9 = vec2(-0.905734272555614, -0.04619144594037 ); //23.9996322972865

float square(float x)        { return x * x; } //faster than pow().

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }
vec2  interpolateSmooth2(vec2 v)  { return v * v * (3.0 - 2.0 * v); }

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

#ifdef CLOUDS
	#ifdef OLD_CLOUDS
		//finds random value at location, as well as the slope at that location if needed.
		//happens to generate noise that looks similar to minecraft's native pixellated clouds.
		vec3 cloudNoise(vec2 coord, float size, float heightOffset, bool needNormals) {
			coord /= size;
			vec2 middle = fract(coord);
			vec4 corners = vec4(coord - middle + 0.5, 0.0, 0.0);
			corners.zw = corners.xy + 1.0;
			corners *= invNoiseRes;
			//vec4 corners = (vec4(floor(coord), ceil(coord)) + 0.5) * invNoiseRes;

			float r00 = texture2D(noisetex, corners.xy).r; //random value at the (0, 0) corner
			float r01 = texture2D(noisetex, corners.xw).r; //random value at the (0, 1) corner
			float r10 = texture2D(noisetex, corners.zy).r; //random value at the (1, 0) corner
			float r11 = texture2D(noisetex, corners.zw).r; //random value at the (1, 1) corner

			vec2 mixlvl = interpolateSmooth2(middle); //non-linear interpolation

			float height = mix(mix(r00, r10, mixlvl.x), mix(r01, r11, mixlvl.x), mixlvl.y) * 2.0 - 1.0 + heightOffset; //non-linear interpolation between the 4 corners
			if (needNormals && height > 0.0 && night < 0.999) {
				vec2 dmixlvl = interpolateSmooth2(1.0 - abs(middle * 2.0 - 1.0));

				float dx = mix((r00 - r10) * dmixlvl.x, (r01 - r11) * dmixlvl.x, mixlvl.y); //slope in x direction
				float dy = mix((r00 - r01) * dmixlvl.y, (r10 - r11) * dmixlvl.y, mixlvl.x); //slope in y direction
				return vec3(dx, dy, height);
			}
			else return vec3(0.0, 0.0, height);
		}

		//returns color and opacity of clouds
		vec4 drawClouds(in vec3 cloudPosPlayerSpace, in vec3 viewPosNorm, inout float height, in bool vshflag) {
			if ((night > 0.999 && rainStrength > 0.999) || blindness > 0.999) return vec4(0.0); //no point rendering clouds when you can't even see them.

			vec2 skyPos = cloudPosPlayerSpace.xz + eyePosition.xz;
			skyPos.x += frameTimeCounter / 1.5;
			float clumpingFactor = 1.5 * (cloudNoise(skyPos, 64.0, 0.0, false).z + wetness); //makes denser and less dense regions of clouds
			if (clumpingFactor > -1.0) {
				vec3 noiseData = cloudNoise(skyPos, 12.0, clumpingFactor, true);
				if (noiseData.z > 0.0) {
					if (height > 0.0) {
						height = 1.0 - height / noiseData.z;
						if (height < 0.0) return vec4(0.0);
					}
					vec3 color;
					//add more rough-ness to clouds. except at night, since they're solid black at night anyway. also less roughness at sunset, since it's more noticeable at sunset.
					if (night < 0.999) {
						vec2 moreNoise = vec2(0.0);
						moreNoise += texture2D(noisetex, skyPos / 3.5 * invNoiseRes).gb;
						moreNoise += texture2D(noisetex, skyPos       * invNoiseRes).gb / 4.0;
						moreNoise = (moreNoise / 2.5 - 0.25) * noiseData.z * (day + 1.0);
						noiseData.xy += moreNoise;

						vec3 normal = vec3(noiseData.x, noiseData.z * sign(eyePosition.y - CLOUD_HEIGHT), noiseData.y);
						if (vshflag) normal.y *= 1.0 - height; //interpolate normal Y value when flying through clouds
						normal = normalize(mat3(gbufferModelView) * normal); //rotate to be in view space, and normalize

						float lightAmt = dot(normal, sunPosNorm) * 0.5 + 0.5; //sun illumination
						if (eyePosition.y < CLOUD_HEIGHT) {
							lightAmt *= fogify(noiseData.z, 1.25); //decrease light near the centers of the underside of clouds
							lightAmt += square(max(dot(viewPosNorm, sunPosNorm) * 3.0 - 2.0, 0.0)) * fogify(noiseData.z - wetness * 0.5, 0.25); //allow sun to "shine through" clouds where density is low, and apply bonus when raining
						}
						else {
							lightAmt *= lightAmt; //add more contrast to the tops of clouds
						}

						color = mix(cloudColor, cloudIlluminationColor, lightAmt);
					}
					else {
						color = vec3(0.0);
					}

					float alpha = 1.0 - fogify(noiseData.z + clamp(clumpingFactor, 0.0, noiseData.z), 0.25);

					return vec4(color, alpha) * (1.0 - blindness);
				}
			}
			return vec4(0.0);
		}
	#else
		//finds random value at location, as well as the slope at that location if needed.
		vec3 cloudNoise(vec2 coord) {
			vec2 middle = fract(coord);
			vec4 corners = vec4(coord - middle + 0.5, 0.0, 0.0);
			corners.zw = corners.xy + 1.0;
			corners *= invNoiseRes;
			//vec4 corners = (vec4(floor(coord), ceil(coord)) + 0.5) * invNoiseRes;
			//ivec4 corners = ivec4(mod(vec4(floor(coord), ceil(coord)), noiseTextureResolution));

			float r00 = texture2D(noisetex, corners.xy).r; //random value at the (0, 0) corner
			float r01 = texture2D(noisetex, corners.xw).r; //random value at the (0, 1) corner
			float r10 = texture2D(noisetex, corners.zy).r; //random value at the (1, 0) corner
			float r11 = texture2D(noisetex, corners.zw).r; //random value at the (1, 1) corner

			vec2 mixlvl = interpolateSmooth2(middle); //non-linear interpolation

			float height = mix(mix(r00, r10, mixlvl.x), mix(r01, r11, mixlvl.x), mixlvl.y) - 0.5; //non-linear interpolation between the 4 corners
			#ifdef CLOUD_NORMALS
				vec2 dmixlvl = interpolateSmooth2(1.0 - abs(middle * 2.0 - 1.0));

				float dx = mix((r00 - r10) * dmixlvl.x, (r01 - r11) * dmixlvl.x, mixlvl.y); //slope in x direction
				float dy = mix((r00 - r01) * dmixlvl.y, (r10 - r11) * dmixlvl.y, mixlvl.x); //slope in y direction
				return vec3(dx, dy, height);
			#else
				return vec3(0.0, 0.0, height);
			#endif
		}

		//returns color and opacity of clouds
		vec4 drawClouds(in vec3 cloudPosPlayerSpace, in vec3 viewPosNorm, inout float height, in bool vshflag) {
			if ((night > 0.999 && rainStrength > 0.999) || blindness > 0.999) return vec4(0.0); //no point rendering clouds when you can't even see them.

			vec2 skyPos = cloudPosPlayerSpace.xz + eyePosition.xz;
			skyPos.x += frameTimeCounter; //apply wind

			skyPos *= 0.00390625; //scale
			float time = frameTimeCounter * 0.0078125;
			vec3 noise = vec3(0.0); //x and y = normal data, z = height

			noise += cloudNoise((skyPos + time * goldenOffset0)       ) * 2.0;
			noise += cloudNoise((skyPos + time * goldenOffset1) * 2.0 );
			noise += cloudNoise((skyPos + time * goldenOffset2) * 4.0 ) * 0.5;
			noise += cloudNoise((skyPos + time * goldenOffset3) * 8.0 ) * 0.25;
			noise += cloudNoise((skyPos + time * goldenOffset4) * 16.0) * 0.125;

			//add more detail without calculating interpolation or normals (since both of those are slower than fetching a single random number)
			skyPos *= invNoiseRes;
			time *= invNoiseRes;
			noise.z += texture2D(noisetex, (skyPos + time * goldenOffset5) * 32.0 ).r * 0.0625;
			noise.z += texture2D(noisetex, (skyPos + time * goldenOffset6) * 64.0 ).r * 0.03125;
			noise.z += texture2D(noisetex, (skyPos + time * goldenOffset7) * 128.0).r * 0.015625;
			noise.z += texture2D(noisetex, (skyPos + time * goldenOffset8) * 256.0).r * 0.0078125;
			noise.z += texture2D(noisetex, (skyPos + time * goldenOffset9) * 512.0).r * 0.00390625;

			noise.z += cloudDensityModifier; //random density fluctuations every few minutes
			noise.z /= max(cloudDensityModifier, 0.0) + 1.0; //scale so as not to be solid gray when density is ludicrously high
			noise.z += wetness; //bias when raining

			if (noise.z > 0.0) { //there are clouds here
				if (height > 0.0) { //volumetric effect handling (scale opacityModifier based on density of clouds)
					height = 1.0 - height / (1.0 - fogify(noise.z, 0.125));
					if (height < 0.0) return vec4(0.0); //clouds not dense enough for volumetric effects to apply.
				}
				#ifdef CLOUD_NORMALS
					vec3 normal = vec3(noise.x, noise.z * sign(eyePosition.y - CLOUD_HEIGHT), noise.y);
					if (vshflag) normal.y *= 1.0 - height; //interpolate normal Y value when flying through clouds
					normal = normalize(mat3(gbufferModelView) * normal); //rotate to be in view space, and normalize

					vec2 lightAmt = vec2(dot(normal, sunPosNorm), dot(normal, -sunPosNorm)) * 0.5 + 0.5; //sun and moon illumination
					if (eyePosition.y < CLOUD_HEIGHT) {
						lightAmt *= fogify(noise.z, 0.5); //decrease light near the centers of the underside of clouds
						lightAmt.x *= 1.0 - rainStrength * 0.75; //less sunlight during rain.
						lightAmt.x += square(max(dot(viewPosNorm, sunPosNorm) * 3.0 - 2.0, 0.0)) * fogify(noise.z, 0.25) * (1.0 - rainStrength * 0.5); //allow sun to "shine through" clouds where density is low, and with slight bonus during rain (compared to everywhere else anyway)_
					}
					else lightAmt *= lightAmt; //add more contrast to the tops of clouds

					vec3 color = mix(cloudColor, cloudIlluminationColor, lightAmt.x); //colorize
					color += mix(vec3(0.01, 0.02, 0.03), vec3(0.1, 0.15, 0.25), lightAmt.y * phase) * night * (1.0 - rainStrength); //add lunar illumination
					float alpha = 1.0 - fogify(noise.z , 0.0625); //more opaque in center, less opaque around edges
					return vec4(color, alpha) * (1.0 - blindness);
				#else
					float lightAmt = fogify(noise.z, 0.25); //more light on edges than center
					if (eyePosition.y > CLOUD_HEIGHT) lightAmt = lightAmt * -0.5 + 1.0; //reverse and scale when above clouds

					vec3 color = mix(cloudColor, cloudIlluminationColor, lightAmt); //colorize
					color += mix(vec3(0.01, 0.02, 0.03), vec3(0.1, 0.15, 0.25), lightAmt) * night * phase * (1.0 - rainStrength); //add lunar illumination
					float alpha = 1.0 - fogify(noise.z, 0.0625); //more opaque in center, less opaque around edges
					return vec4(color, alpha) * (1.0 - blindness);
				#endif
			}
			return vec4(0.0);
		}
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