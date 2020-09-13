#version 120

#include "/lib/defines.glsl"

uniform float blindness;
uniform float frameTimeCounter;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gcolor;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 texcoord;

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

#include "/lib/hue.glsl"

#include "/lib/endEffects.glsl"

#ifdef VOID_CLOUDS
	#include "lib/drawVoidClouds.glsl"
#endif

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	Position pos;
	float depth = texture2D(depthtex0, texcoord).r;
	pos.isSky = depth == 1.0;
	vec4 tmp = gbufferProjectionInverse * vec4(vec3(texcoord, depth) * 2.0 - 1.0, 1.0);
	pos.view = tmp.xyz / tmp.w;
	pos.player = mat3(gbufferModelViewInverse) * pos.view;
	pos.world = pos.player + eyePosition;
	pos.blockDist = length(pos.view);
	pos.viewNorm = pos.view / pos.blockDist;
	pos.playerNorm = pos.player / pos.blockDist;

	if (pos.isSky) {
		#if defined(ENDER_NEBULAE) || defined(ENDER_STARS)
			//adding 1.0 to posNorm.y is how I get the sky to "wrap" around you.
			//if you want to visualize the effect this has, I would suggest setting color to vec3(fract(skyPos), 0.0).
			vec2 skyPos = pos.playerNorm.xz / (pos.playerNorm.y + 1.0);
			//wrapping behavior produces a mathematical singularity below you, so we just reduce the opacity there to hide that.
			float multiplier = 8.0 / (lengthSquared2(skyPos) + 8.0);

			#ifdef ENDER_NEBULAE
				vec4 cloudclr = drawNebulae(skyPos);
				color = mix(color, cloudclr.rgb, cloudclr.a * multiplier);
			#endif

			#ifdef ENDER_STARS
				vec3 starclr = drawStars(skyPos);
				color += starclr * multiplier;
			#endif
		#endif

		color *= 1.0 - blindness;
	}

	#ifdef VOID_CLOUDS
		float cloudDiff = VOID_CLOUD_HEIGHT - eyePosition.y;
		bool cloudy = sign(cloudDiff) == sign(pos.player.y);

		if (cloudy) {
			vec3 baseCloudPos = vec3(pos.playerNorm.xz * (cloudDiff / pos.playerNorm.y), cloudDiff).xzy;
			float opacityModifier = -1.0;

			if (!pos.isSky && pos.blockDist * pos.blockDist < lengthSquared3(baseCloudPos)) { //terrain in front of the clouds
				opacityModifier = abs(pos.world.y - VOID_CLOUD_HEIGHT) / 4.0;
				if (opacityModifier < 1.0) { //in the fadeout range
					baseCloudPos = pos.player;
				}
				else {
					cloudy = false;
				}
			}

			if (cloudy) {
				vec4 cloudclr = drawVoidClouds(baseCloudPos, opacityModifier);

				if (cloudclr.a > 0.001) {
					if (opacityModifier > 0.0 && opacityModifier < 1.0) { //in the fadeout range
						cloudclr.a *= interpolateSmooth1(opacityModifier);
					}
					color = mix(color, cloudclr.rgb, cloudclr.a);
				}
			}
		}
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}