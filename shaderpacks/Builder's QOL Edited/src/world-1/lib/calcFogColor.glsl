#ifdef FOG_ENABLED_NETHER
	vec3 calcFogColor(inout Position pos) {
		vec3 fogclr = fogColor * (1.0 - nightVision * 0.5);
		float oldBrightness = (fogclr.r + fogclr.g + fogclr.b) * 0.33333333;
		float newBrightness = oldBrightness * 0.25 / (oldBrightness + 0.25);
		fogclr *= newBrightness / oldBrightness;
		float n = square(texture2D(noisetex, frameTimeCounter * vec2(0.21562, 0.19361) * invNoiseRes).r) - 0.1;
		if (n > 0.0) {
			vec3 brightFog = vec3(
				fogclr.r * (n + 1.0),
				mix(fogclr.g, max(fogclr.r, fogclr.b * 2.0), n),
				fogclr.b
			);
			return mix(fogclr, brightFog, fogify(pos.playerNorm.y, 0.125));
		}
		else {
			return fogclr;
		}
	}
#endif