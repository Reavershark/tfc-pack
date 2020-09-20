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



/*

//Remove Crusher Recipes


Crusher.removeRecipe(<immersiveengineering:material:24>);
Crusher.removeRecipesForInput(<tfc:ore/sulfur>);
Crusher.removeRecipesForInput(<minecraft:diamond_ore>);
Crusher.removeRecipesForInput(<tfc:ore/graphite>);
Crusher.removeRecipesForInput(<tfc:ore/kaolinite>);

//Crusher

//Chalk
Crusher.addRecipe(<contenttweaker:powder_chalk> * 4, <tfc:rock/chalk>, 4000, <contenttweaker:powder_chalk> * 1, 0.25);

//Grain
Crusher.addRecipe(<tfc:food/barley_grain> * 1, <tfc:food/barley>, 4000, <tfc:food/barley_grain> * 1, 0.15);
Crusher.addRecipe(<tfc:food/oat_grain> * 1, <tfc:food/oat>, 4000, <tfc:food/oat_grain> * 1, 0.15);
Crusher.addRecipe(<tfc:food/rice_grain> * 1, <tfc:food/rice>, 4000, <tfc:food/rice_grain> * 1, 0.5);
Crusher.addRecipe(<tfc:food/rye_grain> * 1, <tfc:food/rye>, 4000, <tfc:food/rye_grain> * 1, 0.15);
Crusher.addRecipe(<tfc:food/wheat_grain> * 1, <tfc:food/wheat>, 4000, <tfc:food/wheat_grain> * 1, 0.15);

//Flour
Crusher.addRecipe(<tfc:food/barley_flour> * 2, <tfc:food/barley_grain>, 4000, <tfc:food/barley_flour> * 1, 0.1);
Crusher.addRecipe(<tfc:food/cornmeal_flour> * 2, <tfc:food/maize>, 4000, <tfc:food/cornmeal_flour> * 1, 0.1);
Crusher.addRecipe(<tfc:food/oat_flour> * 2, <tfc:food/oat_grain>, 4000, <tfc:food/oat_flour> * 1, 0.1);
Crusher.addRecipe(<tfc:food/rice_flour> * 2, <tfc:food/rice_grain>, 4000, <tfc:food/rice_flour> * 1, 0.1);
Crusher.addRecipe(<tfc:food/rye_flour> * 2, <tfc:food/rye_grain>, 4000, <tfc:food/rye_flour> * 1, 0.1);
Crusher.addRecipe(<tfc:food/wheat_flour> * 2, <tfc:food/wheat_grain>, 4000, <tfc:food/wheat_flour> * 1, 0.1);

//Minerals
Crusher.addRecipe(<tfc:powder/kaolinite> * 12, <ore:gemKaolinite>, 8000);
Crusher.addRecipe(<tfc:powder/salt> * 8, <ore:gemGypsum>, 8000, <minecraft:dye:15> * 3, 0.5);
Crusher.addRecipe(<minecraft:glowstone_dust> * 12, <ore:gemSelenite>, 8000, <thaumcraft:nugget:5> * 1, 0.5);
Crusher.addRecipe(<tfc:powder/graphite> * 12, <ore:gemGraphite>, 8000);
Crusher.addRecipe(<tfc:gem/diamond:2> * 2, <ore:gemKimberlite>, 8000);
Crusher.addRecipe(<tfc:powder/sulfur> * 10, <ore:gemSulfur>, 8000, <minecraft:blaze_powder> * 2, 0.5);
Crusher.addRecipe(<minecraft:redstone> * 12, <ore:gemCinnabar>, 8000, <thaumcraft:nugget:5> * 4, 0.5);
Crusher.addRecipe(<minecraft:redstone> * 12, <ore:gemCryolite>, 8000, <thaumcraft:nugget:5> * 4, 0.5);
Crusher.addRecipe(<tfc:powder/saltpeter> * 12, <ore:gemSaltpeter>, 8000);
Crusher.addRecipe(<tfc:powder/fertilizer> * 12, <ore:gemSylvite>, 8000);
Crusher.addRecipe(<tfc:powder/flux> * 15, <ore:gemBorax>, 8000, <minecraft:dye:15> * 3, 0.5);
Crusher.addRecipe(<tfc:powder/lapis_lazuli> * 12, <ore:gemLapis>, 8000);
//Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/chalk>, 8000);
//Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/dolomite>, 8000);
//Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/limestone>, 8000);
//Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/marble>, 8000);
Crusher.addRecipe(<tfc:powder/flux> * 6, <ore:rockFlux>, 8000);
Crusher.addRecipe(<tfc:powder/salt> * 8, <ore:rockRocksalt>, 8000);
Crusher.addRecipe(<tfc:gem/diamond> * 5, <ore:oreDiamond>, 8000);

//Metals
Crusher.addRecipe(<tfc:powder/hematite> * 2, <tfc:ore/small/hematite>, 8000);
Crusher.addRecipe(<tfc:powder/hematite> * 3, <tfc:ore/hematite:1>, 8000);
Crusher.addRecipe(<tfc:powder/hematite> * 6, <tfc:ore/hematite>, 8000);
Crusher.addRecipe(<tfc:powder/hematite> * 8, <tfc:ore/hematite:2>, 8000);

Crusher.addRecipe(<tfc:powder/limonite> * 2, <tfc:ore/small/limonite>, 8000);
Crusher.addRecipe(<tfc:powder/limonite> * 3, <tfc:ore/limonite:1>, 8000);
Crusher.addRecipe(<tfc:powder/limonite> * 6, <tfc:ore/limonite>, 8000);
Crusher.addRecipe(<tfc:powder/limonite> * 8, <tfc:ore/limonite:2>, 8000);

Crusher.addRecipe(<tfc:powder/malachite> * 2, <tfc:ore/small/malachite>, 8000);
Crusher.addRecipe(<tfc:powder/malachite> * 3, <tfc:ore/malachite:1>, 8000);
Crusher.addRecipe(<tfc:powder/malachite> * 6, <tfc:ore/malachite>, 8000);
Crusher.addRecipe(<tfc:powder/malachite> * 8, <tfc:ore/malachite:2>, 8000);

Crusher.addRecipe(<tfc:metal/dust/bismuth> * 1, <tfc:metal/ingot/bismuth>, 8000);
Crusher.addRecipe(<tfc:metal/dust/bismuth_bronze> * 1, <tfc:metal/ingot/bismuth_bronze>, 8000);
Crusher.addRecipe(<tfc:metal/dust/black_bronze> * 1, <tfc:metal/ingot/black_bronze>, 8000);
Crusher.addRecipe(<tfc:metal/dust/brass> * 1, <tfc:metal/ingot/brass>, 8000);
Crusher.addRecipe(<tfc:metal/dust/bronze> * 1, <tfc:metal/ingot/bronze>, 8000);
Crusher.addRecipe(<tfc:metal/dust/copper> * 1, <tfc:metal/ingot/copper>, 8000);
Crusher.addRecipe(<tfc:metal/dust/gold> * 1, <tfc:metal/ingot/gold>, 8000);
Crusher.addRecipe(<tfc:metal/dust/lead> * 1, <tfc:metal/ingot/lead>, 8000);
Crusher.addRecipe(<tfc:metal/dust/nickel> * 1, <tfc:metal/ingot/nickel>, 8000);
Crusher.addRecipe(<tfc:metal/dust/rose_gold> * 1, <tfc:metal/ingot/rose_gold>, 8000);
Crusher.addRecipe(<tfc:metal/dust/silver> * 1, <tfc:metal/ingot/silver>, 8000);
Crusher.addRecipe(<tfc:metal/dust/tin> * 1, <tfc:metal/ingot/tin>, 8000);
Crusher.addRecipe(<tfc:metal/dust/zinc> * 1, <tfc:metal/ingot/zinc>, 8000);
Crusher.addRecipe(<tfc:metal/dust/sterling_silver> * 1, <tfc:metal/ingot/sterling_silver>, 8000);
Crusher.addRecipe(<tfc:metal/dust/pig_iron> * 1, <tfc:metal/ingot/pig_iron>, 8000);
Crusher.addRecipe(<tfc:metal/dust/steel> * 1, <tfc:metal/ingot/steel>, 8000);
Crusher.addRecipe(<tfc:metal/dust/platinum> * 1, <tfc:metal/ingot/platinum>, 8000);
Crusher.addRecipe(<tfc:metal/dust/black_steel> * 1, <tfc:metal/ingot/black_steel>, 8000);
Crusher.addRecipe(<tfc:metal/dust/blue_steel> * 1, <tfc:metal/ingot/blue_steel>, 8000);
Crusher.addRecipe(<tfc:metal/dust/red_steel> * 1, <tfc:metal/ingot/red_steel>, 8000);
Crusher.addRecipe(<tfc:metal/dust/antimony> * 1, <tfc:metal/ingot/antimony>, 8000);
Crusher.addRecipe(<tfc:metal/dust/constantan> * 1, <tfc:metal/ingot/constantan>, 8000);
Crusher.addRecipe(<tfc:metal/dust/electrum> * 1, <tfc:metal/ingot/electrum>, 8000);
Crusher.addRecipe(<tfc:metal/dust/mithril> * 1, <tfc:metal/ingot/mithril>, 8000);
Crusher.addRecipe(<tfc:metal/dust/invar> * 1, <tfc:metal/ingot/invar>, 8000);
Crusher.addRecipe(<tfc:metal/dust/aluminium> * 1, <tfc:metal/ingot/aluminium>, 8000);
Crusher.addRecipe(<tfc:metal/dust/aluminium_brass> * 1, <tfc:metal/ingot/aluminium_brass>, 8000);
Crusher.addRecipe(<tfc:metal/dust/ardite> * 1, <tfc:metal/ingot/ardite>, 8000);
Crusher.addRecipe(<tfc:metal/dust/cobalt> * 1, <tfc:metal/ingot/cobalt>, 8000);
Crusher.addRecipe(<tfc:metal/dust/manyullyn> * 1, <tfc:metal/ingot/manyullyn>, 8000);
Crusher.addRecipe(<tfc:metal/dust/osmium> * 1, <tfc:metal/ingot/osmium>, 8000);
Crusher.addRecipe(<tfc:metal/dust/titanium> * 1, <tfc:metal/ingot/titanium>, 8000);
Crusher.addRecipe(<tfc:metal/dust/tungsten> * 1, <tfc:metal/ingot/tungsten>, 8000);
Crusher.addRecipe(<tfc:metal/dust/tungsten_steel> * 1, <tfc:metal/ingot/tungsten_steel>, 8000);

*/