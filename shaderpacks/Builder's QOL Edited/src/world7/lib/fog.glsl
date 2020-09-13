#ifdef UNDERWATER_FOG
	if (isEyeInWater == 1) {
		color.rgb = calcUnderwaterFogColor(color.rgb, pos.blockDist, eyeBrightnessSmooth.y / 240.0);
	}
	else {
#endif
		#ifdef FOG_ENABLED_TF
			float density = pos.viewDist - 0.2; //wetness * 0.3 * eyeBrightness / 240.0
			if (density > 0.0) {
				density = fogify(density * exp2(1.5 - pos.world.y * 0.015625), FOG_DISTANCE_MULTIPLIER_TF);
				color.rgb = mix(calcFogColor(pos.playerNorm) * min(max(lmcoord.y * 2.0, eyeBrightness.y / 120.0), 1.0), color.rgb, density);
			}
		#endif
#ifdef UNDERWATER_FOG
	}
#endif