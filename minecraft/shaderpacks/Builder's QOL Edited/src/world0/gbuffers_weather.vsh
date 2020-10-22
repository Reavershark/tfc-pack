#version 120

#include "/lib/defines.glsl"

uniform float frameTimeCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

#ifdef CLOUDS
	varying float worldHeight;
#endif
varying vec2 texcoord;
varying vec4 glcolor;

#include "/lib/noiseres.glsl"

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	vec3 vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vec3 vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
	vec3 worldPos = vPosPlayer + eyePosition;

	#ifdef WAVING_RAIN
		vec2 offset = texture2D(noisetex, vec2(0.39162, 0.42636) * frameTimeCounter * invNoiseRes).rg * 4.0 - 2.0;
		offset += texture2D(noisetex, vec2(worldPos.x + frameTimeCounter * 8.0, worldPos.z) * 0.5 * invNoiseRes).rg - 0.25;

		worldPos.xz += vPosPlayer.y > 1.0 ? offset : offset * 0.25;
		vPosPlayer = worldPos - eyePosition;
		vPosView = mat3(gbufferModelView) * vPosPlayer;
	#endif

	#ifdef CLOUDS
		worldHeight = worldPos.y;
	#endif

	gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);
	glcolor = gl_Color;
}