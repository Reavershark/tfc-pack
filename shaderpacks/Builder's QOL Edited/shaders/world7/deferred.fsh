#version 120

//#define CUBIC_CHUNKS //Disables black fog/sky colors below Y=0
#define TF_AURORAS //Adds auroras to the sky in the twilight forest
#define TF_SKY_FIX //Enable this if the sky looks wrong in the twilight forest

uniform float frameTimeCounter;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gcolor;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 texcoord;

struct Position {
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	float blockDist;
};

const int noiseTextureResolution = 64;
const float invNoiseRes = 1.0 / float(noiseTextureResolution);

float square(float x)        { return x * x; } //faster than pow().

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

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

vec3 calcFogColor(vec3 playerPosNorm) {
	#ifndef CUBIC_CHUNKS
		if (eyePosition.y < 0.0) return vec3(0.0);
	#endif

	return mix(skyColor, fogColor, fogify(max(playerPosNorm.y, 0.0), 0.0625));
}

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	float depth = texture2D(depthtex0, texcoord).r;

	if (depth == 1.0) {
		Position pos;
		vec3 screenPos = vec3(texcoord, depth);
		vec4 tmp = gbufferProjectionInverse * vec4(screenPos * 2.0 - 1.0, 1.0);
		pos.view = tmp.xyz / tmp.w;
		pos.player = mat3(gbufferModelViewInverse) * pos.view;
		pos.blockDist = length(pos.view);
		pos.viewNorm = pos.view / pos.blockDist;
		pos.playerNorm = pos.player / pos.blockDist;

		#ifdef TF_SKY_FIX
			color = calcFogColor(pos.playerNorm);
		#endif

		#ifdef TF_AURORAS
			#ifndef CUBIC_CHUNKS
				if (eyePosition.y > 0.0) {
			#endif
					float auroraBrightness = 1.0 - abs(pos.playerNorm.y - 0.5) * 3.0;
					if (pos.playerNorm.y > 0.0 && auroraBrightness > 0.0) {
						vec2 auroraStart = pos.playerNorm.xz / pos.playerNorm.y * invNoiseRes;
						vec2 auroraStep = auroraStart * -0.5;
						float dither = fract(dot(gl_FragCoord.xy, vec2(0.25, 0.5))) * 0.0625;
						float time = frameTimeCounter * invNoiseRes;
						vec3 auroraColor = vec3(0.0);
						for (int i = 0; i < 16; i++) {
							vec2 auroraPos = (i * 0.0625 + dither) * auroraStep + auroraStart;
							float noise = 1.0 - abs(texture2D(noisetex, vec2(auroraPos.x * 0.5 + (time * 0.03125), auroraPos.y * 2.0)).r * 10.0 - 5.0); //primary noise layer, defines the overall shape of auroras
							if (noise > 0.0) {
								noise *= square(texture2D(noisetex, vec2(auroraPos.x * 16.0, auroraPos.y * 16.0 + (time * 0.5))).r * 2.0 - 1.0); //secondary noise layer, adds detail to the auroras
								auroraColor += hue(texture2D(noisetex, auroraPos * 3.0 + (time * 0.1875)).r * 0.5 + 0.35) * noise * square(1.0 - abs(float(i) * 0.125 - 1.0)); //tertiary noise layer, defines the color of the auroras
							}
						}
						color += sqrt(auroraColor) * 0.75 * interpolateSmooth1(auroraBrightness);
					}
			#ifndef CUBIC_CHUNKS
				}
			#endif
		#endif
	}

/* DRAWBUFFERS:06 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
	gl_FragData[1] = vec4(depth, 0.0, 0.0, 1.0); //gaux3
}