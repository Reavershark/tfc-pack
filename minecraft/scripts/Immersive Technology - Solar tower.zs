import mods.immersivetechnology.SolarTower;

// Remove vanilla water
SolarTower.removeRecipe(<liquid:water>);

// Add fresh water to steam
SolarTower.addRecipe(<liquid:steam>*450, <liquid:fresh_water>*250, 20);
