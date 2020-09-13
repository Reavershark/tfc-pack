vec3 calcFogColor(vec3 playerPosNorm) {
	#ifndef CUBIC_CHUNKS
		if (eyePosition.y < 0.0) return vec3(0.0);
	#endif

	return mix(skyColor, fogColor, fogify(max(playerPosNorm.y, 0.0), 0.0625));
}