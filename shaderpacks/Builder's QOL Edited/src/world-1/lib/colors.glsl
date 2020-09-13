#ifdef DYNAMIC_LIGHTS
	heldLightColor = calcHeldLightColor();
#endif

vec3 nearBlockLightColor = vec3(1.4, 1.1, 0.8); //block light color when the player is near a light source
vec3 farBlockLightColor = vec3(1.5, 0.75, 0.25); //block light color when the plater is far from a light source
#if MC_VERSION >= 11600
	float soul = inSoulSandValley * smoothstep(32.0, 48.0, vPosPlayer.y + eyePosition.y);
	nearBlockLightColor = mix(nearBlockLightColor, vec3(0.8, 1.1, 1.4), soul);
	farBlockLightColor = mix(farBlockLightColor, vec3(0.25, 0.75, 1.5), soul);
#endif
blockLightColor = mix(farBlockLightColor, farBlockLightColor, eyeBrightnessSmooth.x / 240.0);

#ifdef CROSS_PROCESS
	vec3 skyCrossColor = vec3(1.5, 1.0, 0.75); //cross processing color from the sky
	vec3 blockCrossColor = mix(vec3(1.4, 1.0, 0.8), vec3(1.2, 1.1, 1.0), eyeBrightnessSmooth.x / 240.0); //cross processing color from block lights
	crossProcessColor = mix(skyCrossColor, blockCrossColor, lmcoord.x); //final cross-processing color
#endif