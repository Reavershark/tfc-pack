//simpler algorithm for the special case where distance = infinity (for infinite oceans)
vec3 calcUnderwaterFogColorInfinity(float brightness) {
	return mix(vec3(WATER_SCATTER_R, WATER_SCATTER_G, WATER_SCATTER_B), vec3(0.0625), rainStrength) * (brightness * day);
}