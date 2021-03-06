#version 120

//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings

attribute vec3 mc_Entity;

uniform float frameTimeCounter;
uniform int heldBlockLightValue;
uniform int heldItemId;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;

varying float mcentity;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 blockLightColor; //Color of block light. Gets yellow-er if you stay away from light-emitting blocks for a while.

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 normal;
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
	normal      =  gl_Normal * 0.5 + 0.5;
	mcentity    = 0.1;

	//Using IDs above 10000 to represent all blocks that I care about
	//if the ID is less than 10000, then I don't need to do extra logic to see if it has special effects.
	if (mc_Entity.x > 10000.0) {
		int id = int(mc_Entity.x) - 10000;
		if      (id == 9)  mcentity = 1.1; //water
		else if (id == 10) mcentity = 2.1; //stained glass
		else if (id == 11) mcentity = 3.1; //ice
	}

	#ifdef DYNAMIC_LIGHTS
		heldLightColor = calcHeldLightColor();
	#endif

	blockLightColor = mix(vec3(1.0, 0.5, 0.15), vec3(1.0, 0.85, 0.7), eyeBrightnessSmooth.x / 240.0);

	#ifdef CROSS_PROCESS
		vec3 skyCrossColor = vec3(1.0, 0.75, 1.5); //cross processing color from the sky
		vec3 blockCrossColor = mix(vec3(1.4, 1.0, 0.8), vec3(1.2, 1.1, 1.0), eyeBrightnessSmooth.x / 240.0); //cross processing color from block lights
		crossProcessColor = mix(skyCrossColor, blockCrossColor, lmcoord.x); //final cross-processing color
	#endif
}