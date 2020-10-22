#version 120

#include "/lib/defines.glsl"

uniform float night;
uniform float nightVision;
uniform float rainStrength;
uniform float wetness;
uniform sampler2D texture;
uniform vec3 fogColor;

#ifdef CLOUDS
	varying float worldHeight;
#endif
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	#ifdef CLOUDS
		if (worldHeight > CLOUD_HEIGHT) discard; //don't draw rain above clouds.
	#endif

	vec4 color;
	color.rgb = fogColor * (1.0 - max(rainStrength, wetness) * 0.5) * (1.0 - nightVision * night * 0.75);
	color.a = texture2D(texture, texcoord).a * glcolor.a;
	color.a *= 2.0 - color.a;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}