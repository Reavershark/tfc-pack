import mods.jei.JEI;

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

// Radiator
recipes.remove(<immersiveengineering:metal_decoration0:7>);
recipes.addShaped("ct_radiator_vanilla_bucket_", <immersiveengineering:metal_decoration0:7>*2, [
  [<ore:ingotSteel>, <ore:ingotCopper>, <ore:ingotSteel>],
  [<ore:ingotCopper>, <forge:bucketfilled>.withTag({FluidName: "fresh_water", Amount: 1000}).transformReplace(<minecraft:bucket>), <ore:ingotCopper>],
  [<ore:ingotSteel>, <ore:ingotCopper>, <ore:ingotSteel>]
]);
recipes.addShaped("ct_radiator_red_steel_bucket", <immersiveengineering:metal_decoration0:7>*2, [
  [<ore:ingotSteel>, <ore:ingotCopper>, <ore:ingotSteel>],
  [<ore:ingotCopper>, <tfc:metal/bucket/red_steel>.withTag({Fluid: {FluidName: "fresh_water", Amount: 1000}}).transformReplace(<tfc:metal/bucket/red_steel>), <ore:ingotCopper>],
  [<ore:ingotSteel>, <ore:ingotCopper>, <ore:ingotSteel>]
]);

// Remove lantern
JEI.removeAndHide(<immersiveengineering:metal_decoration2:4>);

// Dropping conveyor any trapdoor instead of vanilla iron
recipes.replaceAllOccurences(<minecraft:iron_trapdoor>, <ore:trapdoormetal>, <immersiveengineering:conveyor>.withTag({conveyorType: "immersiveengineering:dropper"}));

// Remove coal coke block to coke item recipe
recipes.remove(<immersiveengineering:material:6>);
