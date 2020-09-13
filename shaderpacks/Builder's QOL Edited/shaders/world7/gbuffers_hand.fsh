#version 120

//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings
#define THRESHOLD_ALPHA 0.6 //Anything above this opacity counts as part of the border of stained glass, and will not apply blur/reflection effects [0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95]
//#define VANILLA_LIGHTMAP //Uses vanilla light colors instead of custom ones. Requires optifine 1.12.2 HD_U_D1 or later!
#define VIGNETTE //Reduces the brightness of dynamic light around edges the of your screen

uniform float blindness;
uniform float far;
uniform float fov;
uniform float nightVision;
uniform float pixelSizeX;
uniform float pixelSizeY;
uniform float screenBrightness;
uniform ivec2 eyeBrightnessSmooth;
uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec3 skyColor;

varying float mcentity;
varying vec2 lmcoord;
varying vec2 texcoord;

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 normal;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

struct Position {
	vec3 view;
	vec3 viewNorm;
	float blockDist;
	float viewDist;
};

float square(float x)        { return x * x; } //faster than pow().

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }

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

void main() {
	Position pos;
	pos.view = vPosView;
	pos.blockDist = length(pos.view);
	pos.viewNorm = pos.view / pos.blockDist;

	pos.blockDist = 1.0; //spoof for hand.
	pos.viewDist = pos.blockDist / far;

	vec4 color = texture2D(texture, texcoord);
	int id = int(mcentity);
	if (id == 2 && color.a > THRESHOLD_ALPHA) id = 0; //opacity threshold for border of stained glass

	float skylight = lmcoord.y * lmcoord.y;
	float blocklight = square(max(lmcoord.x - skylight * 0.5, 0.0));
	float heldlight = 0.0;

	color.rgb *= calcMainLightColor(blocklight, skylight, heldlight, pos);
	color *= glcolor;

	#ifdef CROSS_PROCESS
		//vec3(color.g + color.b, color.r + color.b, color.r + color.g)
		color.rgb = clamp(color.rgb * crossProcessColor - (color.grr + color.bbg) * 0.1, 0.0, 1.0);
	#endif

	if (blindness > 0.0) color.rgb *= interpolateSmooth1(max(1.0 - pos.blockDist * 0.2, 0.0)) * 0.5 * blindness + (1.0 - blindness);

/* DRAWBUFFERS:024 */
	gl_FragData[0] = color; //gcolor
	gl_FragData[1] = vec4(normal, 1.0); //gnormal
	gl_FragData[2] = vec4(lmcoord, id * 0.1, 1.0); //gaux1
}