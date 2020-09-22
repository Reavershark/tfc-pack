import mods.immersiveengineering.Mixer;

// Remove potions
val potions = [
  "minecraft:mundane",
  "minecraft:thick",
  "minecraft:awkward",
  "minecraft:night_vision",
  "minecraft:long_night_vision",
  "minecraft:invisibility",
  "minecraft:long_invisibility",
  "minecraft:leaping",
  "minecraft:long_leaping",
  "minecraft:strong_leaping",
  "minecraft:fire_resistance",
  "minecraft:long_fire_resistance",
  "minecraft:swiftness",
  "minecraft:long_swiftness",
  "minecraft:strong_swiftness",
  "minecraft:slowness",
  "minecraft:long_slowness",
  "minecraft:water_breathing",
  "minecraft:long_water_breathing",
  "minecraft:healing",
  "minecraft:strong_healing",
  "minecraft:harming",
  "minecraft:strong_harming",
  "minecraft:poison",
  "minecraft:long_poison",
  "minecraft:strong_poison",
  "minecraft:regeneration",
  "minecraft:long_regeneration",
  "minecraft:strong_regeneration",
  "minecraft:strength",
  "minecraft:long_strength",
  "minecraft:strong_strength",
  "minecraft:weakness",
  "minecraft:long_weakness"
] as string[];

for potion in potions {
  Mixer.removeRecipe(<liquid:potion>.withTag({Potion: potion}));
}

// Liquid concrete
Mixer.removeRecipe(<liquid:concrete>);
Mixer.addRecipe(<liquid:concrete>*500, <liquid:fresh_water>*500, [<ore:sand>, <ore:sand>, <minecraft:clay_ball>, <ore:gravel>], 4096);

// Barrel recipes
Mixer.addRecipe(<liquid:limewater>*500, <liquid:fresh_water> * 500, [<ore:dustFlux>], 256);
Mixer.addRecipe(<liquid:tannin>*250, <liquid:fresh_water> * 1000, [<ore:logWoodTannin>], 4096);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:beer>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:cider>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:rum>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:sake>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:vodka>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:whiskey>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:corn_whiskey>*250, [<ore:categoryFruit>], 1024);
Mixer.addRecipe(<liquid:vinegar>*250, <liquid:rye_whiskey>*250, [<ore:categoryFruit>], 1024);
