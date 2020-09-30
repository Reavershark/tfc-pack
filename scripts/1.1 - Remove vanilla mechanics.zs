import crafttweaker.item.IItemStack;
import mods.jei.JEI;

// Disable furnace
furnace.removeAll();

// Remove iron recipes
recipes.remove(<minecraft:iron_door>);

// Replace iron with wrought iron
recipes.replaceAllOccurences(<minecraft:iron_ingot>, <tfc:metal/ingot/wrought_iron>);
<ore:ingotIron>.remove(<minecraft:iron_ingot>);
<ore:ingotIron>.add(<tfc:metal/ingot/wrought_iron>);

// Hide anvil recipes
JEI.hideCategory("minecraft.anvil");

// Clean up JEI
val vanillaWhiteList = [
  <minecraft:bedrock>,
  <minecraft:glass>,
  <minecraft:lapis_block>,
  <minecraft:stone_slab:4>,
  <minecraft:brick_block>,
  <minecraft:obsidian>,
  <minecraft:diamond_block>,
  <minecraft:ice>,
  <minecraft:snow>,
  <minecraft:clay>,
  <minecraft:brick_stairs>,
  <minecraft:hay_block>,
  <minecraft:hardened_clay>,
  <minecraft:bone_block>,
  <minecraft:torch>,
  <minecraft:ladder>,
  <minecraft:snow_layer>,
  <minecraft:jukebox>,
  <minecraft:white_glazed_terracotta>,
  <minecraft:orange_glazed_terracotta>,
  <minecraft:magenta_glazed_terracotta>,
  <minecraft:light_blue_glazed_terracotta>,
  <minecraft:yellow_glazed_terracotta>,
  <minecraft:lime_glazed_terracotta>,
  <minecraft:pink_glazed_terracotta>,
  <minecraft:gray_glazed_terracotta>,
  <minecraft:silver_glazed_terracotta>,
  <minecraft:cyan_glazed_terracotta>,
  <minecraft:purple_glazed_terracotta>,
  <minecraft:blue_glazed_terracotta>,
  <minecraft:brown_glazed_terracotta>,
  <minecraft:green_glazed_terracotta>,
  <minecraft:red_glazed_terracotta>,
  <minecraft:black_glazed_terracotta>,
  <minecraft:painting>,
  <minecraft:sign>,
  <minecraft:item_frame>,
  <minecraft:flower_pot>,
  <minecraft:armor_stand>,
  <minecraft:dispenser>,
  <minecraft:noteblock>,
  <minecraft:sticky_piston>,
  <minecraft:piston>,
  <minecraft:tnt>,
  <minecraft:lever>,
  <minecraft:redstone_torch>,
  <minecraft:redstone_lamp>,
  <minecraft:light_weighted_pressure_plate>,
  <minecraft:heavy_weighted_pressure_plate>,
  <minecraft:daylight_detector>,
  <minecraft:redstone_block>,
  <minecraft:hopper>,
  <minecraft:dropper>,
  <minecraft:observer>,
  <minecraft:iron_door>,
  <minecraft:redstone>,
  <minecraft:repeater>,
  <minecraft:comparator>,
  <minecraft:golden_rail>,
  <minecraft:detector_rail>,
  <minecraft:rail>,
  <minecraft:activator_rail>,
  <minecraft:minecart>,
  <minecraft:saddle>,
  <minecraft:tnt_minecart>,
  <minecraft:hopper_minecart>,
  <minecraft:flint_and_steel>,
  <minecraft:bow>,
  <minecraft:arrow>,
  <minecraft:coal:1>,
  <minecraft:bowl>,
  <minecraft:feather>,
  <minecraft:gunpowder>,
  <minecraft:leather_helmet>,
  <minecraft:leather_chestplate>,
  <minecraft:leather_leggings>,
  <minecraft:leather_boots>,
  <minecraft:flint>,
  <minecraft:bucket>,
  <minecraft:water_bucket>,
  <minecraft:lava_bucket>,
  <minecraft:snowball>,
  <minecraft:leather>,
  <minecraft:milk_bucket>,
  <minecraft:brick>,
  <minecraft:clay_ball>,
  <minecraft:paper>,
  <minecraft:book>,
  <minecraft:compass>,
  <minecraft:clock>,
  <minecraft:bone>,
  <minecraft:sugar>,
  <minecraft:glass_bottle>,
  <minecraft:spider_eye>,
  <minecraft:cauldron>,
  <minecraft:fire_charge>,
  <minecraft:writable_book>,
  <minecraft:map>,
  <minecraft:lead>,
  <minecraft:name_tag>,
  <minecraft:filled_map>,
  <minecraft:written_book>,
  <minecraft:stick>,
  <minecraft:string>
] as IItemStack[];

val vanillaAnyMetaWhiteList = [
  <minecraft:wool>,
  <minecraft:stained_glass>,
  <minecraft:stained_hardened_clay>,
  <minecraft:concrete>,
  <minecraft:concrete_powder>,
  <minecraft:bed>,
  <minecraft:banner>,
  <minecraft:dye>,
] as IItemStack[];

for item in loadedMods["minecraft"].items {
  if (!(vanillaAnyMetaWhiteList has item.definition.makeStack() || vanillaWhiteList has item.definition.makeStack(item.metadata))) {
    JEI.removeAndHide(item);
  }
}
