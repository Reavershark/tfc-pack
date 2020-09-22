import mods.immersivetechnology.Distiller;

// Remove vanilla water
Distiller.removeRecipe(<liquid:water>);

// Fresh water
Distiller.addRecipe(<liquid:distwater>*500, <liquid:fresh_water>*1000, <tfc:powder/salt>, 10000, 100, 0.01F);

// Salt water
Distiller.addRecipe(<liquid:distwater>*500, <liquid:salt_water>*1000, <tfc:powder/salt>, 10000, 100, 0.5F);