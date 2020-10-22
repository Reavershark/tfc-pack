#version 120

#include "/lib/defines.glsl"

uniform float frameTimeCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjection;
uniform sampler2D texture;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

#ifdef FANCY_BEACONS
	varying vec2 beaconPosPlayer;
#endif
#ifndef FANCY_BEACONS
	varying vec2 texcoord;
#endif
#ifdef FANCY_BEACONS
	varying vec3 vPosPlayer;
#endif
varying vec4 glcolor;

#include "/lib/goldenOffsets.glsl"

#include "/lib/math.glsl"

#include "/lib/beaconMethods.glsl"

void main() {
	#include "/lib/beacon.fsh"

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}