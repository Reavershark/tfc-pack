#ifdef UNDERWATER_FOG
	if (isEyeInWater == 1) {
		color.rgb = calcUnderwaterFogColor(color.rgb, pos, eyeBrightnessSmooth.y / 240.0);
	}
	else {
#endif
		#ifdef FOG_ENABLED_OVERWORLD
			float fogAmount = pos.viewDist + wetness * eyeBrightnessSmooth.y * 0.00125 - 0.2; //wetness * 0.3 * eyeBrightness / 240.0
			if (fogAmount > 0.0) {
				fogAmount = fogify(fogAmount * (rainStrength + 1.0) * exp2(1.5 - pos.world.y * 0.015625), FOG_DISTANCE_MULTIPLIER_OVERWORLD);
				vec3 fogclr = calcFogColor(pos);
				fogclr += texture2D(noisetex, gl_FragCoord.xy * invNoiseRes).rgb * 0.00390625; //dither to match sky
				color.rgb = mix(fogclr * min(max(lmcoord.y * 2.0, eyeBrightness.y / 120.0), 1.0), color.rgb, fogAmount);
				#if defined(BLUR_ENABLED) && WATER_BLUR != 0
					waterBlur *= fogAmount;
				#endif
			}
		#endif
#ifdef UNDERWATER_FOG
	}
#endif