#version 120

//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings

uniform float frameTimeCounter;
uniform float inSoulSandValley;
uniform int heldBlockLightValue;
uniform int heldItemId;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

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
	lmcoord     = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	texcoord    = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor     =  gl_Color;

	#ifdef DYNAMIC_LIGHTS
		heldLightColor = calcHeldLightColor();
	#endif

	vec3 nearBlockLightColor = vec3(1.4, 1.1, 0.8); //block light color when the player is near a light source
	vec3 farBlockLightColor = vec3(1.5, 0.75, 0.25); //block light color when the plater is far from a light source
	#if MC_VERSION >= 11600
		float soul = inSoulSandValley * smoothstep(32.0, 48.0, vPosPlayer.y + eyePosition.y);
		nearBlockLightColor = mix(nearBlockLightColor, vec3(0.8, 1.1, 1.4), soul);
		farBlockLightColor = mix(farBlockLightColor, vec3(0.25, 0.75, 1.5), soul);
	#endif
	blockLightColor = mix(farBlockLightColor, farBlockLightColor, eyeBrightnessSmooth.x / 240.0);

	#ifdef CROSS_PROCESS
		vec3 skyCrossColor = vec3(1.5, 1.0, 0.75); //cross processing color from the sky
		vec3 blockCrossColor = mix(vec3(1.4, 1.0, 0.8), vec3(1.2, 1.1, 1.0), eyeBrightnessSmooth.x / 240.0); //cross processing color from block lights
		crossProcessColor = mix(skyCrossColor, blockCrossColor, lmcoord.x); //final cross-processing color
	#endif
}