#version 120

#define ENDER_ARCS //Adds bolts of plasma that arc through the nebulae. Requires ender nebulae to be enabled!
#define ENDER_NEBULAE //Adds animated nebulae to the background of the end dimension
#define ENDER_STARS //Adds blinking stars to the background of the end dimension. Stackable with nebulae/plasma.
#define VOID_CLOUD_HEIGHT 128.0 //Y level of void clouds [-64.0 -48.0 -32.0 -16.0 0.0 16.0 32.0 48.0 64.0 80.0 96.0 112.0 128.0 144.0 160.0 176.0 192.0 208.0 224.0 240.0 256.0 272.0 288.0 304.0 320.0 336.0 352.0 368.0 384.0 400.0 416.0 432.0 448.0 464.0 480.0 496.0 512.0]
#define VOID_CLOUDS //Dark ominous clouds in the end

uniform float blindness;
uniform float frameTimeCounter;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D depthtex0;
uniform sampler2D gcolor;
uniform sampler2D noisetex;
uniform vec3 cameraPosition;
vec3 eyePosition = cameraPosition + gbufferModelViewInverse[3].xyz;

varying vec2 texcoord;

struct Position {
	bool isSky;
	vec3 view;
	vec3 viewNorm;
	vec3 player;
	vec3 playerNorm;
	vec3 world;
	float blockDist;
};

const int noiseTextureResolution = 64;
const float invNoiseRes = 1.0 / float(noiseTextureResolution);

//sines and cosines of multiples of the golden angle (~2.4 radians)
const vec2 goldenOffset0 = vec2( 0.675490294261524, -0.73736887807832 ); //2.39996322972865332
const vec2 goldenOffset1 = vec2(-0.996171040864828,  0.087425724716963); //4.79992645945731
const vec2 goldenOffset2 = vec2( 0.793600751291696,  0.608438860978863); //7.19988968918596
const vec2 goldenOffset3 = vec2(-0.174181950379306, -0.98471348531543 ); //9.59985291891461
const vec2 goldenOffset4 = vec2(-0.53672805262632,   0.843755294812399); //11.9998161486433
const vec2 goldenOffset5 = vec2( 0.965715074375778, -0.259604304901489); //14.3997793783719
const vec2 goldenOffset6 = vec2(-0.887448429245268, -0.460907024713344); //16.7997426081006
const vec2 goldenOffset7 = vec2( 0.343038630874082,  0.939321296324125); //19.1997058378292

float square(float x)        { return x * x; } //faster than pow().
float lengthSquared2(vec2 v) { return dot(v, v); }
float lengthSquared3(vec3 v) { return dot(v, v); }

float interpolateSmooth1(float x) { return x * x * (3.0 - 2.0 * x); }
vec2  interpolateSmooth2(vec2 v)  { return v * v * (3.0 - 2.0 * v); }

float fogify(float x, float width) { return width / (x * x + width); } //fast, vaguely bell curve-shaped function with variable width

vec3 hue(float h) {
	h = fract(h) * 6.0;
	return clamp(
		vec3(
			abs(h - 3.0) - 1.0,
			2.0 - abs(h - 2.0),
			2.0 - abs(h - 4.0)
		),
		0.0,
		1.0
	);
}

#ifdef ENDER_NEBULAE
	float random(vec2 coord) {
		vec2 middle = fract(coord);
		vec4 corners = vec4(coord - middle + 0.5, 0.0, 0.0);
		corners.zw = corners.xy + 1.0;
		corners *= invNoiseRes;
		//vec4 corners = (vec4(floor(coord), ceil(coord)) + 0.5) * invNoiseRes;
		//ivec4 corners = ivec4(mod(vec4(floor(coord), ceil(coord)), noiseTextureResolution));

		float r00 = texture2D(noisetex, corners.xy).r; //random value at the (0, 0) corner
		float r01 = texture2D(noisetex, corners.xw).r; //random value at the (0, 1) corner
		float r10 = texture2D(noisetex, corners.zy).r; //random value at the (1, 0) corner
		float r11 = texture2D(noisetex, corners.zw).r; //random value at the (1, 1) corner

		vec2 mixlvl = interpolateSmooth2(middle); //non-linear interpolation

		return mix(mix(r00, r10, mixlvl.x), mix(r01, r11, mixlvl.x), mixlvl.y); //linear interpolation between the 4 corners
	}

	//base noise algorithm for the overall cloud pattern. ranges from -1.0 to 1.0
	float cloudNoise(vec2 pos) {
		float noise = -0.32992;
		noise += random(pos * 2.0  + goldenOffset0 * frameTimeCounter * 0.125  ) * 0.4;
		noise += random(pos * 4.0  + goldenOffset1 * frameTimeCounter * 0.0625 ) * 0.16;
		noise += random(pos * 8.0  + goldenOffset2 * frameTimeCounter * 0.04166) * 0.064;
		noise += random(pos * 16.0 + goldenOffset3 * frameTimeCounter * 0.03125) * 0.0256;
		noise += random(pos * 32.0 + goldenOffset4 * frameTimeCounter * 0.025  ) * 0.01024;
		return noise;
	}

	//noise algorithm for all the different colors
	//doesn't need as many iterations as cloudNoise() because it doesn't need to be as "rough"
	//also has different speed/effect multipliers in order to fit the values I want to get out of hue().
	float colorNoise(vec2 pos) {
		float noise = 0.4;
		noise += random(pos * 2.0 + goldenOffset5 * frameTimeCounter * 0.5 ) * 0.25;
		noise += random(pos * 4.0 + goldenOffset6 * frameTimeCounter * 0.25) * 0.125;
		noise += random(pos * 8.0 + goldenOffset7 * frameTimeCounter * 0.16) * 0.0625;
		return noise;
	}

	//both of these functions are quite similar, just with some slight differences in the math.
	#ifdef ENDER_ARCS
		vec4 drawNebulae(vec2 pos) {
			float noise = abs(cloudNoise(pos)); //density depends on how close cloudNoise() is to 0.0
			if (noise < 0.25) { //alpha calculations work within the range 0 - 0.25
				vec3 baseclr = hue(colorNoise(pos)) * 0.625; //nebulae color at this position
				float arclight = square(max(0.7 - noise * 8.0, 0.0)); //brighten areas that are very close to an arc (when cloudNoise() is close to 0.0)
				return vec4(mix(baseclr, vec3(1.0), arclight), square(1.0 - noise * 4.0) * 0.9); //alpha also depends on how close to an arc we are
			}
			else return vec4(0.0); //was not part of a nebula
		}
	#else
		vec4 drawNebulae(vec2 pos) {
			float noise = cloudNoise(pos); //density depends on how close cloudNoise() is to 1.0
			if (noise > 0.0) {
				vec3 baseclr = hue(colorNoise(pos)) * 0.625; //nebulae color at this position
				baseclr += 1.0 - 0.1 / (noise * noise + 0.1); //brighten areas that are close to the "center" of the nebulae (when cloudNoise() is close to 1.0)
				return vec4(baseclr, 1.0 - 0.02 / (noise * noise + 0.02)); //alpha also depends on how close to the "center" of the nebulae we are
			}
			else return vec4(0.0);
		}
	#endif
#endif

#ifdef ENDER_STARS
	float fade(float speed, float delay) {
		float newTime = mod(frameTimeCounter * speed, delay);
		//newTime / threshold
		if (newTime < 0.1) return newTime * 10.0;
		//1.0 - (newTime / (1.0 - threshold)) + (threshold / (1.0 - threshold));
		else return newTime * -1.1111111111111111 + 1.1111111111111111;
	}

	vec3 drawStars(vec2 pos) {
		pos *= 16.0; //increase density of stars by a factor of 16x.
		vec2 newpos = floor(pos) + 0.5; //position rounded to the nearest "square". you can immagine this imposing a grid pattern onto the sky.

		//r = random chance that this square will be a star, g = fade animation speed, b = delay before re-appearing
		//r is also used to store "brightness" of the star. if the star is above 75% brightness to start with, it gets to be rendered. (this check is ignored for ender portals)
		vec3 starData1 = texture2D(noisetex, newpos * invNoiseRes).rgb;
		float fadeAmt = fade(starData1.g * 0.1 + 0.15, starData1.b * 8.0 + 1.0);

		if (starData1.r > 0.75 && fadeAmt > 0.0) { //25% of all the "squares" in the sky will be stars
			//r = type (star-shaped vs. circular), g = size multiplier, b = color
			vec3 starData2 = texture2D(noisetex, -newpos * invNoiseRes).rgb;

			float dist;
			//star-shaped stars are smaller than circular ones, so making more of them to compensate.
			if (starData2.r < 0.25) dist = length(pos - newpos) * 2.0; //pythagorean distance
			else { //star-shaped distance (distance increases faster diagonally than cardinally)
				vec2 v = sqrt(abs(pos - newpos));
				dist = v.x + v.y;
			}

			dist *= starData2.g + 1.0; //apply random size modifier. increasing the distance has the effect of decreasing the size, since smaller distances get scaled up to the maximum distance
			dist += 1.0 - fadeAmt; //apply fading animation. again, increasing distance decreases size. when fadeAmt = 0, the star will be invisible.

			float amt = square(max(1.0 - dist, 0.0)); //apply distance calculations to brightness of the star. The closer we are to the center, the brighter it should be.

			vec3 clr = hue(starData2.b * 0.6 - 0.35) * 0.625 + 0.375; //calculate color of star based on random number.
			clr = clr * amt + amt * amt * 0.625; //actually colorize star, and make whiter near the center.

			//make some stars brighter than others
			clr *= starData1.r * 2.0 - 1.0;

			return clr;
		}
		return vec3(0.0);
	}
#endif

#ifdef VOID_CLOUDS
	float thresholdSample(vec2 coord, vec2 threshold) {
		vec2 middle = fract(coord);
		vec4 corners = vec4(coord - middle + 0.5, 0.0, 0.0);
		corners.zw = corners.xy + 1.0;
		corners *= invNoiseRes;
		//vec4 corners = (vec4(floor(coord), ceil(coord)) + 0.5) * invNoiseRes;

		vec4 samples = vec4(
			texture2D(noisetex, corners.xy).r, //random value at the (0, 0) corner
			texture2D(noisetex, corners.xw).r, //random value at the (0, 1) corner
			texture2D(noisetex, corners.zy).r, //random value at the (1, 0) corner
			texture2D(noisetex, corners.zw).r  //random value at the (1, 1) corner
		);

		/*
		ivec4 corners = ivec4(mod(vec4(floor(coord), ceil(coord)), noiseTextureResolution));

		vec4 sample = vec4(
			texelFetch2D(noisetex, corners.xy, 0).r, //random value at the (0, 0) corner
			texelFetch2D(noisetex, corners.xw, 0).r, //random value at the (0, 1) corner
			texelFetch2D(noisetex, corners.zy, 0).r, //random value at the (1, 0) corner
			texelFetch2D(noisetex, corners.zw, 0).r  //random value at the (1, 1) corner
		);
		*/

		vec4 high = vec4(greaterThan(samples, threshold.xxxx));
		vec4 low = vec4(lessThan(samples, threshold.yyyy));

		vec2 mixlvl = interpolateSmooth2(middle); //non-linear interpolation

		return
			mix(mix(high.x, high.y, mixlvl.y), mix(high.z, high.w, mixlvl.y), mixlvl.x) -
			mix(mix(low.x,  low.y,  mixlvl.y), mix(low.z,  low.w,  mixlvl.y), mixlvl.x);
	}

	vec4 drawVoidClouds(in vec3 cloudPosPlayer, inout float volumetric) {
		if (blindness > 0.999) return vec4(0.0);
		float noise = 512.0 / (lengthSquared2(cloudPosPlayer.xz / cloudPosPlayer.y) + 256.0) - 3.0; //reduce cloud density in the distance
		float noiseTime = frameTimeCounter * invNoiseRes;

		vec3 cloudPosWorld = cloudPosPlayer + eyePosition;
		vec2 clumpPos = (cloudPosWorld.xz + vec2(frameTimeCounter * 2.0, 0.0)) / 256.0; //divide into 256-block-long cells
		float clumpingFactor = thresholdSample(clumpPos, vec2(0.75, 0.25)); //pick a random value for each cell. if it's above 0.75, it gets +1 density. if it's below 0.25, it gets -1 density.
		noise += clumpingFactor;

		//now to add some randomness so they look roughly cloud-shaped
		float speed = noiseTime * 2.0;
		vec2 cloudPos = cloudPosWorld.xz * invNoiseRes;
		cloudPos.x += noiseTime * 0.5; //multiplying by 0.5 instead of 2 so that clouds look like they're "spreading" as well as being blown around
		noise += texture2D(noisetex, (cloudPos + goldenOffset0 * speed) * 0.015625).r;
		noise += texture2D(noisetex, (cloudPos + goldenOffset1 * speed) * 0.03125 ).r * 0.6;
		noise += texture2D(noisetex, (cloudPos + goldenOffset2 * speed) * 0.0625  ).r * 0.36;
		noise += texture2D(noisetex, (cloudPos + goldenOffset3 * speed) * 0.125   ).r * 0.216;
		noise += texture2D(noisetex, (cloudPos + goldenOffset4 * speed) * 0.25    ).r * 0.1296;
		noise += texture2D(noisetex, (cloudPos + goldenOffset5 * speed) * 0.5     ).r * 0.07776;
		noise += texture2D(noisetex, (cloudPos + goldenOffset6 * speed)           ).r * 0.046656;
		noise += texture2D(noisetex, (cloudPos + goldenOffset7 * speed) * 2.0     ).r * 0.0279936;

		if (noise > 0.0) { //there are indeed clouds here
			vec3 color = vec3(noise * 0.0625); //base cloud color
			bool speckles = volumetric < 0.0;
			if (volumetric > 0.0) {
				volumetric = 1.0 - volumetric / (1.0 - fogify(noise, 0.125));
				if (volumetric < 0.0) return vec4(0.0);
			}

			//lightning effects:
			if (clumpingFactor > 0.0) { //only apply lightning to high-density cloud areas
				float lightningMultiplier = interpolateSmooth1(max(1.0 - length(fract(clumpPos + 0.5) * 2.0 - 1.0), 0.0)); //1.0 at the centers of cells (cells referring to the sample points collected by clumpingFactor), and 0.0 at the edges.
				vec2 lightningOffset = (texture2D(noisetex, (floor(clumpPos + 0.5) + 0.5) * invNoiseRes).gb * 0.5 + 0.5) * noiseTime; //random position to sample from
				float lightningAmt = max(texture2D(noisetex, lightningOffset).r * 8.0 - 7.0, 0.0); //do sample on that position to get lightning amount
				lightningAmt *= texture2D(noisetex, lightningOffset.yx * 32.0).r; //multiply by another value that changes more rapidly, this makes the lightning flicker instead of just fading in/out
				color += lightningAmt * lightningMultiplier * clumpingFactor * noise; //add final value.
			}

			//sparkly square confetti things:
			if (speckles) {
				vec3 data = texture2D(noisetex, (floor((cloudPosWorld.xz + vec2(frameTimeCounter, 0.0)) * 2.0) + 0.5) * invNoiseRes).rgb; //r = hue, gb = another random offset
				float amt = texture2D(noisetex, data.gb * noiseTime * 0.25).r; //base brightness of square
				amt = max(amt * 8.0 - 8.0 + noise, 0.0); //add bias so that there are more squares where cloud density is high
				color += hue(data.r * 0.35 + 0.45) * amt; //color of square
			}

			noise = min(noise * 1.5, 1.0); //add bias to noise so that clouds reach 100% opacity in highly dense regions
			return vec4(color, interpolateSmooth1(noise)) * (1.0 - blindness);
		}
		else return vec4(0.0);
	}
#endif

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	Position pos;
	float depth = texture2D(depthtex0, texcoord).r;
	pos.isSky = depth == 1.0;
	vec4 tmp = gbufferProjectionInverse * vec4(vec3(texcoord, depth) * 2.0 - 1.0, 1.0);
	pos.view = tmp.xyz / tmp.w;
	pos.player = mat3(gbufferModelViewInverse) * pos.view;
	pos.world = pos.player + eyePosition;
	pos.blockDist = length(pos.view);
	pos.viewNorm = pos.view / pos.blockDist;
	pos.playerNorm = pos.player / pos.blockDist;

	if (pos.isSky) {
		#if defined(ENDER_NEBULAE) || defined(ENDER_STARS)
			//adding 1.0 to posNorm.y is how I get the sky to "wrap" around you.
			//if you want to visualize the effect this has, I would suggest setting color to vec3(fract(skyPos), 0.0).
			vec2 skyPos = pos.playerNorm.xz / (pos.playerNorm.y + 1.0);
			//wrapping behavior produces a mathematical singularity below you, so we just reduce the opacity there to hide that.
			float multiplier = 8.0 / (lengthSquared2(skyPos) + 8.0);

			#ifdef ENDER_NEBULAE
				vec4 cloudclr = drawNebulae(skyPos);
				color = mix(color, cloudclr.rgb, cloudclr.a * multiplier);
			#endif

			#ifdef ENDER_STARS
				vec3 starclr = drawStars(skyPos);
				color += starclr * multiplier;
			#endif
		#endif

		color *= 1.0 - blindness;
	}

	#ifdef VOID_CLOUDS
		float cloudDiff = VOID_CLOUD_HEIGHT - eyePosition.y;
		bool cloudy = sign(cloudDiff) == sign(pos.player.y);

		if (cloudy) {
			vec3 baseCloudPos = vec3(pos.playerNorm.xz * (cloudDiff / pos.playerNorm.y), cloudDiff).xzy;
			float opacityModifier = -1.0;

			if (!pos.isSky && pos.blockDist * pos.blockDist < lengthSquared3(baseCloudPos)) { //terrain in front of the clouds
				opacityModifier = abs(pos.world.y - VOID_CLOUD_HEIGHT) / 4.0;
				if (opacityModifier < 1.0) { //in the fadeout range
					baseCloudPos = pos.player;
				}
				else {
					cloudy = false;
				}
			}

			if (cloudy) {
				vec4 cloudclr = drawVoidClouds(baseCloudPos, opacityModifier);

				if (cloudclr.a > 0.001) {
					if (opacityModifier > 0.0 && opacityModifier < 1.0) { //in the fadeout range
						cloudclr.a *= interpolateSmooth1(opacityModifier);
					}
					color = mix(color, cloudclr.rgb, cloudclr.a);
				}
			}
		}
	#endif

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}