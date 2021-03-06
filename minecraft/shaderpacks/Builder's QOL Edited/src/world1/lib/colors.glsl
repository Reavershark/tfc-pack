#ifdef DYNAMIC_LIGHTS
	heldLightColor = calcHeldLightColor();
#endif

blockLightColor = mix(vec3(1.0, 0.5, 0.15), vec3(1.0, 0.85, 0.7), eyeBrightnessSmooth.x / 240.0);

#ifdef CROSS_PROCESS
	vec3 skyCrossColor = vec3(1.0, 0.75, 1.5); //cross processing color from the sky
	vec3 blockCrossColor = mix(vec3(1.4, 1.0, 0.8), vec3(1.2, 1.1, 1.0), eyeBrightnessSmooth.x / 240.0); //cross processing color from block lights
	crossProcessColor = mix(skyCrossColor, blockCrossColor, lmcoord.x); //final cross-processing color
#endif