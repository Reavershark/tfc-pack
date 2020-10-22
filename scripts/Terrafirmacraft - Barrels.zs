import mods.terrafirmacraft.Barrel;

// A log gives 1 bucket of tannin instead of 10
Barrel.removeRecipe(null, <liquid:tannin>*10000);
Barrel.addRecipe("ct:barrel_tannin", <ore:logWoodTannin>, <liquid:fresh_water>*1000, null, <liquid:tannin>*1000, 8);


// Quilted wool
Barrel.addRecipe("ct:barrel_quilted_wool_lye", <quark:quilted_wool:*>, <liquid:lye>*125, <quark:quilted_wool:0>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_white", <quark:quilted_wool:0>, <liquid:white_dye>*125, <quark:quilted_wool:0>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_orange", <quark:quilted_wool:0>, <liquid:orange_dye>*125, <quark:quilted_wool:1>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_magenta", <quark:quilted_wool:0>, <liquid:magenta_dye>*125, <quark:quilted_wool:2>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_light_blue", <quark:quilted_wool:0>, <liquid:light_blue_dye>*125, <quark:quilted_wool:3>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_yellow", <quark:quilted_wool:0>, <liquid:yellow_dye>*125, <quark:quilted_wool:4>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_lime", <quark:quilted_wool:0>, <liquid:lime_dye>*125, <quark:quilted_wool:5>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_pink", <quark:quilted_wool:0>, <liquid:pink_dye>*125, <quark:quilted_wool:6>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_gray", <quark:quilted_wool:0>, <liquid:gray_dye>*125, <quark:quilted_wool:7>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_light_gray", <quark:quilted_wool:0>, <liquid:light_gray_dye>*125, <quark:quilted_wool:8>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_cyan", <quark:quilted_wool:0>, <liquid:cyan_dye>*125, <quark:quilted_wool:9>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_purple", <quark:quilted_wool:0>, <liquid:purple_dye>*125, <quark:quilted_wool:10>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_blue", <quark:quilted_wool:0>, <liquid:blue_dye>*125, <quark:quilted_wool:11>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_brown", <quark:quilted_wool:0>, <liquid:brown_dye>*125, <quark:quilted_wool:12>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_green", <quark:quilted_wool:0>, <liquid:green_dye>*125, <quark:quilted_wool:13>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_red", <quark:quilted_wool:0>, <liquid:red_dye>*125, <quark:quilted_wool:14>, null, 1);
Barrel.addRecipe("ct:barrel_quilted_wool_black", <quark:quilted_wool:0>, <liquid:black_dye>*125, <quark:quilted_wool:15>, null, 1);

// Item frames
Barrel.addRecipe("ct:barrel_item_frame_lye", <quark:colored_item_frame:*>, <liquid:lye>*125, <minecraft:item_frame>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_white", <minecraft:item_frame>, <liquid:white_dye>*125, <quark:colored_item_frame:0>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_orange", <minecraft:item_frame>, <liquid:orange_dye>*125, <quark:colored_item_frame:1>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_magenta", <minecraft:item_frame>, <liquid:magenta_dye>*125, <quark:colored_item_frame:2>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_light_blue", <minecraft:item_frame>, <liquid:light_blue_dye>*125, <quark:colored_item_frame:3>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_yellow", <minecraft:item_frame>, <liquid:yellow_dye>*125, <quark:colored_item_frame:4>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_lime", <minecraft:item_frame>, <liquid:lime_dye>*125, <quark:colored_item_frame:5>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_pink", <minecraft:item_frame>, <liquid:pink_dye>*125, <quark:colored_item_frame:6>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_gray", <minecraft:item_frame>, <liquid:gray_dye>*125, <quark:colored_item_frame:7>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_light_gray", <minecraft:item_frame>, <liquid:light_gray_dye>*125, <quark:colored_item_frame:8>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_cyan", <minecraft:item_frame>, <liquid:cyan_dye>*125, <quark:colored_item_frame:9>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_purple", <minecraft:item_frame>, <liquid:purple_dye>*125, <quark:colored_item_frame:10>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_blue", <minecraft:item_frame>, <liquid:blue_dye>*125, <quark:colored_item_frame:11>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_brown", <minecraft:item_frame>, <liquid:brown_dye>*125, <quark:colored_item_frame:12>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_green", <minecraft:item_frame>, <liquid:green_dye>*125, <quark:colored_item_frame:13>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_red", <minecraft:item_frame>, <liquid:red_dye>*125, <quark:colored_item_frame:14>, null, 1);
Barrel.addRecipe("ct:barrel_item_frame_black", <minecraft:item_frame>, <liquid:black_dye>*125, <quark:colored_item_frame:15>, null, 1);

// Flower pots
Barrel.addRecipe("ct:barrel_flower_pot_white", <minecraft:flower_pot>, <liquid:white_dye>*125, <quark:colored_flowerpot_white>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_orange", <minecraft:flower_pot>, <liquid:orange_dye>*125, <quark:colored_flowerpot_orange>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_magenta", <minecraft:flower_pot>, <liquid:magenta_dye>*125, <quark:colored_flowerpot_magenta>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_light_blue", <minecraft:flower_pot>, <liquid:light_blue_dye>*125, <quark:colored_flowerpot_light_blue>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_yellow", <minecraft:flower_pot>, <liquid:yellow_dye>*125, <quark:colored_flowerpot_yellow>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lime", <minecraft:flower_pot>, <liquid:lime_dye>*125, <quark:colored_flowerpot_lime>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_pink", <minecraft:flower_pot>, <liquid:pink_dye>*125, <quark:colored_flowerpot_pink>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_gray", <minecraft:flower_pot>, <liquid:gray_dye>*125, <quark:colored_flowerpot_gray>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_light_gray", <minecraft:flower_pot>, <liquid:light_gray_dye>*125, <quark:colored_flowerpot_silver>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_cyan", <minecraft:flower_pot>, <liquid:cyan_dye>*125, <quark:colored_flowerpot_cyan>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_purple", <minecraft:flower_pot>, <liquid:purple_dye>*125, <quark:colored_flowerpot_purple>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_blue", <minecraft:flower_pot>, <liquid:blue_dye>*125, <quark:colored_flowerpot_blue>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_brown", <minecraft:flower_pot>, <liquid:brown_dye>*125, <quark:colored_flowerpot_brown>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_green", <minecraft:flower_pot>, <liquid:green_dye>*125, <quark:colored_flowerpot_green>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_red", <minecraft:flower_pot>, <liquid:red_dye>*125, <quark:colored_flowerpot_red>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_black", <minecraft:flower_pot>, <liquid:red_dye>*125, <quark:colored_flowerpot_black>, null, 1);

Barrel.addRecipe("ct:barrel_flower_pot_lye_white", <quark:colored_flowerpot_white>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_orange", <quark:colored_flowerpot_orange>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_magenta", <quark:colored_flowerpot_magenta>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_light_blue", <quark:colored_flowerpot_light_blue>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_yellow", <quark:colored_flowerpot_yellow>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_lime", <quark:colored_flowerpot_lime>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_pink", <quark:colored_flowerpot_pink>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_gray", <quark:colored_flowerpot_gray>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_light_gray", <quark:colored_flowerpot_silver>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_cyan", <quark:colored_flowerpot_cyan>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_purple", <quark:colored_flowerpot_purple>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_blue", <quark:colored_flowerpot_blue>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_brown", <quark:colored_flowerpot_brown>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_green", <quark:colored_flowerpot_green>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_red", <quark:colored_flowerpot_red>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
Barrel.addRecipe("ct:barrel_flower_pot_lye_black", <quark:colored_flowerpot_black>, <liquid:lye>*125, <minecraft:flower_pot>, null, 1);
