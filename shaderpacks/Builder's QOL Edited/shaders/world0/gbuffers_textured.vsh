#version 120

//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings
#define HARDCORE_DARKNESS 0 //0 (Off): Normal visibility at night. 1 (On): Complete darkness at night. 2 (Moon phase) Nighttime brightness is determined by the current phase of the moon. [0 1 2]
#define SUNSET_COEFFICIENT_BLUE 6.2 //Blue sunset coefficient. Higher values will result in the blue color of sunset starting earlier and persisting longer. A change of 0.1 corresponds to about 5 seconds real-world time. [6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
#define SUNSET_COEFFICIENT_GREEN 6.7 //Green sunset coefficient. Higher values will result in the green color of sunset starting earlier and persisting longer. A change of 0.1 corresponds to about 5 seconds real-world time. [6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
#define SUNSET_COEFFICIENT_RED 7.2 //Red sunset coefficient. Higher values will result in the red color of sunset starting earlier and persisting longer. A change of 0.1 corresponds to about 5 seconds real-world time. [6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]

uniform float adjustedTime;
uniform float day;
uniform float frameTimeCounter;
uniform float night;
uniform float phase;
uniform float rainStrength;
uniform float sunset;
uniform float wetness;
uniform int heldBlockLightValue;
uniform int heldItemId;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform vec3 sunPosition;
uniform vec3 upPosition;
vec3 sunPosNorm = normalize(sunPosition);
vec3 upPosNorm  = normalize(upPosition);

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 shadowColor; //Color of shadows. Sky-colored, to simulate indirect lighting.
varying vec3 skyLightColor; //Color of sky light. Is usually white during the day, and very dark blue at night.
varying vec3 vPosPlayer;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

const int noiseTextureResolution = 64;
const float invNoiseRes = 1.0 / float(noiseTextureResolution);

#ifdef DYNAMIC_LIGHTS
	float flicker() {
		float n = texture2D(noisetex, frameTimeCounter * vec2(16.7825, 15.4192) * invNoiseRes).r - 0.5;
		return n * n * n * 12.0;
	}

	vec4 calcHeldLightColor() { //rgb = color, a = brightness
		if (heldBlockLightValue == 0) return vec4(0.0); //not holding a light source
		else if (heldItemId == 50 ) return vec4(1.0,  0.6,  0.3, heldBlockLightValue + flicker()); //torches
		else if (heldItemId == 89 ) return vec4(1.0,  0.6,  0.1, heldBlockLightValue            ); //glowstone
		else if (heldItemId == 169) return vec4(0.6,  0.8,  0.6, heldBlockLightValue            ); //sea lanterns
		else if (heldItemId == 198) return vec4(0.75, 0.55, 0.8, heldBlockLightValue            ); //end rods
		else if (heldItemId == 76 ) return vec4(1.0,  0.3,  0.1, heldBlockLightValue + flicker()); //redstone torches
		else if (heldItemId == 91 ) return vec4(1.0,  0.6,  0.3, heldBlockLightValue + flicker()); //jack-o-lanterns
		else if (heldItemId == 138) return vec4(0.4,  0.6,  0.8, heldBlockLightValue            ); //beacons
		else                        return vec4(0.8,  0.65, 0.5, heldBlockLightValue            ); //everything else
	}
#endif

void main() {
	vPosView    = (gl_ModelViewMatrix  * gl_Vertex).xyz;
	vPosPlayer  = mat3(gbufferModelViewInverse) * vPosView;
	gl_Position =  gl_ProjectionMatrix * vec4(vPosView, 1.0);
	texcoord    = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord     = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor     =  gl_Color;

	blockLightColor = mix(vec3(1.0, 0.5, 0.15), vec3(1.0, 0.85, 0.7), eyeBrightnessSmooth.x / 240.0);
	#if HARDCORE_DARKNESS == 0
		skyLightColor = day > 0.001 ? vec3(1.0) : vec3(0.04, 0.08, 0.12);
	#elif HARDCORE_DARKNESS == 1
		skyLightColor = day > 0.001 ? vec3(1.0) : vec3(0.0);
	#else
		skyLightColor = day > 0.001 ? vec3(1.0) : vec3(0.04, 0.08, 0.12) * phase;
	#endif
	shadowColor = mix(skyColor, fogColor, rainStrength);

	if (sunset > 0.01) {
		vec4 sunsetColor = vec4(clamp(vec3(SUNSET_COEFFICIENT_RED + 0.2, SUNSET_COEFFICIENT_GREEN + 0.2, SUNSET_COEFFICIENT_BLUE + 0.2) - adjustedTime, 0.0, 1.0), sunset); //color of sunset gradient at the horizon, and mix level
		if (rainStrength > 0.001) sunsetColor.rgb = mix(sunsetColor.rgb, fogColor * (1.0 - rainStrength * 0.5), rainStrength * 0.625); //reduce redness intensity when raining
		skyLightColor  = mix(skyLightColor, sunsetColor.rgb, sunsetColor.a);
		shadowColor     = mix(shadowColor,    sunsetColor.rgb, sunsetColor.a);
	}

	#ifdef DYNAMIC_LIGHTS
		heldLightColor = calcHeldLightColor();
	#endif

	#ifdef CROSS_PROCESS
		vec3 skyCrossColor   = mix(mix(vec3(1.4, 1.2, 1.1), vec3(1.0, 1.1, 1.4), night), vec3(1.0), wetness); //cross processing color from the sun
		vec3 blockCrossColor = mix(vec3(1.4, 1.0, 0.8), vec3(1.2, 1.1, 1.0), eyeBrightnessSmooth.x / 240.0); //cross processing color from block lights
		crossProcessColor    = mix(mix(vec3(1.0), skyCrossColor, lmcoord.y), blockCrossColor, lmcoord.x); //final cross-processing color (blockCrossColor takes priority over skyCrossColor)
	#endif
}