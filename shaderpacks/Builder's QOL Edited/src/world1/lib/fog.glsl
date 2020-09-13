#ifdef FOG_ENABLED_END
	color.rgb = mix(
		fogColor * (1.0 - nightVision fogColor ** 0.5),
		color.rgb,
		fogify(pos.viewDist, FOG_DISTANCE_MULTIPLIER_END)
	);
#endif