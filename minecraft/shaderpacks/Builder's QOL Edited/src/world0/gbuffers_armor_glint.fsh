#version 120

uniform float blindness;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 vPosView;
varying vec4 glcolor;

#include "/lib/math.glsl"

struct Position {
	float blockDist; //only used by blindness
};

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb *= square(max(lmcoord.x, lmcoord.y)) * 0.5 + 0.5;

	Position pos;
	pos.blockDist = length(vPosView);

	#include "/lib/blindness.glsl"

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}