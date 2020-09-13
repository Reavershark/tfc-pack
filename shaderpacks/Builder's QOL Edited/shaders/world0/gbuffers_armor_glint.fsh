#version 120

uniform float blindness;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 vPosView;
varying vec4 glcolor;

float square(float x)        { return x * x; } //faster than pow().

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }

struct Position {
	float blockDist; //only used by blindness
};

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb *= square(max(lmcoord.x, lmcoord.y)) * 0.5 + 0.5;

	Position pos;
	pos.blockDist = length(vPosView);

	if (blindness > 0.0) color.rgb *= interpolateSmooth1(max(1.0 - pos.blockDist * 0.2, 0.0)) * 0.5 * blindness + (1.0 - blindness);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}