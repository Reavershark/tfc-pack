#version 120

uniform float blindness;
uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;

	color *= 1.0 - blindness;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}