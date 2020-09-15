import mods.jei.JEI;

// Replace ingot recipes with tfc ingots
recipes.replaceAllOccurences(<immersiveengineering:metal:0>, <tfc:metal/ingot/copper>);
recipes.replaceAllOccurences(<immersiveengineering:metal:1>, <tfc:metal/ingot/aluminium>);
recipes.replaceAllOccurences(<immersiveengineering:metal:2>, <tfc:metal/ingot/lead>);
recipes.replaceAllOccurences(<immersiveengineering:metal:3>, <tfc:metal/ingot/silver>);
recipes.replaceAllOccurences(<immersiveengineering:metal:4>, <tfc:metal/ingot/nickel>);
recipes.replaceAllOccurences(<immersiveengineering:metal:5>, <tfc:metal/ingot/uranium>);
recipes.replaceAllOccurences(<immersiveengineering:metal:6>, <tfc:metal/ingot/constantan>);
recipes.replaceAllOccurences(<immersiveengineering:metal:7>, <tfc:metal/ingot/electrum>);
recipes.replaceAllOccurences(<immersiveengineering:metal:8>, <tfc:metal/ingot/steel>);

// Remove all ores
JEI.removeAndHide(<immersiveengineering:ore:*>);

// Remove all block recipes except lead and steel
JEI.removeAndHide(<immersiveengineering:storage:0>);
JEI.removeAndHide(<immersiveengineering:storage:1>);
JEI.removeAndHide(<immersiveengineering:storage:3>);
JEI.removeAndHide(<immersiveengineering:storage:4>);
JEI.removeAndHide(<immersiveengineering:storage:5>);
JEI.removeAndHide(<immersiveengineering:storage:6>);
JEI.removeAndHide(<immersiveengineering:storage:7>);

// Remove all metal slabs
JEI.removeAndHide(<immersiveengineering:storage_slab:*>);
recipes.removeShaped(<immersiveengineering:storage:*>, [[<immersiveengineering:storage_slab:*>],[<immersiveengineering:storage_slab:*>]]);

// Coke block
recipes.remove(<immersiveengineering:stone_decoration>);
recipes.addShaped("ct_coke_block", <immersiveengineering:stone_decoration>, [
  [<tfc:mortar>, <tfc:ceramics/fired/fire_brick>, <tfc:mortar>],
  [<tfc:ceramics/fired/fire_brick>, <tfc:powder/charcoal>, <tfc:ceramics/fired/fire_brick>],
  [<tfc:mortar>, <tfc:ceramics/fired/fire_brick>, <tfc:mortar>]
]);

// Reinforced coke block
recipes.remove(<immersivetech:stone_decoration>);
recipes.addShaped("ct_reinforced_coke_block", <immersivetech:stone_decoration>, [
  [<tfctech:metal/steel_long_rod>, <tfc:mortar>, <tfctech:metal/steel_long_rod>],
  [<tfc:mortar>, <immersiveengineering:stone_decoration>, <tfc:mortar>],
  [<tfctech:metal/steel_long_rod>, <tfc:mortar>, <tfctech:metal/steel_long_rod>]
]);

// Blast brick
recipes.remove(<immersiveengineering:stone_decoration:1>);
recipes.addShaped("ct_blast_brick", <immersiveengineering:stone_decoration:1>, [
  [<tfc:mortar>, <tfc:ceramics/fired/fire_brick>, <tfc:mortar>],
  [<tfc:ceramics/fired/fire_brick>, <tfc:metal/dust/red_steel>, <tfc:ceramics/fired/fire_brick>],
  [<tfc:mortar>, <tfc:ceramics/fired/fire_brick>, <tfc:mortar>]
]);

// Reinforced blast brick
recipes.remove(<immersiveengineering:stone_decoration:2>);
recipes.addShaped("ct_reinforced_blast_brick", <immersiveengineering:stone_decoration:2>, [
  [<tfctech:metal/steel_long_rod>, <tfc:mortar>, <tfctech:metal/steel_long_rod>],
  [<tfc:mortar>, <immersiveengineering:stone_decoration:1>, <tfc:mortar>],
  [<tfctech:metal/steel_long_rod>, <tfc:mortar>, <tfctech:metal/steel_long_rod>]
]);

// Remove weird slabs
JEI.removeAndHide(<immersiveengineering:stone_decoration_slab:*>);

// Remove hempcrete
JEI.removeAndHide(<immersiveengineering:stone_decoration:4>);
JEI.removeAndHide(<immersiveengineering:stone_decoration_stairs_hempcrete>);

// Remove regular, tiled and leaded concrete
// Regular concrete only obtainable by casting liquid concrete now
recipes.remove(<immersiveengineering:stone_decoration:5>);
JEI.removeAndHide(<immersiveengineering:stone_decoration:6>);
JEI.removeAndHide(<immersiveengineering:stone_decoration:7>);
JEI.removeAndHide(<immersiveengineering:stone_decoration_stairs_concrete>);
JEI.removeAndHide(<immersiveengineering:stone_decoration_stairs_concrete_tile>);
JEI.removeAndHide(<immersiveengineering:stone_decoration_stairs_concrete_leaded>);

// Remove asphalt concrete
JEI.removeAndHide(<immersivepetroleum:stone_decoration>);

// Remove coal coke block
JEI.removeAndHide(<immersiveengineering:stone_decoration:3>);

// Insulating glass recipe
recipes.remove(<immersiveengineering:stone_decoration:8>);
mods.immersiveengineering.ArcFurnace.addRecipe(<immersiveengineering:stone_decoration:8>, <minecraft:glass>, null, 100, 512, [<tfc:metal/dust/wrought_iron>]);

// Kiln brick
recipes.remove(<immersiveengineering:stone_decoration:10>);
recipes.addShaped("ct_kiln_brick", <immersiveengineering:stone_decoration:10>, [
  [<tfc:mortar>, <minecraft:brick>, <tfc:mortar>],
  [<minecraft:brick>, <tfc:powder/kaolinite>, <minecraft:brick>],
  [<tfc:mortar>, <minecraft:brick>, <tfc:mortar>]
]);

// Treated wood
recipes.remove(<immersiveengineering:treated_wood>*8);
mods.terrafirmacraft.Barrel.addRecipe("ct:treated_wood_planks", <ore:plankWood>, <liquid:creosote>*125, <immersiveengineering:treated_wood>, null, 16);
mods.terrafirmacraft.Barrel.addRecipe("ct:treated_wood_sticks", <ore:stickWood>*2, <liquid:creosote>*125, <immersiveengineering:material>*2, null, 16);

// Replace hemp with jute
JEI.removeAndHide(<immersiveengineering:material:4>);
<ore:fiberHemp>.remove(<immersiveengineering:material:4>);
<ore:fiberHemp>.add(<tfc:crop/product/jute_fiber>);

// Remove storage crate (shulker box)
JEI.removeAndHide(<immersiveengineering:wooden_device0:0>);
JEI.removeAndHide(<immersiveengineering:wooden_device0:5>);
JEI.removeAndHide(<immersivetech:wooden_crate>);

// Keep only the extendable post
JEI.removeAndHide(<immersiveengineering:wooden_device1:3>);
JEI.removeAndHide(<immersiveengineering:metal_decoration2:0>);
JEI.removeAndHide(<immersiveengineering:metal_decoration2:2>);
recipes.replaceAllOccurences(<minecraft:stonebrick>, <ore:brickStone>, <immersiveposts:postbase>);
recipes.replaceAllOccurences(<minecraft:cobblestone>, <ore:cobblestone>, <immersiveposts:postbase>);

// Use burlap cloth for tough fabric
recipes.remove(<immersiveengineering:material:5>);
recipes.addShapeless("ct_tough_fabric", <immersiveengineering:material:5>, [<minecraft:stick>, <tfc:crop/product/burlap_cloth>]);

// Remove balloon light source
JEI.removeAndHide(<immersiveengineering:cloth_device:1>);


/*
//=======================================================================================================================================================================
//Basic Recipes

  //Replace Items
  recipes.replaceAllOccurences(<minecraft:cobblestone>, <ore:cobblestone>, <immersiveposts:postbase>);
  recipes.replaceAllOccurences(<minecraft:gravel>, <ore:gravel>, <immersiveengineering:stone_decoration:5>);

  //Remove
  furnace.remove(<immersiveengineering:metal:0>);
  furnace.remove(<immersiveengineering:metal:1>);
  furnace.remove(<immersiveengineering:metal:2>);
  furnace.remove(<immersiveengineering:metal:3>);
  furnace.remove(<immersiveengineering:metal:4>);
  furnace.remove(<immersiveengineering:metal:5>);
  furnace.remove(<immersiveengineering:metal:6>);
  furnace.remove(<immersiveengineering:metal:7>);
  furnace.remove(<immersiveengineering:metal:8>);
  recipes.remove(<immersiveengineering:pickaxe_steel>);
  recipes.remove(<immersiveengineering:shovel_steel>);
  recipes.remove(<immersiveengineering:axe_steel>);
  recipes.remove(<immersiveengineering:sword_steel>);
  recipes.remove(<immersiveengineering:tool>);
  recipes.remove(<immersiveengineering:tool:1>);
  recipes.remove(<immersiveengineering:material:1>);
  recipes.remove(<immersiveengineering:material:2>);
  recipes.remove(<immersiveengineering:material:3>);
  recipes.remove(<immersiveengineering:stone_decoration>);
  recipes.remove(<immersiveengineering:stone_decoration:1>);
  recipes.remove(<immersiveengineering:stone_decoration:2>);
  recipes.remove(<immersiveengineering:stone_decoration:10>);
  recipes.remove(<immersiveengineering:steel_armor_head>);
  recipes.remove(<immersiveengineering:steel_armor_chest>);
  recipes.remove(<immersiveengineering:steel_armor_legs>);
  recipes.remove(<immersiveengineering:steel_armor_feet>);
  recipes.remove(<immersiveengineering:faraday_suit_head>);
  recipes.remove(<immersiveengineering:faraday_suit_chest>);
  recipes.remove(<immersiveengineering:faraday_suit_legs>);
  recipes.remove(<immersiveengineering:faraday_suit_feet>);
  recipes.remove(<immersiveposts:metal_rods>);
  recipes.remove(<immersiveposts:metal_rods:1>);
  recipes.remove(<immersiveposts:metal_rods:2>);
  recipes.remove(<immersiveposts:metal_rods:3>);
  recipes.remove(<immersiveposts:metal_rods:4>);
  recipes.remove(<immersiveposts:metal_rods:5>);
  recipes.remove(<immersiveposts:metal_rods:6>);
  recipes.remove(<immersiveposts:metal_rods:7>);
  recipes.remove(<immersiveengineering:metal:8>);
  recipes.remove(<immersiveengineering:metal:30>);
  recipes.remove(<immersiveengineering:metal:31>);
  recipes.remove(<immersiveengineering:metal:32>);
  recipes.remove(<immersiveengineering:metal:33>);
  recipes.remove(<immersiveengineering:metal:34>);
  recipes.remove(<immersiveengineering:metal:35>);
  recipes.remove(<immersiveengineering:metal:36>);
  recipes.remove(<immersiveengineering:metal:37>);
  recipes.remove(<immersiveengineering:metal:38>);
  recipes.remove(<immersiveengineering:metal:39>);
  recipes.remove(<immersiveengineering:metal:40>);
  
  //Add
  recipes.addShaped(<tfc:metal/ingot/steel>, [[<ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>],[<ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>], [<ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>]]);
  recipes.addShaped(<immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:conveyor"}) * 8, [[<ore:rubber>, <ore:rubber>, <ore:rubber>], [<ore:ingotIron>, <ore:dustRedstone>, <ore:ingotIron>]]);
  recipes.addShaped(<immersiveengineering:tool>, [[null, <tfc:metal/hammer_head/wrought_iron>, <ore:string>], [null, <ore:stickWood>, <tfc:metal/hammer_head/wrought_iron>], [<ore:stickWood>, null, null]]);
  recipes.addShaped(<immersiveengineering:tool:1>, [[null, <tfc:metal/knife_blade/wrought_iron>, null], [<tfc:metal/knife_blade/wrought_iron>, <ore:string>, <ore:stickWood>], [null, <ore:stickWood>, null]]);
//	recipes.addShaped(<immersiveengineering:stone_decoration> * 2, [[<ore:sand>, <tfc:ceramics/fired/fire_brick>, <ore:sand>], [<tfc:ceramics/fired/fire_brick>, <tfc:mortar>, <tfc:ceramics/fired/fire_brick>], [<ore:sand>, <tfc:ceramics/fired/fire_brick>, <ore:sand>]]);
//	recipes.addShaped(<immersiveengineering:stone_decoration:1> * 2, [[<ore:blockSand>, <tfc:ceramics/fired/fire_brick>, <ore:blockSand>], [<tfc:ceramics/fired/fire_brick>, <ore:blockSand>, <tfc:ceramics/fired/fire_brick>], [<ore:blockSand>, <tfc:ceramics/fired/fire_brick>, <ore:blockSand>]]);
//	recipes.addShaped(<immersiveengineering:stone_decoration:2> * 2, [[<tfc:mortar>, <tfc:ceramics/fired/fire_brick>, <tfc:mortar>], [<tfc:ceramics/fired/fire_brick>, <tfc:mortar>, <tfc:ceramics/fired/fire_brick>], [<tfc:mortar>, <tfc:ceramics/fired/fire_brick>, <tfc:mortar>]]);
//	recipes.addShaped(<immersiveengineering:stone_decoration:10> * 2, [[<tfc:ceramics/fired/fire_brick>, <tfc:ceramics/fired/fire_brick>, <tfc:ceramics/fired/fire_brick>], [<tfc:ceramics/fire_clay>, <tfc:mortar>, <tfc:ceramics/fire_clay>], [<tfc:ceramics/fired/fire_brick>, <tfc:ceramics/fired/fire_brick>, <tfc:ceramics/fired/fire_brick>]]);
  recipes.addShapeless(<immersiveengineering:material:23>, [<ore:plateSteel>, <ore:shears>]);
  recipes.addShapeless(<immersiveengineering:material:22>, [<ore:plateAluminum>, <ore:shears>]);
  recipes.addShapeless(<immersiveengineering:material:21>, [<ore:plateElectrum>, <ore:shears>]);
  recipes.addShapeless(<immersiveengineering:material:20>, [<ore:plateCopper>, <ore:shears>]);
  recipes.replaceAllOccurences(<ore:blockSteel>, <ore:ingotDoubleSteel>, <immersiveengineering:drillhead>);
  recipes.replaceAllOccurences(<ore:blockIron>, <ore:ingotDoubleWroughtIron>, <immersiveengineering:drillhead:1>);
  recipes.addShapeless(<tfc:metal/sheet/copper>, [<immersiveengineering:sheetmetal>]);
  recipes.addShapeless(<tfc:metal/sheet/aluminium>, [<immersiveengineering:sheetmetal:1>]);
  recipes.addShapeless(<tfc:metal/sheet/lead>, [<immersiveengineering:sheetmetal:2>]);
  recipes.addShapeless(<tfc:metal/sheet/silver>, [<immersiveengineering:sheetmetal:3>]);
  recipes.addShapeless(<tfc:metal/sheet/nickel>, [<immersiveengineering:sheetmetal:4>]);
  //recipes.addShapeless(<contenttweaker:uranium_sheet>, [<immersiveengineering:sheetmetal:5>]);
  recipes.addShapeless(<tfc:metal/sheet/constantan>, [<immersiveengineering:sheetmetal:6>]);
  recipes.addShapeless(<tfc:metal/sheet/electrum>, [<immersiveengineering:sheetmetal:7>]);
  recipes.addShapeless(<tfc:metal/sheet/steel>, [<immersiveengineering:sheetmetal:8>]);
  recipes.addShapeless(<tfc:metal/sheet/wrought_iron>, [<immersiveengineering:sheetmetal:9>]);
  recipes.addShapeless(<tfc:metal/sheet/gold>, [<immersiveengineering:sheetmetal:10>]);
  recipes.addShapeless(<immersiveengineering:material> * 2, [<ore:saw>.transformDamage(1), <ore:plankTreatedWood>]);
  recipes.addShapeless(<tfc:metal/ingot/steel> * 9, [<ore:blockSteel>]);

//=======================================================================================================================================================================
//Immersive Engineering Machine Recipes

//Remove Crusher Recipes

  mods.immersiveengineering.Crusher.removeRecipe(<immersiveengineering:material:24>);
  mods.immersiveengineering.Crusher.removeRecipesForInput(<tfc:ore/sulfur>);
  mods.immersiveengineering.Crusher.removeRecipesForInput(<minecraft:diamond_ore>);
  mods.immersiveengineering.Crusher.removeRecipesForInput(<tfc:ore/graphite>);
  mods.immersiveengineering.Crusher.removeRecipesForInput(<tfc:ore/kaolinite>);

//Crusher

  //Chalk
  mods.immersiveengineering.Crusher.addRecipe(<contenttweaker:powder_chalk> * 4, <tfc:rock/chalk>, 4000, <contenttweaker:powder_chalk> * 1, 0.25);

  //Grain
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/barley_grain> * 1, <tfc:food/barley>, 4000, <tfc:food/barley_grain> * 1, 0.15);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/oat_grain> * 1, <tfc:food/oat>, 4000, <tfc:food/oat_grain> * 1, 0.15);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/rice_grain> * 1, <tfc:food/rice>, 4000, <tfc:food/rice_grain> * 1, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/rye_grain> * 1, <tfc:food/rye>, 4000, <tfc:food/rye_grain> * 1, 0.15);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/wheat_grain> * 1, <tfc:food/wheat>, 4000, <tfc:food/wheat_grain> * 1, 0.15);
  
  //Flour
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/barley_flour> * 2, <tfc:food/barley_grain>, 4000, <tfc:food/barley_flour> * 1, 0.1);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/cornmeal_flour> * 2, <tfc:food/maize>, 4000, <tfc:food/cornmeal_flour> * 1, 0.1);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/oat_flour> * 2, <tfc:food/oat_grain>, 4000, <tfc:food/oat_flour> * 1, 0.1);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/rice_flour> * 2, <tfc:food/rice_grain>, 4000, <tfc:food/rice_flour> * 1, 0.1);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/rye_flour> * 2, <tfc:food/rye_grain>, 4000, <tfc:food/rye_flour> * 1, 0.1);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:food/wheat_flour> * 2, <tfc:food/wheat_grain>, 4000, <tfc:food/wheat_flour> * 1, 0.1);
  
  //Minerals
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/kaolinite> * 12, <ore:gemKaolinite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/salt> * 8, <ore:gemGypsum>, 8000, <minecraft:dye:15> * 3, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<minecraft:glowstone_dust> * 12, <ore:gemSelenite>, 8000, <thaumcraft:nugget:5> * 1, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/graphite> * 12, <ore:gemGraphite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:gem/diamond:2> * 2, <ore:gemKimberlite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/sulfur> * 10, <ore:gemSulfur>, 8000, <minecraft:blaze_powder> * 2, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<minecraft:redstone> * 12, <ore:gemCinnabar>, 8000, <thaumcraft:nugget:5> * 4, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<minecraft:redstone> * 12, <ore:gemCryolite>, 8000, <thaumcraft:nugget:5> * 4, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/saltpeter> * 12, <ore:gemSaltpeter>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/fertilizer> * 12, <ore:gemSylvite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/flux> * 15, <ore:gemBorax>, 8000, <minecraft:dye:15> * 3, 0.5);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/lapis_lazuli> * 12, <ore:gemLapis>, 8000);
  //mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/chalk>, 8000);
  //mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/dolomite>, 8000);
  //mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/limestone>, 8000);
  //mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/flux> * 6, <tfc:rock/marble>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/flux> * 6, <ore:rockFlux>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/salt> * 8, <ore:rockRocksalt>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:gem/diamond> * 5, <ore:oreDiamond>, 8000);

  //Metals
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/hematite> * 2, <tfc:ore/small/hematite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/hematite> * 3, <tfc:ore/hematite:1>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/hematite> * 6, <tfc:ore/hematite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/hematite> * 8, <tfc:ore/hematite:2>, 8000);

  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/limonite> * 2, <tfc:ore/small/limonite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/limonite> * 3, <tfc:ore/limonite:1>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/limonite> * 6, <tfc:ore/limonite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/limonite> * 8, <tfc:ore/limonite:2>, 8000);

  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/malachite> * 2, <tfc:ore/small/malachite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/malachite> * 3, <tfc:ore/malachite:1>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/malachite> * 6, <tfc:ore/malachite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:powder/malachite> * 8, <tfc:ore/malachite:2>, 8000);
  
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/bismuth> * 1, <tfc:metal/ingot/bismuth>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/bismuth_bronze> * 1, <tfc:metal/ingot/bismuth_bronze>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/black_bronze> * 1, <tfc:metal/ingot/black_bronze>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/brass> * 1, <tfc:metal/ingot/brass>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/bronze> * 1, <tfc:metal/ingot/bronze>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/copper> * 1, <tfc:metal/ingot/copper>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/gold> * 1, <tfc:metal/ingot/gold>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/lead> * 1, <tfc:metal/ingot/lead>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/nickel> * 1, <tfc:metal/ingot/nickel>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/rose_gold> * 1, <tfc:metal/ingot/rose_gold>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/silver> * 1, <tfc:metal/ingot/silver>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/tin> * 1, <tfc:metal/ingot/tin>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/zinc> * 1, <tfc:metal/ingot/zinc>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/sterling_silver> * 1, <tfc:metal/ingot/sterling_silver>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/pig_iron> * 1, <tfc:metal/ingot/pig_iron>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/steel> * 1, <tfc:metal/ingot/steel>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/platinum> * 1, <tfc:metal/ingot/platinum>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/black_steel> * 1, <tfc:metal/ingot/black_steel>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/blue_steel> * 1, <tfc:metal/ingot/blue_steel>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/red_steel> * 1, <tfc:metal/ingot/red_steel>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/antimony> * 1, <tfc:metal/ingot/antimony>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/constantan> * 1, <tfc:metal/ingot/constantan>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/electrum> * 1, <tfc:metal/ingot/electrum>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/mithril> * 1, <tfc:metal/ingot/mithril>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/invar> * 1, <tfc:metal/ingot/invar>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/aluminium> * 1, <tfc:metal/ingot/aluminium>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/aluminium_brass> * 1, <tfc:metal/ingot/aluminium_brass>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/ardite> * 1, <tfc:metal/ingot/ardite>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/cobalt> * 1, <tfc:metal/ingot/cobalt>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/manyullyn> * 1, <tfc:metal/ingot/manyullyn>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/osmium> * 1, <tfc:metal/ingot/osmium>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/titanium> * 1, <tfc:metal/ingot/titanium>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/tungsten> * 1, <tfc:metal/ingot/tungsten>, 8000);
  mods.immersiveengineering.Crusher.addRecipe(<tfc:metal/dust/tungsten_steel> * 1, <tfc:metal/ingot/tungsten_steel>, 8000);


//=======================================================================================================================================================================
//Squeezer

  //Paper
  mods.immersiveengineering.Squeezer.addRecipe(<minecraft:paper> * 2, null, <contenttweaker:cellulose_fibers>, 512);

  //Seeds
  mods.immersiveengineering.Squeezer.addRecipe(null, <liquid:plantoil> * 80, <ore:listAllseeds>, 512);

  //Scraped Hide
  mods.immersiveengineering.Squeezer.addRecipe(<tfc:hide/scraped/small>, <liquid:limewater> * 30, <tfc:hide/soaked/small>, 512);
  mods.immersiveengineering.Squeezer.addRecipe(<tfc:hide/scraped/medium>, <liquid:limewater> * 40, <tfc:hide/soaked/medium>, 512);
  mods.immersiveengineering.Squeezer.addRecipe(<tfc:hide/scraped/large>, <liquid:limewater> * 50, <tfc:hide/soaked/large>, 512);


//=======================================================================================================================================================================
//Distillation

  //Salt
  mods.immersivepetroleum.Distillation.addRecipe([<liquid:fresh_water> * 1], [<tfc:powder/salt> * 1], <liquid:salt_water> * 1, 128, 150, [1, 1]);
  
  //Cheese
  mods.immersivepetroleum.Distillation.addRecipe([<liquid:milk_vinegar> * 500], [<tfc:food/cheese> * 16], <liquid:milk_curdled> * 1000, 128, 1200, [1, 1]);
  

//=======================================================================================================================================================================
//Refinery

  //Brine
  mods.immersiveengineering.Refinery.addRecipe(<liquid:brine> * 2, <liquid:vinegar>, <liquid:salt_water>, 512);
  
  //Curdled Milk
  mods.immersiveengineering.Refinery.addRecipe(<liquid:milk_curdled>, <liquid:vinegar>, <liquid:milk>, 512);
  

//=======================================================================================================================================================================
//Fermenter

  //Remove
  mods.immersiveengineering.Fermenter.removeByInput(<minecraft:reeds>);
  mods.immersiveengineering.Fermenter.removeByInput(<minecraft:melon>);
  mods.immersiveengineering.Fermenter.removeByInput(<minecraft:apple>);
  mods.immersiveengineering.Fermenter.removeByInput(<minecraft:potato>);
  
  //Add
  mods.immersiveengineering.Fermenter.addRecipe(null, <liquid:ethanol> * 80, <ore:listAllveggie>, 512);
  mods.immersiveengineering.Fermenter.addRecipe(null, <liquid:ethanol> * 80, <ore:listAllfruit>, 512);
  mods.immersiveengineering.Fermenter.addRecipe(null, <liquid:ethanol> * 40, <ore:listAllberry>, 512);
  mods.immersiveengineering.Fermenter.addRecipe(null, <liquid:ethanol> * 80, <ore:sugarcane>, 512);


//=======================================================================================================================================================================
//Mixer

  //Alcohol
  mods.immersiveengineering.Mixer.addRecipe(<liquid:beer> * 1000, <liquid:fresh_water> * 1000, [<tfc:food/barley_grain> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:cider> * 1000, <liquid:fresh_water> * 1000, [<ore:cropApple> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:rum> * 1000, <liquid:fresh_water> * 1000, [<ore:sugarcane> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:sake> * 1000, <liquid:fresh_water> * 1000, [<tfc:food/rice_grain> * 4], 1024);
  //mods.immersiveengineering.Mixer.addRecipe(<liquid:sake> * 1000, <liquid:fresh_water> * 1000, [<harvestcraft:riceitem> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vodka> * 1000, <liquid:fresh_water> * 1000, [<ore:cropPotato> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:whiskey> * 1000, <liquid:fresh_water> * 1000, [<tfc:food/wheat_grain> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:corn_whiskey> * 1000, <liquid:fresh_water> * 1000, [<ore:cropCorn> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:corn_whiskey> * 1000, <liquid:fresh_water> * 1000, [<ore:cropMaize> * 4], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:rye_whiskey> * 1000, <liquid:fresh_water> * 1000, [<tfc:food/rye_grain> * 4], 1024);

  //Vinegar
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:beer> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:beer> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:cider> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:cider> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:rum> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:rum> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:sake> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:sake> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:vodka> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:vodka> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:whiskey> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:whiskey> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:corn_whiskey> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:corn_whiskey> * 1000, [<ore:listAllfruit> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:rye_whiskey> * 1000, [<ore:listAllberry> * 10], 1024);
  mods.immersiveengineering.Mixer.addRecipe(<liquid:vinegar> * 1000, <liquid:rye_whiskey> * 1000, [<ore:listAllfruit> * 10], 1024);
  
  //Limewater
  mods.immersiveengineering.Mixer.addRecipe(<liquid:limewater> * 1000, <liquid:fresh_water> * 1000, [<ore:dustFlux> * 2], 512);
  
  //Tannin
  mods.immersiveengineering.Mixer.addRecipe(<liquid:tannin> * 1000, <liquid:fresh_water> * 1000, [<ore:logWoodTannin>], 1024);
  
  //Dicyanoacetylene
  mods.immersiveengineering.Mixer.addRecipe(<liquid:dicyanoacetylene>, null, [<ore:dustSaltpeter>, <tfc:powder/graphite>], 10240);
  

//=======================================================================================================================================================================
//Bottling Machine

  //Raw Hide to Soaked Hide
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:hide/soaked/small>, <tfc:hide/raw/small>, <liquid:limewater> * 300);
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:hide/soaked/medium>, <tfc:hide/raw/medium>, <liquid:limewater> * 400);
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:hide/soaked/large>, <tfc:hide/raw/large>, <liquid:limewater> * 500);

  //Scraped Hide to Prepared Hide
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:hide/prepared/small>, <tfc:hide/scraped/small>, <liquid:fresh_water> * 300);
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:hide/prepared/medium>, <tfc:hide/scraped/medium>, <liquid:fresh_water> * 400);
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:hide/prepared/large>, <tfc:hide/scraped/large>, <liquid:fresh_water> * 500);

  //Prepared Hide to Leather
  mods.immersiveengineering.BottlingMachine.addRecipe(<minecraft:leather> * 1, <tfc:hide/scraped/small>, <liquid:tannin> * 300);
  mods.immersiveengineering.BottlingMachine.addRecipe(<minecraft:leather> * 2, <tfc:hide/scraped/medium>, <liquid:tannin> * 400);
  mods.immersiveengineering.BottlingMachine.addRecipe(<minecraft:leather> * 3, <tfc:hide/scraped/large>, <liquid:tannin> * 500);

  //Jute Fibre Processing
  mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:crop/product/jute_fiber>, <tfc:crop/product/jute>, <liquid:fresh_water> * 500);
  //mods.immersiveengineering.BottlingMachine.addRecipe(<tfc:crop/product/jute_fiber>, <harvestcraft:juteitem>, <liquid:fresh_water> * 500);


//=======================================================================================================================================================================
//Coke Oven

  //Add
  mods.immersiveengineering.CokeOven.addRecipe(<immersiveengineering:material:6> * 1, 500, <tfc:ore/bituminous_coal>, 1000);
  mods.immersiveengineering.CokeOven.addRecipe(<immersiveengineering:material:6> * 1, 500, <tfc:ore/lignite>, 1200);
  mods.immersiveengineering.CokeOven.addRecipe(<immersiveengineering:material:6> * 1, 500, <tfc:peat>, 1200);
  

//=======================================================================================================================================================================
//Alloy Kiln
  
  //Remove
  mods.immersiveengineering.AlloySmelter.removeRecipe(<tconstruct:ingots:5>);
  mods.immersiveengineering.AlloySmelter.removeRecipe(<thaumcraft:ingot:2>);
  mods.immersiveengineering.AlloySmelter.removeRecipe(<immersiveengineering:metal:6>);
  mods.immersiveengineering.AlloySmelter.removeRecipe(<immersiveengineering:metal:7>);
  
  //Aluminium Brass
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:ingotAluminium> * 3, <ore:ingotCopper>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:dustAluminium> * 3, <ore:dustCopper>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:ingotAluminium> * 3, <ore:dustCopper>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:dustAluminium> * 3, <ore:ingotCopper>, 1200);
  
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:ingotAluminum> * 3, <ore:ingotCopper>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:dustAluminum> * 3, <ore:dustCopper>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:ingotAluminum> * 3, <ore:dustCopper>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/aluminium_brass> * 4, <ore:dustAluminum> * 3, <ore:ingotCopper>, 1200);
  
  //Brass
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/brass> * 4, <ore:ingotCopper> * 3, <ore:ingotZinc>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/brass> * 4, <ore:dustCopper> * 3, <ore:dustZinc>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/brass> * 4, <ore:ingotCopper> * 3, <ore:dustZinc>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/brass> * 4, <ore:dustCopper> * 3, <ore:ingotZinc>, 1200);
  
  //Constantan
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/constantan> * 2, <ore:ingotCopper> * 3, <ore:ingotNickel>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/constantan> * 2, <ore:dustCopper> * 3, <ore:dustNickel>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/constantan> * 2, <ore:ingotCopper> * 3, <ore:dustNickel>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/constantan> * 2, <ore:dustCopper> * 3, <ore:ingotNickel>, 1200);
  
  //Electrum
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/electrum> * 2, <ore:ingotGold> * 3, <ore:ingotSilver>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/electrum> * 2, <ore:dustGold> * 3, <ore:dustSilver>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/electrum> * 2, <ore:ingotGold> * 3, <ore:dustSilver>, 1200);
  mods.immersiveengineering.AlloySmelter.addRecipe(<tfc:metal/ingot/electrum> * 2, <ore:dustGold> * 3, <ore:ingotSilver>, 1200);


//=======================================================================================================================================================================
//Blast Furnace
  
  //Remove

  mods.immersiveengineering.BlastFurnace.removeRecipe(<immersiveengineering:metal:8>);

  //Add
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/steel>, <tfc:metal/ingot/wrought_iron>, 1200, <immersiveengineering:material:7>);

  mods.immersiveengineering.BlastFurnace.addRecipe(<minecraft:netherrack>, <ore:cobblestone>, 6400, <immersiveengineering:material:7>);
  mods.immersiveengineering.BlastFurnace.addRecipe(<minecraft:end_stone>, <ore:stone>, 6400, <immersiveengineering:material:7>);
  mods.immersiveengineering.BlastFurnace.addRecipe(<minecraft:glass>, <ore:blockSand>, 1200, <immersiveengineering:material:7>);

  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/hematite:2> * 3, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/hematite> * 4, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/hematite:1> * 7, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/small/hematite> * 10, 28800, <immersiveengineering:material:7> * 3);

  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/magnetite:2> * 3, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/magnetite> * 4, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/magnetite:1> * 7, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/small/magnetite> * 10, 28800, <immersiveengineering:material:7> * 3);

  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/limonite:2> * 3, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/limonite> * 4, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/limonite:1> * 7, 28800, <immersiveengineering:material:7> * 3);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <tfc:ore/small/limonite> * 10, 28800, <immersiveengineering:material:7> * 3);


  //Ceramics

  //Molds
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/ingot>, <tfc:ceramics/unfired/mold/ingot>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/pick_head>, <tfc:ceramics/unfired/mold/pick_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/shovel_head>, <tfc:ceramics/unfired/mold/shovel_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/axe_head>, <tfc:ceramics/unfired/mold/axe_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/hoe_head>, <tfc:ceramics/unfired/mold/hoe_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/chisel_head>, <tfc:ceramics/unfired/mold/chisel_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/sword_blade>, <tfc:ceramics/unfired/mold/sword_blade>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/mace_head>, <tfc:ceramics/unfired/mold/mace_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/saw_blade>, <tfc:ceramics/unfired/mold/saw_blade>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/javelin_head>, <tfc:ceramics/unfired/mold/javelin_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/hammer_head>, <tfc:ceramics/unfired/mold/hammer_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/propick_head>, <tfc:ceramics/unfired/mold/propick_head>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/knife_blade>, <tfc:ceramics/unfired/mold/knife_blade>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/scythe_blade>, <tfc:ceramics/unfired/mold/scythe_blade>, 600, null);
  
  //Small Vessels - Colored and non-colored
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel>, <tfc:ceramics/unfired/vessel>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:0>, <tfc:ceramics/unfired/vessel_glazed:0>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:1>, <tfc:ceramics/unfired/vessel_glazed:1>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:2>, <tfc:ceramics/unfired/vessel_glazed:2>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:3>, <tfc:ceramics/unfired/vessel_glazed:3>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:4>, <tfc:ceramics/unfired/vessel_glazed:4>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:5>, <tfc:ceramics/unfired/vessel_glazed:5>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:6>, <tfc:ceramics/unfired/vessel_glazed:6>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:7>, <tfc:ceramics/unfired/vessel_glazed:7>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:8>, <tfc:ceramics/unfired/vessel_glazed:8>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:9>, <tfc:ceramics/unfired/vessel_glazed:9>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:10>, <tfc:ceramics/unfired/vessel_glazed:10>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:11>, <tfc:ceramics/unfired/vessel_glazed:11>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:12>, <tfc:ceramics/unfired/vessel_glazed:12>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:13>, <tfc:ceramics/unfired/vessel_glazed:13>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:14>, <tfc:ceramics/unfired/vessel_glazed:14>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:15>, <tfc:ceramics/unfired/vessel_glazed:15>, 600, null);
  
  //Miscellaneous Ceramics
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/pot>, <tfc:ceramics/unfired/pot>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/jug>, <tfc:ceramics/unfired/jug>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/bowl>, <tfc:ceramics/unfired/bowl>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/spindle>, <tfc:ceramics/unfired/spindle>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<tfc:ceramics/fired/fire_brick>, <tfc:ceramics/unfired/fire_brick>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<minecraft:brick>, <minecraft:clay_ball>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<minecraft:netherbrick>, <minecraft:brick>, 600, null);
  mods.immersiveengineering.BlastFurnace.addRecipe(<minecraft:hardened_clay>, <minecraft:clay>, 600, null);
  
  //Mud
  mods.immersiveengineering.BlastFurnace.addRecipe(<contenttweaker:mud_brick>, <contenttweaker:mud_ball>, 400, null);


//=======================================================================================================================================================================
//Metal Press

  //Remove Recipes
  mods.immersiveengineering.MetalPress.removeRecipe(<thaumcraft:plate>);
  mods.immersiveengineering.MetalPress.removeRecipe(<thaumcraft:plate:1>);
  mods.immersiveengineering.MetalPress.removeRecipe(<thaumcraft:plate:2>);
  mods.immersiveengineering.MetalPress.removeRecipe(<thaumcraft:plate:3>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:1>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:2>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:3>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:4>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:5>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:6>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:7>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:8>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:30>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:31>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:32>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:33>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:34>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:35>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:36>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:37>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:38>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:39>);
  mods.immersiveengineering.MetalPress.removeRecipe(<immersiveengineering:metal:40>);

  //Add Recipes
  mods.immersiveengineering.MetalPress.addRecipe(<immersiveengineering:bullet> * 2, <tfc:metal/ingot/brass>, <immersiveengineering:mold:3>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<minecraft:paper> * 2, <contenttweaker:cellulose_fibers>, <immersiveengineering:mold>, 500);
  
  //Unrefined Bloom

  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/copper>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/bismuth_bronze>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/bronze>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/black_bronze>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/wrought_iron>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/steel>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/black_steel>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/blue_steel>, 500);
  //mods.immersiveengineering.MetalPress.addRecipe(<tfc:bloom/refined>, <tfc:bloom/unrefined>, <tfc:metal/hammer_head/red_steel>, 500);
  
  //Weak Steel Ingot
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/weak_steel>, <tfc:metal/ingot/pig_iron>, <tfc:metal/hammer_head/wrought_iron>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/weak_steel>, <tfc:metal/ingot/pig_iron>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/weak_steel>, <tfc:metal/ingot/pig_iron>, <tfc:metal/hammer_head/black_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/weak_steel>, <tfc:metal/ingot/pig_iron>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/weak_steel>, <tfc:metal/ingot/pig_iron>, <tfc:metal/hammer_head/red_steel>, 500);
  
  //Steel Ingot
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/steel>, <tfc:metal/ingot/weak_steel>, <tfc:metal/hammer_head/wrought_iron>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/steel>, <tfc:metal/ingot/weak_steel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/steel>, <tfc:metal/ingot/weak_steel>, <tfc:metal/hammer_head/black_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/steel>, <tfc:metal/ingot/weak_steel>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/steel>, <tfc:metal/ingot/weak_steel>, <tfc:metal/hammer_head/red_steel>, 500);
  
  //Black Steel
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/black_steel>, <tfc:metal/ingot/high_carbon_black_steel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/black_steel>, <tfc:metal/ingot/high_carbon_black_steel>, <tfc:metal/hammer_head/black_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/black_steel>, <tfc:metal/ingot/high_carbon_black_steel>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/black_steel>, <tfc:metal/ingot/high_carbon_black_steel>, <tfc:metal/hammer_head/red_steel>, 500);
  
  //Red Steel
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/red_steel>, <tfc:metal/ingot/high_carbon_red_steel>, <tfc:metal/hammer_head/black_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/red_steel>, <tfc:metal/ingot/high_carbon_red_steel>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/red_steel>, <tfc:metal/ingot/high_carbon_red_steel>, <tfc:metal/hammer_head/red_steel>, 500);
  
  //Blue Steel
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/blue_steel>, <tfc:metal/ingot/high_carbon_blue_steel>, <tfc:metal/hammer_head/black_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/blue_steel>, <tfc:metal/ingot/high_carbon_blue_steel>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/ingot/blue_steel>, <tfc:metal/ingot/high_carbon_blue_steel>, <tfc:metal/hammer_head/red_steel>, 500);


//Clay Molds

  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/ingot>, <minecraft:clay_ball>, <tfc:metal/ingot/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/pick_head>, <minecraft:clay_ball>, <tfc:metal/pick_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/shovel_head>, <minecraft:clay_ball>, <tfc:metal/shovel_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/axe_head>, <minecraft:clay_ball>, <tfc:metal/axe_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/hoe_head>, <minecraft:clay_ball>, <tfc:metal/hoe_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/chisel_head>, <minecraft:clay_ball>, <tfc:metal/chisel_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/sword_blade>, <minecraft:clay_ball>, <tfc:metal/sword_blade/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/mace_head>, <minecraft:clay_ball>, <tfc:metal/mace_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/saw_blade>, <minecraft:clay_ball>, <tfc:metal/saw_blade/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/javelin_head>, <minecraft:clay_ball>, <tfc:metal/javelin_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/hammer_head>, <minecraft:clay_ball>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/propick_head>, <minecraft:clay_ball>, <tfc:metal/propick_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/knife_blade>, <minecraft:clay_ball>, <tfc:metal/knife_blade/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:ceramics/unfired/mold/scythe_blade>, <minecraft:clay_ball>, <tfc:metal/scythe_blade/steel>, 500, 2);


//Double Ingots

  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/copper>, <tfc:metal/ingot/copper>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/steel>, <tfc:metal/ingot/steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/red_steel>, <tfc:metal/ingot/red_steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/blue_steel>, <tfc:metal/ingot/blue_steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/black_steel>, <tfc:metal/ingot/black_steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/gold>, <tfc:metal/ingot/gold>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/silver>, <tfc:metal/ingot/silver>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/bronze>, <tfc:metal/ingot/bronze>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/bismuth>, <tfc:metal/ingot/bismuth>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/pig_iron>, <tfc:metal/ingot/pig_iron>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/bismuth_bronze>, <tfc:metal/ingot/bismuth_bronze>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/zinc>, <tfc:metal/ingot/zinc>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/rose_gold>, <tfc:metal/ingot/rose_gold>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/brass>, <tfc:metal/ingot/brass>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/tin>, <tfc:metal/ingot/tin>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/sterling_silver>, <tfc:metal/ingot/sterling_silver>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/platinum>, <tfc:metal/ingot/platinum>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/nickel>, <tfc:metal/ingot/nickel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/lead>, <tfc:metal/ingot/lead>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/wrought_iron>, <tfc:metal/ingot/wrought_iron>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/black_bronze>, <tfc:metal/ingot/black_bronze>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/aluminium>, <tfc:metal/ingot/aluminium>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/ardite>, <tfc:metal/ingot/ardite>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/cobalt>, <tfc:metal/ingot/cobalt>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/constantan>, <tfc:metal/ingot/constantan>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/electrum>, <tfc:metal/ingot/electrum>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/manyullyn>, <tfc:metal/ingot/manyullyn>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/invar>, <tfc:metal/ingot/invar>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/mithril>, <tfc:metal/ingot/mithril>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/aluminium_brass>, <tfc:metal/ingot/aluminium_brass>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/antimony>, <tfc:metal/ingot/antimony>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/osmium>, <tfc:metal/ingot/osmium>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/titanium>, <tfc:metal/ingot/titanium>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/tungsten>, <tfc:metal/ingot/tungsten>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_ingot/tungsten_steel>, <tfc:metal/ingot/tungsten_steel>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:dragonsteel_fire_double_ingot>, <iceandfire:dragonsteel_fire_ingot>, <tfc:metal/hammer_head/blue_steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:dragonsteel_ice_double_ingot>, <iceandfire:dragonsteel_ice_ingot>, <tfc:metal/hammer_head/blue_steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:thaumium_double_ingot>, <thaumcraft:ingot>, <tfc:metal/hammer_head/blue_steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:void_double_ingot>, <thaumcraft:ingot:1>, <tfc:metal/hammer_head/blue_steel>, 500, 2);


//Metal Sheets

  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/copper>, <tfc:metal/double_ingot/copper>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/steel>, <tfc:metal/double_ingot/steel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/red_steel>, <tfc:metal/double_ingot/red_steel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/blue_steel>, <tfc:metal/double_ingot/blue_steel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/black_steel>, <tfc:metal/double_ingot/black_steel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/gold>, <tfc:metal/double_ingot/gold>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/silver>, <tfc:metal/double_ingot/silver>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/bronze>, <tfc:metal/double_ingot/bronze>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/bismuth>, <tfc:metal/double_ingot/bismuth>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/pig_iron>, <tfc:metal/double_ingot/pig_iron>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/bismuth_bronze>, <tfc:metal/double_ingot/bismuth_bronze>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/zinc>, <tfc:metal/double_ingot/zinc>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/rose_gold>, <tfc:metal/double_ingot/rose_gold>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/brass>, <tfc:metal/double_ingot/brass>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/tin>, <tfc:metal/double_ingot/tin>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/sterling_silver>, <tfc:metal/double_ingot/sterling_silver>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/platinum>, <tfc:metal/double_ingot/platinum>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/nickel>, <tfc:metal/double_ingot/nickel>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/lead>, <tfc:metal/double_ingot/lead>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/wrought_iron>, <tfc:metal/double_ingot/wrought_iron>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/black_bronze>, <tfc:metal/double_ingot/black_bronze>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/aluminium>, <tfc:metal/double_ingot/aluminium>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/ardite>, <tfc:metal/double_ingot/ardite>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/cobalt>, <tfc:metal/double_ingot/cobalt>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/constantan>, <tfc:metal/double_ingot/constantan>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/electrum>, <tfc:metal/double_ingot/electrum>, <tfc:metal/hammer_head/steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/manyullyn>, <tfc:metal/double_ingot/manyullyn>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/invar>, <tfc:metal/double_ingot/invar>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/mithril>, <tfc:metal/double_ingot/mithril>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/aluminium_brass>, <tfc:metal/double_ingot/aluminium_brass>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/antimony>, <tfc:metal/double_ingot/antimony>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/osmium>, <tfc:metal/double_ingot/osmium>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/titanium>, <tfc:metal/double_ingot/titanium>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/tungsten>, <tfc:metal/double_ingot/tungsten>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/sheet/tungsten_steel>, <tfc:metal/double_ingot/tungsten_steel>, <tfc:metal/hammer_head/steel>, 500);	
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:dragonsteel_fire_sheet>, <contenttweaker:dragonsteel_fire_double_ingot>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:dragonsteel_ice_sheet>, <contenttweaker:dragonsteel_ice_double_ingot>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:thaumium_sheet>, <contenttweaker:thaumium_double_ingot>, <tfc:metal/hammer_head/blue_steel>, 500);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:void_sheet>, <contenttweaker:thaumium_double_ingot>, <tfc:metal/hammer_head/blue_steel>, 500);


//Metal Double Sheets

  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/copper>, <tfc:metal/sheet/copper>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/steel>, <tfc:metal/sheet/steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/red_steel>, <tfc:metal/sheet/red_steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/blue_steel>, <tfc:metal/sheet/blue_steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/black_steel>, <tfc:metal/sheet/black_steel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/gold>, <tfc:metal/sheet/gold>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/silver>, <tfc:metal/sheet/silver>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/bronze>, <tfc:metal/sheet/bronze>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/bismuth>, <tfc:metal/sheet/bismuth>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/pig_iron>, <tfc:metal/sheet/pig_iron>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/bismuth_bronze>, <tfc:metal/sheet/bismuth_bronze>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/zinc>, <tfc:metal/sheet/zinc>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/rose_gold>, <tfc:metal/sheet/rose_gold>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/brass>, <tfc:metal/sheet/brass>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/tin>, <tfc:metal/sheet/tin>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/sterling_silver>, <tfc:metal/sheet/sterling_silver>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/platinum>, <tfc:metal/sheet/platinum>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/nickel>, <tfc:metal/sheet/nickel>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/lead>, <tfc:metal/sheet/lead>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/wrought_iron>, <tfc:metal/sheet/wrought_iron>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/black_bronze>, <tfc:metal/sheet/black_bronze>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/aluminium>, <tfc:metal/sheet/aluminium>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/ardite>, <tfc:metal/sheet/ardite>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/cobalt>, <tfc:metal/sheet/cobalt>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/constantan>, <tfc:metal/sheet/constantan>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/electrum>, <tfc:metal/sheet/electrum>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/manyullyn>, <tfc:metal/sheet/manyullyn>, <tfc:metal/hammer_head/steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/invar>, <tfc:metal/sheet/invar>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/mithril>, <tfc:metal/sheet/mithril>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/aluminium_brass>, <tfc:metal/sheet/aluminium_brass>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/antimony>, <tfc:metal/sheet/antimony>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/osmium>, <tfc:metal/sheet/osmium>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/titanium>, <tfc:metal/sheet/titanium>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/tungsten>, <tfc:metal/sheet/tungsten>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<tfc:metal/double_sheet/tungsten_steel>, <tfc:metal/sheet/tungsten_steel>, <tfc:metal/hammer_head/steel>, 500, 2);	
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:dragonsteel_fire_double_sheet>, <contenttweaker:dragonsteel_fire_sheet>, <tfc:metal/hammer_head/blue_steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:dragonsteel_ice_double_sheet>, <contenttweaker:dragonsteel_ice_sheet>, <tfc:metal/hammer_head/blue_steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:thaumium_double_sheet>, <contenttweaker:thaumium_sheet>, <tfc:metal/hammer_head/blue_steel>, 500, 2);
  mods.immersiveengineering.MetalPress.addRecipe(<contenttweaker:void_double_sheet>, <contenttweaker:void_sheet>, <tfc:metal/hammer_head/blue_steel>, 500, 2);


//=======================================================================================================================================================================
//Arc Furnace
  
  //Remove
  mods.immersiveengineering.ArcFurnace.removeRecipe(<tconstruct:ingots:5>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<thaumcraft:ingot:2>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<minecraft:iron_ingot>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<minecraft:gold_ingot>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:0>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:1>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:2>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:3>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:4>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:5>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:6>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:7>);
  mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:8>);

//Ores

  //Wrought Iron
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreWroughtIronRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreWroughtIronRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreWroughtIronNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreWroughtIronNormal>, <ore:oreWroughtIronNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreWroughtIronPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreWroughtIronPoor>, <ore:oreWroughtIronPoor>, <ore:oreWroughtIronPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreWroughtIronSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreWroughtIronSmall>, <ore:oreWroughtIronSmall>, <ore:oreWroughtIronSmall>, <ore:oreWroughtIronSmall>], "Ores");

  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreMagnetiteRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreMagnetiteRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreMagnetiteNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreMagnetiteNormal>, <ore:oreMagnetiteNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreMagnetitePoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreMagnetitePoor>, <ore:oreMagnetitePoor>, <ore:oreMagnetitePoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreMagnetiteSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreMagnetiteSmall>, <ore:oreMagnetiteSmall>, <ore:oreMagnetiteSmall>, <ore:oreMagnetiteSmall>], "Ores");

  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreLimoniteRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreLimoniteRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreLimoniteNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreLimoniteNormal>, <ore:oreLimoniteNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreLimonitePoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreLimonitePoor>, <ore:oreLimonitePoor>, <ore:oreLimonitePoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:bloom/unrefined>, <ore:oreLimoniteSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreLimoniteSmall>, <ore:oreLimoniteSmall>, <ore:oreLimoniteSmall>, <ore:oreLimoniteSmall>], "Ores");

  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/wrought_iron>, <tfc:bloom/refined>, <immersiveengineering:material:7> * 1, 512, 200);

  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/steel>, <ore:ingotIron>, <immersiveengineering:material:7> * 1, 512, 400, [<ore:dustCoke> * 4, <ore:dustFlux> * 2], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/steel>, <ore:dustIron>, <immersiveengineering:material:7> * 1, 512, 400, [<ore:dustCoke> * 4, <ore:dustFlux> * 2], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/steel>, <ore:Iron>, <immersiveengineering:material:7> * 1, 512, 400, [<ore:dustCoke> * 4, <ore:dustFlux> * 2], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/steel>, <ore:ingotPigIron>, <immersiveengineering:material:7> * 1, 512, 400, [<ore:dustCoke> * 4, <ore:dustFlux> * 2], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/steel>, <ore:dustPigIron>, <immersiveengineering:material:7> * 1, 512, 400, [<ore:dustCoke> * 4, <ore:dustFlux> * 2], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/steel>, <ore:dustSteel>, <immersiveengineering:material:7> * 1, 512, 200);

  //Copper
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreCopperRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreCopperRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreCopperNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreCopperNormal>, <ore:oreCopperNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreCopperPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreCopperPoor>, <ore:oreCopperPoor>, <ore:oreCopperPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreCopperSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreCopperSmall>, <ore:oreCopperSmall>, <ore:oreCopperSmall>, <ore:oreCopperSmall>], "Ores");

  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreMalachiteRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreMalachiteRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreMalachiteNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreMalachiteNormal>, <ore:oreMalachiteNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreMalachitePoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreMalachitePoor>, <ore:oreMalachitePoor>, <ore:oreMalachitePoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/copper>, <ore:oreMalachiteSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreMalachiteSmall>, <ore:oreMalachiteSmall>, <ore:oreMalachiteSmall>, <ore:oreMalachiteSmall>], "Ores");

  //Gold
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/gold>, <ore:oreGoldRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreGoldRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/gold>, <ore:oreGoldNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreGoldNormal>, <ore:oreGoldNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/gold>, <ore:oreGoldPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreGoldPoor>, <ore:oreGoldPoor>, <ore:oreGoldPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/gold>, <ore:oreGoldSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreGoldSmall>, <ore:oreGoldSmall>, <ore:oreGoldSmall>, <ore:oreGoldSmall>], "Ores");

  //Platinum
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/platinum>, <ore:orePlatinumRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:orePlatinumRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/platinum>, <ore:orePlatinumNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:orePlatinumNormal>, <ore:orePlatinumNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/platinum>, <ore:orePlatinumPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:orePlatinumPoor>, <ore:orePlatinumPoor>, <ore:orePlatinumPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/platinum>, <ore:orePlatinumSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:orePlatinumSmall>, <ore:orePlatinumSmall>, <ore:orePlatinumSmall>, <ore:orePlatinumSmall>], "Ores");

  //Tin
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tin>, <ore:oreTinRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreTinRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tin>, <ore:oreTinNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreTinNormal>, <ore:oreTinNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tin>, <ore:oreTinPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreTinPoor>, <ore:oreTinPoor>, <ore:oreTinPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tin>, <ore:oreTinSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreTinSmall>, <ore:oreTinSmall>, <ore:oreTinSmall>, <ore:oreTinSmall>], "Ores");

  //Lead
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/lead>, <ore:oreLeadRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreLeadRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/lead>, <ore:oreLeadNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreLeadNormal>, <ore:oreLeadNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/lead>, <ore:oreLeadPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreLeadPoor>, <ore:oreLeadPoor>, <ore:oreLeadPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/lead>, <ore:oreLeadSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreLeadSmall>, <ore:oreLeadSmall>, <ore:oreLeadSmall>, <ore:oreLeadSmall>], "Ores");

  //Bismuth
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/bismuth>, <ore:oreBismuthRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreBismuthRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/bismuth>, <ore:oreBismuthNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreBismuthNormal>, <ore:oreBismuthNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/bismuth>, <ore:oreBismuthPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreBismuthPoor>, <ore:oreBismuthPoor>, <ore:oreBismuthPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/bismuth>, <ore:oreBismuthSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreBismuthSmall>, <ore:oreBismuthSmall>, <ore:oreBismuthSmall>, <ore:oreBismuthSmall>], "Ores");

  //Nickel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/nickel>, <ore:oreNickelRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreNickelRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/nickel>, <ore:oreNickelNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreNickelNormal>, <ore:oreNickelNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/nickel>, <ore:oreNickelPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreNickelPoor>, <ore:oreNickelPoor>, <ore:oreNickelPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/nickel>, <ore:oreNickelSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreNickelSmall>, <ore:oreNickelSmall>, <ore:oreNickelSmall>, <ore:oreNickelSmall>], "Ores");

  //Zinc
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/zinc>, <ore:oreZincRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreZincRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/zinc>, <ore:oreZincNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreZincNormal>, <ore:oreZincNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/zinc>, <ore:oreZincPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreZincPoor>, <ore:oreZincPoor>, <ore:oreZincPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/zinc>, <ore:oreZincSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreZincSmall>, <ore:oreZincSmall>, <ore:oreZincSmall>, <ore:oreZincSmall>], "Ores");


  //Aluminium
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/aluminium>, <ore:oreAluminiumRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreAluminiumRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/aluminium>, <ore:oreAluminiumNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreAluminiumNormal>, <ore:oreAluminiumNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/aluminium>, <ore:oreAluminiumPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreAluminiumPoor>, <ore:oreAluminiumPoor>, <ore:oreAluminiumPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/aluminium>, <ore:oreAluminiumSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreAluminiumSmall>, <ore:oreAluminiumSmall>, <ore:oreAluminiumSmall>, <ore:oreAluminiumSmall>], "Ores");

  //Ardite
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/ardite>, <ore:oreArditeRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreArditeRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/ardite>, <ore:oreArditeNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreArditeNormal>, <ore:oreArditeNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/ardite>, <ore:oreArditePoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreArditePoor>, <ore:oreArditePoor>, <ore:oreArditePoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/ardite>, <ore:oreArditeSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreArditeSmall>, <ore:oreArditeSmall>, <ore:oreArditeSmall>, <ore:oreArditeSmall>], "Ores");

  //Cobalt
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/cobalt>, <ore:oreCobaltRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreCobaltRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/cobalt>, <ore:oreCobaltNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreCobaltNormal>, <ore:oreCobaltNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/cobalt>, <ore:oreCobaltPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreCobaltPoor>, <ore:oreCobaltPoor>, <ore:oreCobaltPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/cobalt>, <ore:oreCobaltSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreCobaltSmall>, <ore:oreCobaltSmall>, <ore:oreCobaltSmall>, <ore:oreCobaltSmall>], "Ores");

  //Tungsten
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tungsten>, <ore:oreTungstenRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreTungstenRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tungsten>, <ore:oreTungstenNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreTungstenNormal>, <ore:oreTungstenNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tungsten>, <ore:oreTungstenPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreTungstenPoor>, <ore:oreTungstenPoor>, <ore:oreTungstenPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/tungsten>, <ore:oreTungstenSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreTungstenSmall>, <ore:oreTungstenSmall>, <ore:oreTungstenSmall>, <ore:oreTungstenSmall>], "Ores");

  //Osmium
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/osmium>, <ore:oreOsmiumRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreOsmiumRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/osmium>, <ore:oreOsmiumNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreOsmiumNormal>, <ore:oreOsmiumNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/osmium>, <ore:oreOsmiumPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreOsmiumPoor>, <ore:oreOsmiumPoor>, <ore:oreOsmiumPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/osmium>, <ore:oreOsmiumSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreOsmiumSmall>, <ore:oreOsmiumSmall>, <ore:oreOsmiumSmall>, <ore:oreOsmiumSmall>], "Ores");

  //Titanium
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/titanium>, <ore:oreTitaniumRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreTitaniumRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/titanium>, <ore:oreTitaniumNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreTitaniumNormal>, <ore:oreTitaniumNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/titanium>, <ore:oreTitaniumPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreTitaniumPoor>, <ore:oreTitaniumPoor>, <ore:oreTitaniumPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/titanium>, <ore:oreTitaniumSmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreTitaniumSmall>, <ore:oreTitaniumSmall>, <ore:oreTitaniumSmall>, <ore:oreTitaniumSmall>], "Ores");

  //Antimony
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/antimony>, <ore:oreAntimonyRich>, <immersiveengineering:material:7> * 2, 512, 200, [<ore:oreAntimonyRich>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/antimony>, <ore:oreAntimonyNormal>, <immersiveengineering:material:7> * 3, 512, 300, [<ore:oreAntimonyNormal>, <ore:oreAntimonyNormal>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/antimony>, <ore:oreAntimonyPoor>, <immersiveengineering:material:7> * 6, 512, 400, [<ore:oreAntimonyPoor>, <ore:oreAntimonyPoor>, <ore:oreAntimonyPoor>], "Ores");
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/antimony>, <ore:oreAntimonySmall>, <immersiveengineering:material:7> * 8, 512, 400, [<ore:oreAntimonySmall>, <ore:oreAntimonySmall>, <ore:oreAntimonySmall>, <ore:oreAntimonySmall>], "Ores");


//Metal Alloys

//Ingots
  //Bismuth Bronze
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/bismuth_bronze> * 4, <ore:ingotBismuth>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotZinc>, <ore:ingotCopper>, <ore:ingotCopper>], "Alloying");

  //Black Bronze
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/black_bronze> * 4, <ore:ingotGold>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotSilver>, <ore:ingotCopper>, <ore:ingotCopper>], "Alloying");

  //Brass
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/brass> * 4, <ore:ingotZinc>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotCopper>], "Alloying");

  //Bronze
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/bronze> * 4, <ore:ingotTin>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotCopper>], "Alloying");

  //Rose Gold
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/rose_gold> * 4, <ore:ingotCopper>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotGold>, <ore:ingotGold>, <ore:ingotGold>], "Alloying");

  //Sterling Silver
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/sterling_silver> * 4, <ore:ingotCopper>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotSilver>, <ore:ingotSilver>, <ore:ingotSilver>], "Alloying");

  //Weak Steel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/weak_steel> * 4, <ore:ingotSteel>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotSteel>, <ore:ingotBlackBronze>, <ore:ingotNickel>], "Alloying");

  //Black High Carbon Steel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/high_carbon_black_steel> * 2, <ore:ingotWeakSteel>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotPigIron>], "Alloying");

  //Weak Red Steel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/weak_red_steel> * 5, <ore:ingotSteel>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:ingotBrass>, <ore:ingotRoseGold>, <ore:ingotBlackSteel>, <ore:ingotBlackSteel>], "Alloying");

  //Weak Blue Steel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/weak_blue_steel> * 5, <ore:ingotSteel>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:ingotSterlingSilver>, <ore:ingotBismuthBronze>, <ore:ingotBlackSteel>, <ore:ingotBlackSteel>], "Alloying");

  //High Carbon Red Steel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/high_carbon_red_steel> * 2, <ore:ingotWeakRedSteel>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotBlackSteel>], "Alloying");

  //High Carbon Blue Steel
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/high_carbon_blue_steel> * 2, <ore:ingotWeakBlueSteel>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotBlackSteel>], "Alloying");

  //Dragonsteel Fire
  mods.immersiveengineering.ArcFurnace.addRecipe(<contenttweaker:dragonsteel_fire_ingot_unrefined> * 5, <ore:ingotRedSteel>, <immersiveengineering:material:7> * 1, 512, 500, [<ore:ingotRedSteel>, <ore:ingotBlackSteel>, <ore:ingotPlatinum>, <ore:ingotRoseGold>], "Alloying");

  //Dragonsteel Ice
  mods.immersiveengineering.ArcFurnace.addRecipe(<contenttweaker:dragonsteel_ice_ingot_unrefined> * 5, <ore:ingotBlueSteel>, <immersiveengineering:material:7> * 1, 512, 500, [<ore:ingotBlueSteel>, <ore:ingotBlackSteel>, <ore:ingotPlatinum>, <ore:ingotSterlingSilver>], "Alloying");

  //Constantan
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/constantan> * 2, <ore:ingotCopper>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotNickel>], "Alloying");

  //Electrum
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/electrum> * 2, <ore:ingotGold>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:ingotSilver>], "Alloying");

  //Mithril
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/mithril> * 5, <ore:ingotCopper>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotCopper>, <ore:ingotCopper>, <ore:ingotAntimony>], "Alloying");

  //Invar
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/invar> * 5, <ore:ingotNickel>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotIron>, <ore:ingotIron>], "Alloying");

  //Aluminium Brass
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/aluminium_brass> * 5, <ore:ingotAluminium>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotAluminium>, <ore:ingotAluminium>, <ore:ingotCopper>], "Alloying");

  //Manyullyn
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/ingot/manyullyn> * 2, <ore:ingotCobalt>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:ingotArdite>], "Alloying");

//Dusts
  //Bismuth Bronze
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/bismuth_bronze> * 4, <ore:dustBismuth>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustZinc>, <ore:dustCopper>, <ore:dustCopper>], "Alloying");

  //Black Bronze
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/black_bronze> * 4, <ore:dustGold>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustSilver>, <ore:dustCopper>, <ore:dustCopper>], "Alloying");

  //Brass
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/brass> * 4, <ore:dustZinc>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustCopper>, <ore:dustCopper>, <ore:dustCopper>], "Alloying");

  //Bronze
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/bronze> * 4, <ore:dustTin>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:dustCopper>, <ore:dustCopper>, <ore:dustCopper>], "Alloying");

  //Rose Gold
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/rose_gold> * 4, <ore:dustCopper>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustGold>, <ore:dustGold>, <ore:dustGold>], "Alloying");

  //Sterling Silver
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/sterling_silver> * 4, <ore:dustCopper>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustSilver>, <ore:dustSilver>, <ore:dustSilver>], "Alloying");

  //Constantan
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/constantan> * 2, <ore:dustCopper>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustNickel>], "Alloying");

  //Electrum
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/electrum> * 2, <ore:dustGold>, <immersiveengineering:material:7> * 1, 512, 200, [<ore:dustFlux>, <ore:dustSilver>], "Alloying");

  //Mithril
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/mithril> * 5, <ore:dustCopper>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:dustCopper>, <ore:dustCopper>, <ore:dustAntimony>], "Alloying");

  //Invar
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/invar> * 5, <ore:dustNickel>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:dustIron>, <ore:dustIron>], "Alloying");

  //Aluminium Brass
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/aluminium_brass> * 5, <ore:dustAluminium>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:dustAluminium>, <ore:dustAluminium>, <ore:dustCopper>], "Alloying");

  //Manyullyn
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:metal/dust/manyullyn> * 2, <ore:dustCobalt>, <immersiveengineering:material:7> * 1, 512, 300, [<ore:dustFlux>, <ore:dustArdite>], "Alloying");


//Cobblestone to Raw Rock

  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/granite>, <tfc:cobble/granite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/granite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/diorite>, <tfc:cobble/diorite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/diorite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/gabbro>, <tfc:cobble/gabbro>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/gabbro>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/shale>, <tfc:cobble/shale>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/shale>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/claystone>, <tfc:cobble/claystone>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/claystone>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/rocksalt>, <tfc:cobble/rocksalt>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/rocksalt>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/limestone>, <tfc:cobble/limestone>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/limestone>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/conglomerate>, <tfc:cobble/conglomerate>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/conglomerate>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/dolomite>, <tfc:cobble/dolomite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/dolomite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/chert>, <tfc:cobble/chert>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/chert>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/chalk>, <tfc:cobble/chalk>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/chalk>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/rhyolite>, <tfc:cobble/rhyolite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/rhyolite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/basalt>, <tfc:cobble/basalt>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/basalt>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/andesite>, <tfc:cobble/andesite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/andesite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/dacite>, <tfc:cobble/dacite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/dacite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/quartzite>, <tfc:cobble/quartzite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/quartzite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/slate>, <tfc:cobble/slate>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/slate>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/phyllite>, <tfc:cobble/phyllite>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/phyllite>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/schist>, <tfc:cobble/schist>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/schist>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/gneiss>, <tfc:cobble/gneiss>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/gneiss>]);
  mods.immersiveengineering.ArcFurnace.addRecipe(<tfc:raw/marble>, <tfc:cobble/marble>, <immersiveengineering:material:7> * 2, 1200, 300, [<ore:dustFlux>, <tfc:cobble/marble>]);


//Glass

  mods.immersiveengineering.ArcFurnace.addRecipe(<minecraft:glass> * 2, <ore:blockSand>, <immersiveengineering:material:7>, 1100, 100);


//=======================================================================================================================================================================
//Heat Registry
  mods.terrafirmacraft.ItemRegistry.registerItemHeat(<immersiveengineering:faraday_suit_head>, 0.35, 660, true);
  mods.terrafirmacraft.ItemRegistry.registerItemHeat(<immersiveengineering:faraday_suit_chest>, 0.35, 660, true);
  mods.terrafirmacraft.ItemRegistry.registerItemHeat(<immersiveengineering:faraday_suit_legs>, 0.35, 660, true);
  mods.terrafirmacraft.ItemRegistry.registerItemHeat(<immersiveengineering:faraday_suit_feet>, 0.35, 660, true);

//Metal Registry
  //mods.terrafirmacraft.ItemRegistry.registerItemMetal(<immersiveengineering:faraday_suit_head>, "ALUMINUM", 400, true);
  //mods.terrafirmacraft.ItemRegistry.registerItemMetal(<immersiveengineering:faraday_suit_chest>, "ALUMINUM", 400, true);
  //mods.terrafirmacraft.ItemRegistry.registerItemMetal(<immersiveengineering:faraday_suit_legs>, "ALUMINUM", 400, true);
  //mods.terrafirmacraft.ItemRegistry.registerItemMetal(<immersiveengineering:faraday_suit_feet>, "ALUMINUM", 400, true);

//Armor Registry

  //Faraday
  mods.terrafirmacraft.ItemRegistry.registerArmor(<immersiveengineering:faraday_suit_head>, 500, 330, 500);
  mods.terrafirmacraft.ItemRegistry.registerArmor(<immersiveengineering:faraday_suit_chest>, 500, 330, 500);
  mods.terrafirmacraft.ItemRegistry.registerArmor(<immersiveengineering:faraday_suit_legs>, 500, 330, 500);
  mods.terrafirmacraft.ItemRegistry.registerArmor(<immersiveengineering:faraday_suit_feet>, 500, 330, 500);

//Add Armor Forging

  //Faraday
  mods.terrafirmacraft.Anvil.addRecipe("tfcr:ie_faraday_helmet", <ore:sheetDoubleAluminium>, <immersiveengineering:faraday_suit_head>, 2, "armor", "HIT_LAST", "BEND_SECOND_LAST", "BEND_THIRD_LAST");
  mods.terrafirmacraft.Anvil.addRecipe("tfcr:ie_faraday_chestplate", <ore:sheetDoubleAluminium>, <immersiveengineering:faraday_suit_chest>, 2, "armor", "HIT_LAST", "HIT_SECOND_LAST", "UPSET_THIRD_LAST");
  mods.terrafirmacraft.Anvil.addRecipe("tfcr:ie_faraday_leggings", <ore:sheetDoubleAluminium>, <immersiveengineering:faraday_suit_legs>, 2, "armor", "BEND_ANY", "DRAW_ANY", "HIT_ANY");
  mods.terrafirmacraft.Anvil.addRecipe("tfcr:ie_faraday_boots", <ore:sheetDoubleAluminium>, <immersiveengineering:faraday_suit_feet>, 2, "armor", "BEND_LAST", "BEND_SECOND_LAST", "SHRINK_THIRD_LAST");



  mods.terrafirmacraft.Barrel.addRecipe("tfcr:treated_wood_planks", <ore:plankWood>, <liquid:creosote> * 125, <immersiveengineering:treated_wood>, null, 16);
  mods.terrafirmacraft.Barrel.addRecipe("tfcr:treated_wood_stick", <ore:stickWood>, <liquid:creosote> * 65, <immersiveengineering:material>, null, 16);






*/
