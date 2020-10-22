#version 120

#define FANCY_BEACONS //Builderb0y's better beacon beams bring big bright beautiful beacon beams to all biomes, bro

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
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

float lengthSquared2(vec2 v) { return dot(v, v); }

void main() {
	#ifdef FANCY_BEACONS
		vec3 vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
		vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
		beaconPosPlayer = floor(vPosPlayer.xz + eyePosition.xz) + 0.5 - eyePosition.xz;
		vec2 playerPosRelativeToBeacon = vPosPlayer.xz - beaconPosPlayer;

		if (lengthSquared2(playerPosRelativeToBeacon) > 0.0625) { //transparent layer. testing position instead of gl_Color.a because gl_Color.a is the same on both layers in 1.7
			gl_Position = vec4(100.0);
			return;
		}

		vPosPlayer.xz += playerPosRelativeToBeacon * 1.5; //make the beam a little bit wider, so that we have more fragments to work with.
		vPosView = mat3(gbufferModelView) * vPosPlayer;
		gl_Position = gl_ProjectionMatrix * vec4(vPosView, 1.0);
	#else
		texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
		gl_Position = ftransform();
	#endif

	glcolor = gl_Color;
}