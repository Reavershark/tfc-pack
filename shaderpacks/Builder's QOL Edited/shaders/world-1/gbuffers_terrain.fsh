#version 120

#define AMBIENT_LIGHT_COLOR_NETHER_BLUE 0.05 //Blue component of the ambient light color in the nether [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define AMBIENT_LIGHT_COLOR_NETHER_GREEN 0.10 //Green component of the ambient light color in the nether [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define AMBIENT_LIGHT_COLOR_NETHER_RED 0.20 //Red component of the ambient light color in the nether [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings
#define FOG_DISTANCE_MULTIPLIER_NETHER 1.0 //How much overall fog there is in the nether [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 4.5 5.0 6.0 7.0 8.0 9.0 10.0]
#define FOG_ENABLED_NETHER //Enables fog in the nether
#define GRASS_AO //Adds ambient occlusion to tallgrass/flowers/etc... Works best with "Remove Y Offset" enabled.
#define LAVA_PATCHES //Randomizes lava brightness, similar to grass patches
//#define VANILLA_LIGHTMAP //Uses vanilla light colors instead of custom ones. Requires optifine 1.12.2 HD_U_D1 or later!
#define VIGNETTE //Reduces the brightness of dynamic light around edges the of your screen

uniform float blindness;
uniform float far;
uniform float fov;
uniform float frameTimeCounter;
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float screenBrightness;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D lightmap;
uniform sampler2D noisetex;
uniform sampler2D texture;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying float ao;
varying float isLava;
varying vec2 lmcoord;
varying vec2 randCoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

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

float square(float x)        { return x * x; } //faster than pow().

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

vec3 calcMainLightColor(in float blocklight, inout float heldlight, inout Position pos) {

	#ifdef VANILLA_LIGHTMAP
		vec3 lightclr = texture2D(lightmap, lmcoord).rgb;
	#else
		vec3 lightclr = vec3(0.0);
		lightclr += blockLightColor * blocklight; //blocklight
		lightclr += vec3(AMBIENT_LIGHT_COLOR_NETHER_RED, AMBIENT_LIGHT_COLOR_NETHER_GREEN, AMBIENT_LIGHT_COLOR_NETHER_BLUE); //skylight
		lightclr += clamp(nightVision, 0.0, 1.0) * vec3(0.375, 0.375, 0.5);
		lightclr += clamp(screenBrightness, 0.0, 1.0) * 0.1;
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

#ifdef FOG_ENABLED_NETHER
	vec3 calcFogColor(inout Position pos) {
		vec3 fogclr = fogColor * (1.0 - nightVision * 0.5);
		float oldBrightness = (fogclr.r + fogclr.g + fogclr.b) * 0.33333333;
		float newBrightness = oldBrightness * 0.25 / (oldBrightness + 0.25);
		fogclr *= newBrightness / oldBrightness;
		float n = square(texture2D(noisetex, frameTimeCounter * vec2(0.21562, 0.19361) * invNoiseRes).r) - 0.1;
		if (n > 0.0) {
			vec3 brightFog = vec3(
				fogclr.r * (n + 1.0),
				mix(fogclr.g, max(fogclr.r, fogclr.b * 2.0), n),
				fogclr.b
			);
			return mix(fogclr, brightFog, fogify(pos.playerNorm.y, 0.125));
		}
		else {
			return fogclr;
		}
	}
#endif

#ifdef LAVA_PATCHES
	float noiseMap(vec2 coord) {
		coord *= invNoiseRes;
		float noise = 0.0;
		noise += texture2D(noisetex, coord * 0.03125).r;
		noise += texture2D(noisetex, coord * 0.09375).r * 0.5;
		noise += texture2D(noisetex, coord * 0.375  ).r * 0.25;
		return noise;
	}
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

	#ifdef GRASS_AO
		if (ao < 0.99) color.rgb *= sqrt(ao) * 0.5 + 0.5;
	#endif

	#ifdef LAVA_PATCHES
		if (isLava > 0.9) {
			color.rgb += cos(noiseMap(randCoord) * 12.5 + frameTimeCounter * 0.5) * 0.125;
		}
	#endif

	float blocklight = lmcoord.x * lmcoord.x;
	float heldlight = 0.0;

	color.rgb *= calcMainLightColor(blocklight, heldlight, pos);

	color *= glcolor;

	#ifdef CROSS_PROCESS
		//vec3(color.g + color.b, color.r + color.b, color.r + color.g)
		color.rgb = clamp(color.rgb * crossProcessColor - (color.grr + color.bbg) * 0.1, 0.0, 1.0);
	#endif

	#ifdef FOG_ENABLED_NETHER
		color.rgb = mix(
			calcFogColor(pos),
			color.rgb,
			exp2(
				pos.viewDist
				* exp2(abs(pos.world.y - 128.0) * -0.03125 + 4.0)
				* -FOG_DISTANCE_MULTIPLIER_NETHER
			)
		);
	#endif

	if (blindness > 0.0) color.rgb *= interpolateSmooth1(max(1.0 - pos.blockDist * 0.2, 0.0)) * 0.5 * blindness + (1.0 - blindness);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}