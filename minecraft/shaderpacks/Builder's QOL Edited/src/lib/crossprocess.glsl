#ifdef CROSS_PROCESS
	//vec3(color.g + color.b, color.r + color.b, color.r + color.g)
	color.rgb = clamp(color.rgb * crossProcessColor - (color.grr + color.bbg) * 0.1, 0.0, 1.0);
#endif