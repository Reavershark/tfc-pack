#version 120

#define CLOUD_HEIGHT 256.0 //Y level of fancy clouds [128.0 144.0 160.0 176.0 192.0 208.0 224.0 240.0 256.0 272.0 288.0 304.0 320.0 336.0 352.0 368.0 384.0 400.0 416.0 432.0 448.0 464.0 480.0 496.0 512.0]
#define CLOUDS //3D clouds (partially volumetric too). Mild performance impact!

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