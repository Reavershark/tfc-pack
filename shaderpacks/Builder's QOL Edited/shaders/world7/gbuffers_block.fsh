#version 120

//#define BRIGHT_PORTAL_FIX //Enable this if end portals are 16x brighter than they should be
//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
//#define CUBIC_CHUNKS //Disables black fog/sky colors below Y=0
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings
#define END_PORTAL_BACKGROUND_TF 2 //1: Use overworld fog color. 2: Use end background. [1 2]
#define END_PORTAL_CLOUDS_TF 2 //0: No clouds. 1: Use overworld clouds. 2: Use void clouds. [0 1 2]
#define END_PORTAL_EFFECTS_TF //Enables fancy effects for end portals
#define END_PORTAL_FOREGROUND_TF 2 //0: No foreground image. 1: Use overworld screenshot. 2: Use end island screenshot. [0 1 2]
#define ENDER_ARCS //Adds bolts of plasma that arc through the nebulae. Requires ender nebulae to be enabled!
#define ENDER_NEBULAE //Adds animated nebulae to the background of the end dimension
#define ENDER_STARS //Adds blinking stars to the background of the end dimension. Stackable with nebulae/plasma.
#define FOG_DISTANCE_MULTIPLIER_TF 0.25 //How far away fog starts to appear in the twilight forest [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 4.5 5.0 6.0 7.0 8.0 9.0 10.0]
#define FOG_ENABLED_TF //Enables fog in the twilight forest
//#define OLD_CLOUDS //Uses old cloud rendering method from earlier versions, for people who don't like pretty things.
#define UNDERWATER_FOG //Applies fog to water
//#define VANILLA_LIGHTMAP //Uses vanilla light colors instead of custom ones. Requires optifine 1.12.2 HD_U_D1 or later!
#define VIGNETTE //Reduces the brightness of dynamic light around edges the of your screen
#define WATER_ABSORB_B 0.10 //Blue component of the water absorption color [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define WATER_ABSORB_G 0.05 //Green component of the water absorption color [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define WATER_ABSORB_R 0.20 //Red component of the water absorption color [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define WATER_SCATTER_B 0.50 //Blue component of the water fog color [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define WATER_SCATTER_G 0.40 //Green component of the water fog color [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define WATER_SCATTER_R 0.05 //Red component of the water fog color [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]

uniform float blindness;
uniform float far;
uniform float fov;
uniform float frameTimeCounter;
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float screenBrightness;
uniform int blockEntityId;
uniform int isEyeInWater;
uniform ivec2 eyeBrightness;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D gaux1; //Overworld texture
uniform sampler2D gaux2; //End island texture
uniform sampler2D lightmap;
uniform sampler2D noisetex;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 lmcoord;
varying vec2 texcoord;

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 vPosPlayer;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

struct Position {
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist;
	float viewDist;
};

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

float square(float x)        { return x * x; } //faster than pow().
float lengthSquared2(vec2 v) { return dot(v, v); }

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }
vec2  interpolateSmooth2(vec2 v)  { return v * v * (3.0 - 2.0 * v); }

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

vec3 calcMainLightColor(in float blocklight, in float skylight, inout float heldlight, inout Position pos) {

	#ifdef VANILLA_LIGHTMAP
		vec3 lightclr = texture2D(lightmap, lmcoord).rgb;
	#else
		vec3 lightclr = vec3(0.0);
		lightclr += mix(vec3(1.0, 0.5, 0.15), vec3(1.0, 0.85, 0.7), eyeBrightnessSmooth.x / 240.0) * blocklight; //blocklight
		lightclr += mix(skyColor, vec3(1.0), skylight) * skylight; //skylight
		lightclr += clamp(nightVision, 0.0, 1.0) * vec3(0.375, 0.375, 0.5) + clamp(screenBrightness, 0.0, 1.0) * 0.1;
	#endif

	#ifdef DYNAMIC_LIGHTS
		if (heldLightColor.a > 0.0) {
			float heldLightDist = pos.blockDist * fov / heldLightColor.a;
			if (heldLightDist < 1.0) {
				heldlight = (heldLightDist - log(heldLightDist) - 1.0) * heldLightColor.a / (blocklight * 64.0 + 32.0);
				#ifdef VIGNETTE
					vec2 screenPos = gl_FragCoord.xy * vec2(pixelSizeX, pixelSizeY); //0 to 1 range
					screenPos = screenPos * 2.0 - 1.0; //-1 to +1 range
					screenPos = 1.0 - screenPos * screenPos;
					float multiplier = screenPos.x * screenPos.y;
					multiplier = multiplier * 0.5 + 0.5;
					heldlight *= multiplier;
				#endif
				lightclr += heldLightColor.rgb * heldlight;
			}
		}
	#endif

	return lightclr;
}

vec3 calcFogColor(vec3 playerPosNorm) {
	#ifndef CUBIC_CHUNKS
		if (eyePosition.y < 0.0) return vec3(0.0);
	#endif

	return mix(skyColor, fogColor, fogify(max(playerPosNorm.y, 0.0), 0.0625));
}

vec3 calcUnderwaterFogColor(vec3 color, float dist, float brightness) {
	dist *= far;

	vec3 absorb = exp2(-dist * vec3(WATER_ABSORB_R, WATER_ABSORB_G, WATER_ABSORB_B));
	vec3 scatter = vec3(WATER_SCATTER_R, WATER_SCATTER_G, WATER_SCATTER_B) * (1.0 - absorb) * brightness;
	return color * absorb + scatter;
}

#ifdef END_PORTAL_EFFECTS_TF
	vec3 hue(float h) {
		h = fract(h) * 6.0;
		return clamp(
			vec3(
				abs(h - 3.0) - 1.0,
				2.0 - abs(h - 2.0),
				2.0 - abs(h - 4.0)
			),
			0.0,
			1.0
		);
	}

	#if END_PORTAL_BACKGROUND_TF == 2
		#ifdef ENDER_NEBULAE
			float random(vec2 coord) {
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

				return mix(mix(r00, r10, mixlvl.x), mix(r01, r11, mixlvl.x), mixlvl.y); //linear interpolation between the 4 corners
			}

			//base noise algorithm for the overall cloud pattern. ranges from -1.0 to 1.0
			float cloudNoise(vec2 pos) {
				float noise = -0.32992;
				noise += random(pos * 2.0  + goldenOffset0 * frameTimeCounter * 0.125  ) * 0.4;
				noise += random(pos * 4.0  + goldenOffset1 * frameTimeCounter * 0.0625 ) * 0.16;
				noise += random(pos * 8.0  + goldenOffset2 * frameTimeCounter * 0.04166) * 0.064;
				noise += random(pos * 16.0 + goldenOffset3 * frameTimeCounter * 0.03125) * 0.0256;
				noise += random(pos * 32.0 + goldenOffset4 * frameTimeCounter * 0.025  ) * 0.01024;
				return noise;
			}

			//noise algorithm for all the different colors
			//doesn't need as many iterations as cloudNoise() because it doesn't need to be as "rough"
			//also has different speed/effect multipliers in order to fit the values I want to get out of hue().
			float colorNoise(vec2 pos) {
				float noise = 0.4;
				noise += random(pos * 2.0 + goldenOffset5 * frameTimeCounter * 0.5 ) * 0.25;
				noise += random(pos * 4.0 + goldenOffset6 * frameTimeCounter * 0.25) * 0.125;
				noise += random(pos * 8.0 + goldenOffset7 * frameTimeCounter * 0.16) * 0.0625;
				return noise;
			}

			//both of these functions are quite similar, just with some slight differences in the math.
			#ifdef ENDER_ARCS
				vec4 drawNebulae(vec2 pos) {
					float noise = abs(cloudNoise(pos)); //density depends on how close cloudNoise() is to 0.0
					if (noise < 0.25) { //alpha calculations work within the range 0 - 0.25
						vec3 baseclr = hue(colorNoise(pos)) * 0.625; //nebulae color at this position
						float arclight = square(max(0.7 - noise * 8.0, 0.0)); //brighten areas that are very close to an arc (when cloudNoise() is close to 0.0)
						return vec4(mix(baseclr, vec3(1.0), arclight), square(1.0 - noise * 4.0) * 0.9); //alpha also depends on how close to an arc we are
					}
					else return vec4(0.0); //was not part of a nebula
				}
			#else
				vec4 drawNebulae(vec2 pos) {
					float noise = cloudNoise(pos); //density depends on how close cloudNoise() is to 1.0
					if (noise > 0.0) {
						vec3 baseclr = hue(colorNoise(pos)) * 0.625; //nebulae color at this position
						baseclr += 1.0 - 0.1 / (noise * noise + 0.1); //brighten areas that are close to the "center" of the nebulae (when cloudNoise() is close to 1.0)
						return vec4(baseclr, 1.0 - 0.02 / (noise * noise + 0.02)); //alpha also depends on how close to the "center" of the nebulae we are
					}
					else return vec4(0.0);
				}
			#endif
		#endif

		#ifdef ENDER_STARS
			float fade(float speed, float delay) {
				float newTime = mod(frameTimeCounter * speed, delay);
				//newTime / threshold
				if (newTime < 0.1) return newTime * 10.0;
				//1.0 - (newTime / (1.0 - threshold)) + (threshold / (1.0 - threshold));
				else return newTime * -1.1111111111111111 + 1.1111111111111111;
			}

			vec3 drawStars(vec2 pos) {
				pos *= 16.0; //increase density of stars by a factor of 16x.
				vec2 newpos = floor(pos) + 0.5; //position rounded to the nearest "square". you can immagine this imposing a grid pattern onto the sky.

				//r = random chance that this square will be a star, g = fade animation speed, b = delay before re-appearing
				//r is also used to store "brightness" of the star. if the star is above 75% brightness to start with, it gets to be rendered. (this check is ignored for ender portals)
				vec3 starData1 = texture2D(noisetex, newpos * invNoiseRes).rgb;
				float fadeAmt = fade(starData1.g * 0.1 + 0.15, starData1.b * 8.0 + 1.0);

				if (starData1.r > 0.75 && fadeAmt > 0.0) { //25% of all the "squares" in the sky will be stars
					//r = type (star-shaped vs. circular), g = size multiplier, b = color
					vec3 starData2 = texture2D(noisetex, -newpos * invNoiseRes).rgb;

					float dist;
					//star-shaped stars are smaller than circular ones, so making more of them to compensate.
					if (starData2.r < 0.25) dist = length(pos - newpos) * 2.0; //pythagorean distance
					else { //star-shaped distance (distance increases faster diagonally than cardinally)
						vec2 v = sqrt(abs(pos - newpos));
						dist = v.x + v.y;
					}

					dist *= starData2.g + 1.0; //apply random size modifier. increasing the distance has the effect of decreasing the size, since smaller distances get scaled up to the maximum distance
					dist += 1.0 - fadeAmt; //apply fading animation. again, increasing distance decreases size. when fadeAmt = 0, the star will be invisible.

					float amt = square(max(1.0 - dist, 0.0)); //apply distance calculations to brightness of the star. The closer we are to the center, the brighter it should be.

					vec3 clr = hue(starData2.b * 0.6 - 0.35) * 0.625 + 0.375; //calculate color of star based on random number.
					clr = clr * amt + amt * amt * 0.625; //actually colorize star, and make whiter near the center.

					//make some stars brighter than others
					clr *= starData1.r * 2.0 - 1.0;

					return clr;
				}
				return vec3(0.0);
			}
		#endif
	#endif

	#if END_PORTAL_CLOUDS_TF == 1
		#ifdef OLD_CLOUDS
			float cloudNoise(vec2 coord, float size) {
				coord /= size;
				vec4 corners = (vec4(floor(coord), ceil(coord)) + 0.5) * invNoiseRes;

				float r00 = texture2D(noisetex, corners.xy).r; //random value at the (0, 0) corner
				float r01 = texture2D(noisetex, corners.xw).r; //random value at the (0, 1) corner
				float r10 = texture2D(noisetex, corners.zy).r; //random value at the (1, 0) corner
				float r11 = texture2D(noisetex, corners.zw).r; //random value at the (1, 1) corner

				vec2 mixlvl = interpolateSmooth2(fract(coord));

				return mix(mix(r00, r10, mixlvl.x), mix(r01, r11, mixlvl.x), mixlvl.y) * 2.0 - 1.0; //non-linear interpolation between the 4 corners
			}

			vec4 drawClouds(vec2 pos) {
				pos *= 128.0;
				pos.x += frameTimeCounter; //apply wind

				float noise = 0.0;
				noise += cloudNoise(pos, 64.0) * 1.5;
				noise += cloudNoise(pos, 12.0);

				pos *= invNoiseRes;
				float colorNoise = 0.0;
				colorNoise += texture2D(noisetex, pos * 0.25).r - 0.5;
				colorNoise += texture2D(noisetex, pos       ).r * 0.5 - 0.25;
				colorNoise *= noise;

				if (noise > 0.0) { //there are clouds here
					return vec4(mix(vec3(1.0, 1.0, 1.0), vec3(0.48, 0.5, 0.55), fogify(noise - colorNoise, 0.25)), 1.0 - fogify(noise, 0.0625));
				}
				return vec4(0.0);
			}
		#else
			//returns color and opacity of clouds
			vec4 drawClouds(vec2 pos) {
				float time = frameTimeCounter * invNoiseRes;
				pos.x += time; //apply wind
				pos *= invNoiseRes * 4.0;
				time *= 0.015625;

				float noise = 0.0;
				noise += (texture2D(noisetex, (pos + time * goldenOffset0)        ).r - 0.5) * 2.0;
				noise += (texture2D(noisetex, (pos + time * goldenOffset1) * 2.0  ).r - 0.5);
				noise += (texture2D(noisetex, (pos + time * goldenOffset2) * 4.0  ).r - 0.5) * 0.5;
				noise += (texture2D(noisetex, (pos + time * goldenOffset3) * 8.0  ).r - 0.5) * 0.25;
				noise += (texture2D(noisetex, (pos + time * goldenOffset4) * 16.0 ).r - 0.5) * 0.125;
				noise += (texture2D(noisetex, (pos + time * goldenOffset5) * 32.0 ).r - 0.5) * 0.0625;
				noise += (texture2D(noisetex, (pos + time * goldenOffset6) * 64.0 ).r - 0.5) * 0.03125;
				noise += (texture2D(noisetex, (pos + time * goldenOffset7) * 128.0).r - 0.5) * 0.015625;

				if (noise > 0.0) { //there are clouds here
					return vec4(mix(vec3(1.0, 1.0, 1.0), vec3(0.48, 0.5, 0.55), fogify(noise, 0.25)), 1.0 - fogify(noise, 0.0625));
				}
				return vec4(0.0);
			}
		#endif
	#elif END_PORTAL_CLOUDS_TF == 2
		vec4 drawVoidClouds(vec2 pos) {
			vec2 cloudPos = pos * invNoiseRes;
			float time = frameTimeCounter * invNoiseRes * 2.0;

			float noise = -1.0;
			noise += texture2D(noisetex, (cloudPos + goldenOffset0 * time) * 0.00390625).r;
			noise += texture2D(noisetex, (cloudPos + goldenOffset1 * time) * 0.0078125 ).r * 0.6;
			noise += texture2D(noisetex, (cloudPos + goldenOffset2 * time) * 0.015625  ).r * 0.36;
			noise += texture2D(noisetex, (cloudPos + goldenOffset3 * time) * 0.03125   ).r * 0.216;
			noise += texture2D(noisetex, (cloudPos + goldenOffset4 * time) * 0.0625    ).r * 0.1296;
			noise += texture2D(noisetex, (cloudPos + goldenOffset5 * time) * 0.125     ).r * 0.07776;
			noise += texture2D(noisetex, (cloudPos + goldenOffset6 * time) * 0.25      ).r * 0.046656;
			noise += texture2D(noisetex, (cloudPos + goldenOffset7 * time) * 0.5       ).r * 0.0279936;

			if (noise > 0.0) { //there are indeed clouds here
				vec3 color = vec3(noise * 0.125); //base cloud color

				vec3 data = texture2D(noisetex, (floor((pos + vec2(frameTimeCounter, 0.0)) * 2.0) + 0.5) * invNoiseRes).rgb; //r = hue, gb = another random offset
				float amt = texture2D(noisetex, data.gb * time * 0.125).r; //base brightness of square
				amt = max(amt * 8.0 - 8.0 + square(noise * 1.375), 0.0); //add bias so that there are more squares where cloud density is high
				color += hue(data.r * 0.35 + 0.45) * amt; //color of square

				return vec4(color, interpolateSmooth1(min(noise * 1.5, 1.0)));
			}
			else return vec4(0.0);
		}
	#endif
#endif

void main() {
	Position pos;
	pos.view = vPosView;
	pos.player = vPosPlayer;
	pos.world = vPosPlayer + eyePosition;
	pos.blockDist = length(pos.view);
	pos.viewDist = pos.blockDist / far;
	pos.viewNorm = pos.view / pos.blockDist;
	pos.playerNorm = pos.player / pos.blockDist;

	vec4 color = texture2D(texture, texcoord);

	float skylight = lmcoord.y * lmcoord.y;
	float blocklight = square(max(lmcoord.x - skylight * 0.5, 0.0));
	float heldlight = 0.0;

	#ifdef END_PORTAL_EFFECTS_TF
		if (blockEntityId == 119) {
			vec2 backgroundPos = pos.player.xz / pos.player.y;

			#if END_PORTAL_BACKGROUND_TF == 1 //overworld fog color
				color = vec4(0.75, 0.875, 1.0, 1.0);
			#elif END_PORTAL_BACKGROUND_TF == 2 //end background
				//draw background noise, matching vanilla end sky texture as closely as possible
				float n = texture2D(noisetex, (floor(backgroundPos * 256.0) + 0.5) * invNoiseRes).r * 2.0 - 1.0; //get random noise value between -1.0 and 1.0
				float n4 = square(square(n)); //bias towards 0 by raising to the 4'th power. also always positive because 4 is even, so don't need to take absolute value.
				color.rgb = vec3(0.46, 0.34, 0.65); //base color
				if (n > 0.0) color.rgb = mix(color.rgb, vec3(1.0), n4 * 0.55); //bright areas
				else         color.rgb = mix(color.rgb, vec3(0.0), n4 * 0.7); //dark areas
				color.rgb *= 0.16; //match vanilla brightness (40/255 ~= 0.16)

				vec2 endProjectionPos = pos.playerNorm.xz / (pos.playerNorm.y + 1.0);
				float multiplier = 8.0 / (lengthSquared2(endProjectionPos) + 8.0); //wrapping behavior produces a mathematical singularity below you, so this hides that.

				#ifdef ENDER_NEBULAE
					vec4 cloudclr = drawNebulae(endProjectionPos);
					color.rgb = mix(color.rgb, cloudclr.rgb, cloudclr.a * multiplier);
				#endif

				#ifdef ENDER_STARS
					vec3 starclr = drawStars(endProjectionPos);
					color.rgb += starclr * multiplier;
				#endif
			#endif

			#if END_PORTAL_FOREGROUND_TF == 1 //overworld screenshot
				vec4 islandImage = texture2D(gaux1, backgroundPos * 0.25 + 0.5);
				color.rgb = mix(color.rgb, islandImage.rgb, islandImage.a);
			#elif END_PORTAL_FOREGROUND_TF == 2 //end screenshot
				vec4 islandImage = texture2D(gaux2, backgroundPos + 0.5);
				color.rgb = mix(color.rgb, islandImage.rgb, islandImage.a);
			#endif

			#if END_PORTAL_CLOUDS_TF == 1 //overworld clouds
				vec2 projectedPos = (pos.player.xz / pos.player.y) * 0.25 + 0.5;
				vec4 cloudColor = drawClouds(projectedPos);
				color.rgb = mix(color.rgb, cloudColor.rgb, cloudColor.a);
			#elif END_PORTAL_CLOUDS_TF == 2 //void clouds
				vec4 cloudColor = drawVoidClouds(backgroundPos * 64.0);
				color.rgb = mix(color.rgb, cloudColor.rgb, cloudColor.a);
			#endif

			#ifdef BRIGHT_PORTAL_FIX
				color.rgb *= 0.0625;
			#endif
		}
		else {
	#endif
			color.rgb *= calcMainLightColor(blocklight, skylight, heldlight, pos);
			color *= glcolor;
	#ifdef END_PORTAL_EFFECTS_TF
		}
	#endif

	#ifdef CROSS_PROCESS
		//vec3(color.g + color.b, color.r + color.b, color.r + color.g)
		color.rgb = clamp(color.rgb * crossProcessColor - (color.grr + color.bbg) * 0.1, 0.0, 1.0);
	#endif

	#ifdef UNDERWATER_FOG
		if (isEyeInWater == 1) {
			color.rgb = calcUnderwaterFogColor(color.rgb, pos.blockDist, eyeBrightnessSmooth.y / 240.0);
		}
		else {
	#endif
			#ifdef FOG_ENABLED_TF
				float density = pos.viewDist - 0.2; //wetness * 0.3 * eyeBrightness / 240.0
				if (density > 0.0) {
					density = fogify(density * exp2(1.5 - pos.world.y * 0.015625), FOG_DISTANCE_MULTIPLIER_TF);
					color.rgb = mix(calcFogColor(pos.playerNorm) * min(max(lmcoord.y * 2.0, eyeBrightness.y / 120.0), 1.0), color.rgb, density);
				}
			#endif
	#ifdef UNDERWATER_FOG
		}
	#endif

	if (blindness > 0.0) color.rgb *= interpolateSmooth1(max(1.0 - pos.blockDist * 0.2, 0.0)) * 0.5 * blindness + (1.0 - blindness);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}