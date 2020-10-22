#version 120

#define FOG_ENABLED_NETHER //Enables fog in the nether

uniform float frameTimeCounter;
uniform float nightVision;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gcolor;
uniform sampler2D noisetex;
uniform vec3 fogColor;

varying vec2 texcoord;

struct Position {
	vec3 view;
	//viewNorm not needed by anything.
	vec3 player;
	vec3 playerNorm;
	float blockDist;
	//viewDist not needed by anything.
};

const int noiseTextureResolution = 64;
const float invNoiseRes = 1.0 / float(noiseTextureResolution);

float square(float x)        { return x * x; } //faster than pow().

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

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

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	//no skybasic program in the nether. use deferred instead.
	#ifdef FOG_ENABLED_NETHER
		float depth = texture2D(depthtex0, texcoord).r;
		if (depth == 1.0) {
			Position pos;
			vec3 screenPos = vec3(texcoord, depth);
			vec4 tmp = gbufferProjectionInverse * vec4(screenPos * 2.0 - 1.0, 1.0);
			pos.view = tmp.xyz / tmp.w;
			pos.player = mat3(gbufferModelViewInverse) * pos.view;
			pos.blockDist = length(pos.view);
			pos.playerNorm = pos.player / pos.blockDist;

			color = calcFogColor(pos);
		}
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}