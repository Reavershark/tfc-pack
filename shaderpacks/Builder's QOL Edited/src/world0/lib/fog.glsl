#ifdef UNDERWATER_FOG
	if (isEyeInWater == 1) {
		color.rgb = calcUnderwaterFogColor(color.rgb, pos, eyeBrightnessSmooth.y / 240.0);
	}
	else {
#endif
		#ifdef FOG_ENABLED_OVERWORLD
			float d = pos.viewDist + wetness * eyeBrightnessSmooth.y * 0.00125 - 0.2; //wetness * 0.3 * eyeBrightness / 240.0
			if (d > 0.0) {
				d = fogify(d * (rainStrength + 1.0) * exp2(1.5 - pos.world.y * 0.015625), FOG_DISTANCE_MULTIPLIER_OVERWORLD);
				color.rgb = mix(calcFogColor(pos) * min(max(lmcoord.y * 2.0, eyeBrightness.y / 120.0), 1.0), color.rgb, d);
			}
		#endif
#ifdef UNDERWATER_FOG
	}
#endif