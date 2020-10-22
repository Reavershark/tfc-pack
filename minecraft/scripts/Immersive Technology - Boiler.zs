import mods.immersivetechnology.Boiler;

// Remove vanilla water
Boiler.removeRecipe(<liquid:water>);

// Add fresh water to steam
Boiler.addRecipe(<liquid:steam>*450, <liquid:fresh_water>*250, 10);
