#ifdef FOG_ENABLED_NETHER
	color.rgb = mix(
		calcFogColor(pos),
		color.rgb,
		exp2(
			pos.viewDist
			* exp2(abs(pos.world.y - 128.0) * -0.03125 + 4.0)
			* -FOG_DISTANCE_MULTIPLIER_NETHER
		)
	);
#endif