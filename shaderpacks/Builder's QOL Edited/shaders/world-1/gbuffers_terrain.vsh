#version 120

//#define CROSS_PROCESS //Opposite of desaturation, makes everything more vibrant and saturated.
#define DYNAMIC_LIGHTS //Holding blocks that emit light will light up their surroundings
#define GRASS_AO //Adds ambient occlusion to tallgrass/flowers/etc... Works best with "Remove Y Offset" enabled.
#define LAVA_PATCHES //Randomizes lava brightness, similar to grass patches
#define LAVA_WAVE_STRENGTH 100 //Adds waves to the nether lava oceans [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]
//#define REMOVE_XZ_OFFSET //Removes random X/Z offset from tallgrass/flowers/etc...
//#define REMOVE_Y_OFFSET //Removes random Y offset from tallgrass/flowers/etc...

attribute vec2 mc_midTexCoord;
attribute vec3 mc_Entity;

uniform float frameTimeCounter;
uniform float inSoulSandValley;
uniform int heldBlockLightValue;
uniform int heldItemId;
uniform ivec2 eyeBrightnessSmooth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
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

#if LAVA_WAVE_STRENGTH != 0
	float lavaWave(vec2 pos) {
		pos *= invNoiseRes;
		float offset = 0.875;
		offset += cos(texture2D(noisetex, pos / 30.0).r * 25.0 + frameTimeCounter) * 0.5;
		offset += cos(texture2D(noisetex, pos / 20.0).r * 12.5 + frameTimeCounter * 1.5) * 0.375;
		return offset * (float(LAVA_WAVE_STRENGTH) / 100.0 / 1.75);
	}
#endif

void main() {
	ao = 1.0;
	isLava = 0.0;

	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
	vec3 worldPos = vPosPlayer + eyePosition;

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;

	//Using IDs above 10000 to represent all blocks that I care about
	//if the ID is less than 10000, then I don't need to do extra logic to see if it has special effects.
	if (mc_Entity.x > 10000.0) {
		int id = int(mc_Entity.x) - 10000;
		if (id == 7) { //lava
			lmcoord.x = 0.96875; //hide vanilla lighting glitches

			#if LAVA_WAVE_STRENGTH != 0
				if (worldPos.y <= 32.01) {
					worldPos.y -= lavaWave(worldPos.xz + 0.5) * fract(worldPos.y - 0.01); // + 0.5 to avoid sharp edges in lava displacement when the coords are on the edge of a noisetex pixel
				}
			#endif

			#ifdef LAVA_PATCHES
				isLava = 1.0;
				if (abs(gl_Normal.y) > 0.1) randCoord = worldPos.xz * 0.5;
				else randCoord = vec2((worldPos.x + worldPos.z) * 4.0, worldPos.y + frameTimeCounter);
			#endif
		}
		else if (id == 2 || id == 3 || id == 4) { //plants and double plants
			#ifdef GRASS_AO
				ao = float(texcoord.y < mc_midTexCoord.y);
				if (id != 2) ao = (ao + float(id == 4)) * 0.5;
			#endif

			#ifdef REMOVE_Y_OFFSET
				worldPos.y = floor(worldPos.y + 0.5);
			#endif

			#ifdef REMOVE_XZ_OFFSET
				worldPos.xz = floor(worldPos.xz + 0.5);
			#endif
		}
		#ifdef GRASS_AO
			else if (id == 5) { //crops
				ao = float(texcoord.y < mc_midTexCoord.y);
			}
		#endif
	}

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

	vPosPlayer = worldPos - eyePosition;
	vPosView = mat3(gbufferModelView) * vPosPlayer;
	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);

	float glmult = dot(vec4(abs(gl_Normal.x), abs(gl_Normal.z), max(gl_Normal.y, 0.0), max(-gl_Normal.y, 0.0)), vec4(0.6, 0.8, 1.0, 0.5));
	glmult = mix(glmult, 1.0, lmcoord.x * lmcoord.x); //increase brightness when block light is high
	glcolor.rgb *= glmult;
}