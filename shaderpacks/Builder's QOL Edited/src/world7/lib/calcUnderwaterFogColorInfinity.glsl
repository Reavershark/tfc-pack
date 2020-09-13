//simpler algorithm for the special case where distance = infinity (for infinite oceans)
vec3 calcUnderwaterFogColorInfinity(float brightness) {
	return vec3(WATER_SCATTER_R, WATER_SCATTER_G, WATER_SCATTER_B) * brightness;
}