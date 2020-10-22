#version 120

#include "/lib/defines.glsl"

uniform float blindness;
uniform float day;
uniform float frameTimeCounter;
uniform float night;
uniform float phase;
uniform float rainStrength;
uniform float wetness;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gcolor;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
uniform vec3 sunPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;
vec3 sunPosNorm = normalize(sunPosition);

#ifdef CLOUDS
	varying float cloudDensityModifier; //Random fluctuations every few minutes.
#endif
varying vec2 texcoord;
#ifdef CLOUDS
	varying vec3 cloudColor; //Color of the side of clouds facing away from the sun.
	varying vec3 cloudIlluminationColor; //Color of the side of clouds facing towards the sun.
#endif

struct Position {
	bool isSky;
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist;
};

#include "/lib/noiseres.glsl"

#include "/lib/goldenOffsets.glsl"

#include "/lib/math.glsl"

#ifdef CLOUDS
	#ifdef OLD_CLOUDS
		#include "lib/drawClouds_old.glsl"
	#else
		#include "lib/drawClouds.glsl"
	#endif
#endif

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;
	float depth = texture2D(depthtex0, texcoord).r;

	#ifdef CLOUDS
		Position pos;
		pos.isSky = depth == 1.0;
		vec4 tmp = gbufferProjectionInverse * vec4(vec3(texcoord, depth) * 2.0 - 1.0, 1.0);
		pos.view = tmp.xyz / tmp.w;
		pos.player = mat3(gbufferModelViewInverse) * pos.view;
		pos.world = pos.player + eyePosition;
		pos.blockDist = length(pos.view);
		pos.viewNorm = pos.view / pos.blockDist;
		pos.playerNorm = pos.player / pos.blockDist;

		float cloudDiff = CLOUD_HEIGHT - eyePosition.y;

		#ifdef CUBIC_CHUNKS
			bool cloudy = sign(cloudDiff) == sign(pos.player.y);
		#else
			bool cloudy = eyePosition.y > 0.0 && sign(cloudDiff) == sign(pos.player.y);
		#endif

		if (cloudy) {
			vec3 baseCloudPos = vec3(pos.playerNorm.xz * (cloudDiff / pos.playerNorm.y), cloudDiff).xzy;
			float opacityModifier = -1.0;

			if (!pos.isSky && pos.blockDist * pos.blockDist < lengthSquared3(baseCloudPos)) {
				opacityModifier = abs(pos.world.y - CLOUD_HEIGHT) / 4.0;
				if (opacityModifier < 1.0) {
					baseCloudPos = pos.player;
				}
				else {
					cloudy = false;
				}
			}

			if (cloudy) {
				vec4 cloudclr = drawClouds(baseCloudPos, pos.viewNorm, opacityModifier, false);
				cloudclr.a *= 64.0 / (lengthSquared2(baseCloudPos.xz / baseCloudPos.y) + 64.0); //reduce opacity in the distance

				if (cloudclr.a > 0.001) {
					if (opacityModifier > 0.0 && opacityModifier < 1.0) { //in the fadeout range
						cloudclr.a *= interpolateSmooth1(opacityModifier);
					}
					color = mix(color, cloudclr.rgb, cloudclr.a);
				}
			}
		}
	#endif

/* DRAWBUFFERS:06 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
	gl_FragData[1] = vec4(depth, 0.0, 0.0, 1.0); //gaux3
}