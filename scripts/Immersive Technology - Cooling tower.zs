import mods.immersivetechnology.CoolingTower;

// Remove vanilla water
CoolingTower.removeRecipe(<liquid:exhauststeam>*900, <liquid:water>*1000);

CoolingTower.addRecipe(<liquid:fresh_water>*750, <liquid:fresh_water>*750, <liquid:exhauststeam>*900, <liquid:fresh_water>*1000, 3);