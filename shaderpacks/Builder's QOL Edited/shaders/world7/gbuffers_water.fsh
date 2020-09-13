#version 120

#define CLEAR_WATER //Overwrites water texture to be completely transparent
//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
//#define CUBIC_CHUNKS //Disables black fog/sky colors below Y=0
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings
#define FOG_DISTANCE_MULTIPLIER_TF 0.25 //How far away fog starts to appear in the twilight forest [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 4.5 5.0 6.0 7.0 8.0 9.0 10.0]
#define FOG_ENABLED_TF //Enables fog in the twilight forest
#define THRESHOLD_ALPHA 0.6 //Anything above this opacity counts as part of the border of stained glass, and will not apply blur/reflection effects [0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95]
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
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float screenBrightness;
uniform int isEyeInWater;
uniform ivec2 eyeBrightness;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D gaux3;
uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying float glmult;
varying float mcentity;
varying vec2 lmcoord;
varying vec2 texcoord;

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 normal;
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

float square(float x)        { return x * x; } //faster than pow().

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }

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

//simpler algorithm for the special case where distance = infinity (for infinite oceans)
vec3 calcUnderwaterFogColorInfinity(float brightness) {
	return vec3(WATER_SCATTER_R, WATER_SCATTER_G, WATER_SCATTER_B) * brightness;
}

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
	int id = int(mcentity);
	if (id == 2 && color.a > THRESHOLD_ALPHA) id = 0; //opacity threshold for border of stained glass

	float skylight = lmcoord.y * lmcoord.y;
	float blocklight = square(max(lmcoord.x - skylight * 0.5, 0.0));
	float heldlight = 0.0;

	color.rgb *= calcMainLightColor(blocklight, skylight, heldlight, pos);
	vec4 multiplier = glcolor;
	multiplier.rgb *= mix(glmult, 1.0, max(blocklight, heldlight) * 0.5);
	color *= multiplier;

	if (id == 1) {
		if (isEyeInWater == 0) {
			vec2 tc = gl_FragCoord.xy * vec2(pixelSizeX, pixelSizeY);
			vec3 behindPos = vec3(tc, texture2D(gaux3, tc));
			bool sky = behindPos.z == 1.0;
			vec4 tmp = gbufferProjectionInverse * vec4(behindPos * 2.0 - 1.0, 1.0);
			behindPos = tmp.xyz / tmp.w;

			vec4 origColor = color;

			if (sky) {
				color = vec4(calcUnderwaterFogColorInfinity(skylight), 1.0);
			}
			else {
				#ifdef UNDERWATER_FOG
					vec3 fogclr = calcUnderwaterFogColorInfinity(skylight);
					float opacity = 1.0 - exp2((pos.blockDist - length(behindPos)) * 0.125);
					color = vec4(fogclr, opacity);
				#else
					color = vec4(0.0);
				#endif
			}

			#ifndef CLEAR_WATER
				color.rgb = mix(color.rgb, origColor.rgb, origColor.a);
				color.a = mix(color.a, 1.0, origColor.a);
			#endif
		}
		#ifdef CLEAR_WATER
			else color = vec4(0.0);
		#endif
	}

	#ifdef CROSS_PROCESS
		//vec3(color.g + color.b, color.r + color.b, color.r + color.g)
		color.rgb = clamp(color.rgb * crossProcessColor - (color.grr + color.bbg) * 0.1, 0.0, 1.0);
	#endif

	if (id == 0) {
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
	}

	if (blindness > 0.0) color.rgb *= interpolateSmooth1(max(1.0 - pos.blockDist * 0.2, 0.0)) * 0.5 * blindness + (1.0 - blindness);

/* DRAWBUFFERS:204 */
	gl_FragData[0] = vec4(normal, 1.0); //gnormal; writing here first to ensure that it ALWAYS writes ID data, even when opacity is 0.
	gl_FragData[1] = color; //gcolor
	gl_FragData[2] = vec4(lmcoord, id * 0.1, 1.0); //gaux1
}