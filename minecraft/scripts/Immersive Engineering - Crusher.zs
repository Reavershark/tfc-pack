import mods.immersiveengineering.Crusher;

// Remove recipes
Crusher.removeRecipe(<minecraft:gravel>);
Crusher.removeRecipe(<minecraft:sand>);
Crusher.removeRecipe(<minecraft:clay_ball>);
Crusher.removeRecipesForInput(<minecraft:bone>);
Crusher.removeRecipe(<minecraft:quartz>);
Crusher.removeRecipe(<minecraft:glowstone_dust>);
Crusher.removeRecipe(<minecraft:blaze_powder>);
Crusher.removeRecipesForInput(<immersiveengineering:stone_decoration:3>); // Coke block
Crusher.removeRecipe(<minecraft:string>);
Crusher.removeRecipesForInput(<minecraft:gold_ore>);
Crusher.removeRecipesForInput(<minecraft:iron_ore>);
Crusher.removeRecipesForInput(<minecraft:lapis_ore>);
Crusher.removeRecipesForInput(<minecraft:diamond_ore>);
Crusher.removeRecipesForInput(<minecraft:redstone_ore>);
Crusher.removeRecipesForInput(<minecraft:emerald_ore>);
Crusher.removeRecipesForInput(<minecraft:coal_ore>);
Crusher.removeRecipesForInput(<minecraft:quartz_ore>);
Crusher.removeRecipe(<immersiveengineering:metal:18>); // Iron grit
Crusher.removeRecipe(<minecraft:prismarine_crystals>);
Crusher.removeRecipe(<tfc:powder/lapis_lazuli>);
Crusher.removeRecipe(<tfc:powder/sulfur>);
Crusher.removeRecipe(<tfc:powder/saltpeter>);
Crusher.removeRecipe(<tfc:powder/kaolinite>);
Crusher.removeRecipe(<tfc:powder/graphite>);
Crusher.removeRecipesForInput(<immersiveengineering:ore:0>);
Crusher.removeRecipesForInput(<immersiveengineering:ore:1>);
Crusher.removeRecipesForInput(<immersiveengineering:ore:2>);
Crusher.removeRecipesForInput(<immersiveengineering:ore:3>);
Crusher.removeRecipesForInput(<immersiveengineering:ore:4>);
Crusher.removeRecipesForInput(<immersiveengineering:ore:5>);

// Fix a few duplicate dust recipes
Crusher.removeRecipe(<tfc:metal/dust/bismuth_bronze>);
Crusher.removeRecipe(<tfc:metal/dust/black_bronze>);
Crusher.removeRecipe(<tfc:metal/dust/bronze>);
Crusher.removeRecipe(<tfc:metal/dust/copper>);
Crusher.removeRecipe(<tfc:metal/dust/gold>);
Crusher.removeRecipe(<tfc:metal/dust/lead>);
Crusher.removeRecipe(<tfc:metal/dust/nickel>);
Crusher.removeRecipe(<tfc:metal/dust/silver>);
Crusher.removeRecipe(<tfc:metal/dust/aluminium>);
Crusher.removeRecipe(<tfc:metal/dust/uranium>);
Crusher.addRecipe(<tfc:metal/dust/bismuth_bronze>, <ore:ingotBismuthBronze>, 3600);
Crusher.addRecipe(<tfc:metal/dust/black_bronze>, <ore:ingotBlackBronze>, 3600);
Crusher.addRecipe(<tfc:metal/dust/bronze>, <ore:ingotBronze>, 3600);
Crusher.addRecipe(<tfc:metal/dust/copper>, <ore:ingotCopper>, 3600);
Crusher.addRecipe(<tfc:metal/dust/gold>, <ore:ingotGold>, 3600);
Crusher.addRecipe(<tfc:metal/dust/lead>, <ore:ingotLead>, 3600);
Crusher.addRecipe(<tfc:metal/dust/nickel>, <ore:ingotNickel>, 3600);
Crusher.addRecipe(<tfc:metal/dust/silver>, <ore:ingotSilver>, 3600);
Crusher.addRecipe(<tfc:metal/dust/aluminium>, <ore:ingotAluminium>, 3600);
Crusher.addRecipe(<tfc:metal/dust/uranium>, <ore:ingotUranium>, 3600);

// Flour
Crusher.addRecipe(<tfc:food/barley_flour>, <tfc:food/barley_grain>, 1800);
Crusher.addRecipe(<tfc:food/cornmeal_flour>, <tfc:food/maize>, 1800);
Crusher.addRecipe(<tfc:food/oat_flour>, <tfc:food/oat_grain>, 1800);
Crusher.addRecipe(<tfc:food/rice_flour>, <tfc:food/rice_grain>, 1800);
Crusher.addRecipe(<tfc:food/rye_flour>, <tfc:food/rye_grain>, 1800);
Crusher.addRecipe(<tfc:food/wheat_flour>, <tfc:food/wheat_grain>, 1800);

// Ores
Crusher.addRecipe(<tfc:powder/flux>*2, <ore:rockFlux>, 3600);
Crusher.addRecipe(<minecraft:redstone>*8, <tfc:ore/cinnabar>, 3600);
Crusher.addRecipe(<minecraft:redstone>*8, <tfc:ore/cryolite>, 3600);
Crusher.addRecipe(<tfc:powder/hematite>*2, <tfc:ore/small/hematite>, 3600);
Crusher.addRecipe(<tfc:powder/hematite>*3, <tfc:ore/hematite:1>, 3600);
Crusher.addRecipe(<tfc:powder/hematite>*5, <tfc:ore/hematite>, 3600);
Crusher.addRecipe(<tfc:powder/hematite>*7, <tfc:ore/hematite:2>, 3600);
Crusher.addRecipe(<tfc:powder/limonite>*2, <tfc:ore/small/limonite>, 3600);
Crusher.addRecipe(<tfc:powder/limonite>*3, <tfc:ore/limonite:1>, 3600);
Crusher.addRecipe(<tfc:powder/limonite>*5, <tfc:ore/limonite>, 3600);
Crusher.addRecipe(<tfc:powder/limonite>*7, <tfc:ore/limonite:2>, 3600);
Crusher.addRecipe(<tfc:powder/malachite>*2, <tfc:ore/small/malachite>, 3600);
Crusher.addRecipe(<tfc:powder/malachite>*3, <tfc:ore/malachite:1>, 3600);
Crusher.addRecipe(<tfc:powder/malachite>*5, <tfc:ore/malachite>, 3600);
Crusher.addRecipe(<tfc:powder/malachite>*7, <tfc:ore/malachite:2>, 3600);
Crusher.addRecipe(<tfc:powder/fertilizer>*4, <tfc:ore/sylvite>, 3600);
Crusher.addRecipe(<tfc:powder/sulfur>*4, <tfc:ore/sulfur>, 3600);
Crusher.addRecipe(<tfc:powder/saltpeter>*4, <tfc:ore/saltpeter>, 3600);
Crusher.addRecipe(<tfc:powder/charcoal>*4, <minecraft:coal:1>, 3600);
Crusher.addRecipe(<tfc:powder/salt>*4, <tfc:rock/rocksalt>, 3600);
Crusher.addRecipe(<tfc:powder/graphite>*4, <tfc:ore/graphite>, 3600);
Crusher.addRecipe(<tfc:powder/kaolinite>*4, <tfc:ore/kaolinite>, 3600);
Crusher.addRecipe(<tfc:gem/diamond:2>, <tfc:ore/kimberlite>, 3600);
Crusher.addRecipe(<tfc:ore/gypsum>, <tfc:raw/limestone>, 3600);
Crusher.addRecipe(<tfc:metal/dust/uranium>*4, <tfc:ore/pitchblende>, 3600);
Crusher.addRecipe(<tfc:metal/dust/boron>*4, <tfc:ore/borax>, 3600);
Crusher.addRecipe(<tfc:powder/flux>*6, <tfc:ore/fluorite>, 3600);

// Bone meal
Crusher.addRecipe(<minecraft:dye:15>*3, <minecraft:bone>, 1800);
Crusher.addRecipe(<minecraft:dye:15>*9, <minecraft:bone_block>, 3600);