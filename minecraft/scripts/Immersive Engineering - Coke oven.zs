import mods.immersiveengineering.CokeOven;

// Remove all
CokeOven.removeRecipe(<immersiveengineering:material:6>);
CokeOven.removeRecipe(<immersiveengineering:stone_decoration:3>);
CokeOven.removeRecipe(<minecraft:coal:1>);

// Add TFC Coal to cokes
CokeOven.addRecipe(<immersiveengineering:material:6> * 1, 500, <tfc:ore/bituminous_coal>, 1000);
CokeOven.addRecipe(<immersiveengineering:material:6> * 1, 500, <tfc:ore/lignite>, 1200);
CokeOven.addRecipe(<immersiveengineering:material:6> * 1, 500, <tfc:peat>, 1200);

// Add TFC logs to charcoal
CokeOven.addRecipe(<minecraft:coal:1> * 1, 100, <ore:logWood>, 900);