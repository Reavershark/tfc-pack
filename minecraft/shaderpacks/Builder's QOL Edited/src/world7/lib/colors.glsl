#ifdef DYNAMIC_LIGHTS
	heldLightColor = calcHeldLightColor();
#endif

#ifdef CROSS_PROCESS
	vec3 skyCrossColor   = vec3(1.1, 1.4, 1.2);
	vec3 blockCrossColor = mix(vec3(1.4, 1.0, 0.8), vec3(1.2, 1.1, 1.0), eyeBrightnessSmooth.x / 240.0); //cross processing color from block lights
	crossProcessColor  = mix(mix(vec3(1.0), skyCrossColor, lmcoord.y), blockCrossColor, lmcoord.x); //final cross-processing color (blockCrossColor takes priority over skyCrossColor)
#endif