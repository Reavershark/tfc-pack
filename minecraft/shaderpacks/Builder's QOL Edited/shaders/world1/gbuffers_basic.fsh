#version 120

uniform sampler2D lightmap;

varying vec2 lmcoord;
varying vec3 glcolor;

void main() {
	vec3 color = glcolor;
	color *= texture2D(lightmap, lmcoord).rgb;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}