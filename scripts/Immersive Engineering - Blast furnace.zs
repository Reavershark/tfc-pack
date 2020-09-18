import mods.immersiveengineering.BlastFurnace;

// Remove all recipes
BlastFurnace.removeRecipe(<immersiveengineering:storage:8>);
BlastFurnace.removeRecipe(<immersiveengineering:metal:8>);

// Pig iron from iron
BlastFurnace.addRecipe(<tfc:metal/ingot/pig_iron>, <ore:ingotIron>, 1200, <immersiveengineering:material:7>);

// Ceramic
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/ingot>, <tfc:ceramics/unfired/mold/ingot>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/pick_head>, <tfc:ceramics/unfired/mold/pick_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/shovel_head>, <tfc:ceramics/unfired/mold/shovel_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/axe_head>, <tfc:ceramics/unfired/mold/axe_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/hoe_head>, <tfc:ceramics/unfired/mold/hoe_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/chisel_head>, <tfc:ceramics/unfired/mold/chisel_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/sword_blade>, <tfc:ceramics/unfired/mold/sword_blade>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/mace_head>, <tfc:ceramics/unfired/mold/mace_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/saw_blade>, <tfc:ceramics/unfired/mold/saw_blade>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/javelin_head>, <tfc:ceramics/unfired/mold/javelin_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/hammer_head>, <tfc:ceramics/unfired/mold/hammer_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/propick_head>, <tfc:ceramics/unfired/mold/propick_head>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/knife_blade>, <tfc:ceramics/unfired/mold/knife_blade>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/mold/scythe_blade>, <tfc:ceramics/unfired/mold/scythe_blade>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel>, <tfc:ceramics/unfired/vessel>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:0>, <tfc:ceramics/unfired/vessel_glazed:0>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:1>, <tfc:ceramics/unfired/vessel_glazed:1>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:2>, <tfc:ceramics/unfired/vessel_glazed:2>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:3>, <tfc:ceramics/unfired/vessel_glazed:3>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:4>, <tfc:ceramics/unfired/vessel_glazed:4>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:5>, <tfc:ceramics/unfired/vessel_glazed:5>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:6>, <tfc:ceramics/unfired/vessel_glazed:6>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:7>, <tfc:ceramics/unfired/vessel_glazed:7>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:8>, <tfc:ceramics/unfired/vessel_glazed:8>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:9>, <tfc:ceramics/unfired/vessel_glazed:9>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:10>, <tfc:ceramics/unfired/vessel_glazed:10>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:11>, <tfc:ceramics/unfired/vessel_glazed:11>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:12>, <tfc:ceramics/unfired/vessel_glazed:12>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:13>, <tfc:ceramics/unfired/vessel_glazed:13>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:14>, <tfc:ceramics/unfired/vessel_glazed:14>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/vessel_glazed:15>, <tfc:ceramics/unfired/vessel_glazed:15>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/pot>, <tfc:ceramics/unfired/pot>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/jug>, <tfc:ceramics/unfired/jug>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/bowl>, <tfc:ceramics/unfired/bowl>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/spindle>, <tfc:ceramics/unfired/spindle>, 600, null);
BlastFurnace.addRecipe(<tfc:ceramics/fired/fire_brick>, <tfc:ceramics/unfired/fire_brick>, 600, null);
BlastFurnace.addRecipe(<minecraft:brick>, <tfc:ceramics/unfired/clay_brick>, 600, null);
BlastFurnace.addRecipe(<minecraft:hardened_clay>, <minecraft:clay>, 600, null);

// Remove coke block as fuel
BlastFurnace.removeFuel(<immersiveengineering:stone_decoration:3>);