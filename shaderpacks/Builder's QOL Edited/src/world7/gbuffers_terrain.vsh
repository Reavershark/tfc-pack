#version 120

#include "/lib/defines.glsl"

attribute vec2 mc_midTexCoord;
attribute vec3 mc_Entity;

uniform float frameTimeCounter;
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

#ifdef CROSS_PROCESS
	varying vec3 crossProcessColor; //Color to use for cross-processing
#endif

varying vec3 vPosPlayer;
varying vec3 vPosView;
varying vec4 glcolor;
varying vec4 heldLightColor; //Color of held light source. Alpha = brightness.

#include "/lib/noiseres.glsl"

#include "/lib/math.glsl"

#include "/lib/calcHeldLightColor.glsl"

vec3 windOffset(vec3 worldPos, float multiplier, float speed) {
	float baseWindAmt = worldPos.y / 256.0 + 1.0; //1.0x at y=0, 2.0x at y=256
	vec3 waveStart = texture2D(noisetex, vec2(worldPos.x + frameTimeCounter, worldPos.z) * 0.375 * invNoiseRes).rgb; //oscillation direction and phase offset
	float waveMultiplier = texture2D(noisetex, vec2(worldPos.x * 0.125 + frameTimeCounter * 0.5, worldPos.z * 0.125) * invNoiseRes).r * 0.5 + 0.5; //multiplier to add variety
	vec2 offset = vec2(waveStart.y * 0.4 - 0.2, waveStart.z * 0.2 - 0.1) * cos(waveStart.x * 6.283185307 + frameTimeCounter * speed) * waveMultiplier; //combine to get position offset
	offset.x -= baseWindAmt * 0.01 + 0.02; //biased towards east wind
	offset *= multiplier * baseWindAmt; //scale offset
	return vec3(offset.x, 0.5 / (lengthSquared2(offset) + 0.5) - 1.0, offset.y); //move vertexes down some based on how much they were offset
}

#ifdef GRASS_PATCHES
	float noiseMap(vec2 worldPos) {
		float noise = 0.0;
		noise += texture2D(noisetex, worldPos * (invNoiseRes * 0.03125)).r;
		noise += texture2D(noisetex, worldPos * (invNoiseRes * 0.09375)).r * 0.5;
		noise += texture2D(noisetex, worldPos * (invNoiseRes * 0.375  )).r * 0.25;
		return noise;
	}
#endif

#if WATER_WAVE_STRENGTH != 0
	float waterWave(vec2 pos) {
		pos *= invNoiseRes;
		float offset = 0.875;
		offset += cos(texture2D(noisetex, pos / 20.0).r * 25.0 + frameTimeCounter * 2.0) * 0.5;
		offset += cos(texture2D(noisetex, pos / 15.0).r * 12.5 + frameTimeCounter * 3.0) * 0.375;
		return offset * (float(WATER_WAVE_STRENGTH) / 100.0 / 1.75);
	}
#endif

void main() {
	vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
	vec3 worldPos = vPosPlayer + eyePosition;

	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor  =  gl_Color;

	ao = 1.0;
	isLava = 0.0;

	#ifdef GRASS_PATCHES
		bool isGrass = false;
	#endif

	#include "lib/colors.glsl"

	vec3 normal;
	//Using IDs above 10000 to represent all blocks that I care about
	//if the ID is less than 10000, then I don't need to do extra logic to see if it has special effects.
	if (mc_Entity.x > 10000.0) {
		int id = int(mc_Entity.x) - 10000;
		if (id == 1) { //grass blocks and dirt
			normal = gl_Normal;

			#ifdef GRASS_PATCHES
				isGrass = gl_Color.g > gl_Color.b;
			#endif
		}
		else if (id == 2) { //tallgrass and other plants
			normal = vec3(0.0, 1.0, 0.0);

			#ifdef REMOVE_Y_OFFSET
				worldPos.y = floor(worldPos.y + 0.5);
			#endif
			#ifdef REMOVE_XZ_OFFSET
				worldPos.xz = floor(worldPos.xz + 0.5);
			#endif

			#if defined(GRASS_AO) || defined(WAVING_GRASS)
				float amt = float(texcoord.y < mc_midTexCoord.y);
				#ifdef GRASS_AO
					ao = amt;
				#endif

				#ifdef WAVING_GRASS
					if (amt > 0.1) { //will always either be 0.0 or 1.0
						worldPos += windOffset(worldPos, amt * lmcoord.y * lmcoord.y, 5.0);
					}
				#endif
			#endif

			#ifdef GRASS_PATCHES
				isGrass = gl_Color.g > gl_Color.b; //some double plants are colored by texture, and others are colored by biome.
			#endif
		}
		else if (id == 3 || id == 4) { //double plants
			normal = vec3(0.0, 1.0, 0.0);

			#ifdef REMOVE_Y_OFFSET
				worldPos.y = floor(worldPos.y + 0.5);
			#endif
			#ifdef REMOVE_XZ_OFFSET
				worldPos.xz = floor(worldPos.xz + 0.5);
			#endif

			#if defined(GRASS_AO) || defined(WAVING_GRASS)
				float amt = (float(texcoord.y < mc_midTexCoord.y) + float(id == 4)) * 0.5;
				#ifdef GRASS_AO
					ao = amt;
				#endif

				#ifdef WAVING_GRASS
					amt *= 1.5;
				#endif

				#ifdef WAVING_GRASS
					if (amt > 0.1) { //will always either be 0.0, 0.5 or 1.0
						worldPos += windOffset(worldPos, amt * lmcoord.y * lmcoord.y, 3.0);
					}
				#endif
			#endif

			#ifdef GRASS_PATCHES
				isGrass = gl_Color.g > gl_Color.b; //some double plants are colored by texture, and others are colored by biome.
			#endif
		}
		#ifdef WAVING_LEAVES
			else if (id == 13) { //leaves
				normal = gl_NormalMatrix * gl_Normal;
				worldPos += windOffset(worldPos, lmcoord.y * lmcoord.y, 3.0);
			}
		#endif
		#ifdef WAVING_VINES
			else if (id == 14) { //vines
				normal = gl_NormalMatrix * gl_Normal;
				worldPos += windOffset(worldPos, lmcoord.y * lmcoord.y, 3.0);
			}
		#endif
		else if (id == 5) { //crops
			normal = vec3(0.0, 1.0, 0.0);

			#ifdef GRASS_AO
				ao = float(texcoord.y < mc_midTexCoord.y);
			#endif

			#ifdef WAVING_GRASS
				if (texcoord.y < mc_midTexCoord.y) {
					worldPos += windOffset(worldPos, lmcoord.y * lmcoord.y, 5.0);
				}
			#endif
		}
		else if (id == 6) { //sugar cane and other arbitrarily-tall plants
			normal = vec3(0.0, 1.0, 0.0);

			#ifdef LEGACY_SUGARCANE
				glcolor = vec4(1.0);
			#endif

			#ifdef GRASS_PATCHES
				isGrass = true;
			#endif
		}

		#ifdef LAVA_PATCHES
			else if (id == 7) { //lava
				normal = gl_Normal;
				isLava = 1.0;
				if (abs(gl_Normal.y) > 0.1) randCoord = worldPos.xz * 2.0;
				else randCoord = vec2((worldPos.x + worldPos.z) * 4.0, worldPos.y + frameTimeCounter);
			}
		#endif

		else if (id == 8) { //cobwebs and other stuff that shouldn't have shadows
			normal = vec3(0.0, 1.0, 0.0);
		}

		#if WATER_WAVE_STRENGTH != 0
			else if (id == 12) { //lily pads
				if (worldPos.y <= 31.99 && worldPos.y >= 30.99) {
					worldPos.y -= waterWave(worldPos.xz + 0.5); // + 0.5 to avoid sharp edges in lava displacement when the coords are on the edge of a noisetex pixel
				}
				normal = gl_Normal;
			}
		#endif

		else {
			normal = gl_Normal;
		}
	}
	else {
		normal = gl_Normal;
	}

	#ifdef GRASS_PATCHES
		if (isGrass) {
			float noise = noiseMap(worldPos.xz) - HUMIDITY_OFFSET;
			if (noise > 0.0) glcolor.rg += vec2(noise * 0.33333333, noise * -0.125);
			else glcolor.rb += noise / 4.0;
			glcolor.g = max(glcolor.g, glcolor.r * 0.85);
		}
	#endif

	vPosPlayer = worldPos - eyePosition;
	vPosView = mat3(gbufferModelView) * vPosPlayer;
	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);

	float glmult = dot(vec4(abs(gl_Normal.x), abs(gl_Normal.z), max(gl_Normal.y, 0.0), max(-gl_Normal.y, 0.0)), vec4(0.6, 0.8, 1.0, 0.5));
	glmult = mix(glmult, 1.0, lmcoord.x * lmcoord.x); //increase brightness when block light is high
	glcolor.rgb *= glmult;
}