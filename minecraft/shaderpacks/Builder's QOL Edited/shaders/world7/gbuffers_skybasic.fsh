#version 120

//#define CUBIC_CHUNKS //Disables black fog/sky colors below Y=0

uniform float pixelSizeX;
uniform float pixelSizeY;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec4 starData; //rgb = star color, a = flag for weather or not this pixel is a star.

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

vec3 calcFogColor(vec3 playerPosNorm) {
	#ifndef CUBIC_CHUNKS
		if (eyePosition.y < 0.0) return vec3(0.0);
	#endif

	return mix(skyColor, fogColor, fogify(max(playerPosNorm.y, 0.0), 0.0625));
}

void main() {

/* DRAWBUFFERS:0 */
	gl_FragData[0] = starData.a > 0.5 ? starData : vec4(calcFogColor(normalize((gbufferProjectionInverse * vec4(gl_FragCoord.xy * vec2(pixelSizeX, pixelSizeY) * 2.0 - 1.0, 1.0, 1.0)).xyz)), 1.0); //gcolor
}