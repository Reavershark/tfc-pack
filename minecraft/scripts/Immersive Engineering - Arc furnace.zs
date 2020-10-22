import mods.immersiveengineering.ArcFurnace;

// Remove recipes
ArcFurnace.removeRecipe(<minecraft:iron_ingot>);
ArcFurnace.removeRecipe(<minecraft:gold_ingot>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:0>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:1>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:2>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:3>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:4>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:5>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:6>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:7>);
ArcFurnace.removeRecipe(<immersiveengineering:metal:8>);
ArcFurnace.removeRecipe(<tfc:metal/ingot/invar>*3);
ArcFurnace.removeRecipe(<tfc:metal/ingot/bronze>*4);
ArcFurnace.removeRecipe(<tfc:metal/ingot/brass>*4);
ArcFurnace.removeRecipe(<tfc:metal/ingot/uranium>*2);

// Glass
ArcFurnace.addRecipe(<minecraft:glass>, <ore:sand>, null, 1100, 100, [<tfctech:powder/lime>]);

// Insulating glass
mods.immersiveengineering.ArcFurnace.addRecipe(<immersiveengineering:stone_decoration:8>*2, <minecraft:glass>*2, null, 100, 512, [<tfc:metal/dust/wrought_iron>]);

// Cobblestone to Raw Rock
ArcFurnace.addRecipe(<tfc:raw/granite>, <tfc:cobble/granite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/diorite>, <tfc:cobble/diorite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/gabbro>, <tfc:cobble/gabbro>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/shale>, <tfc:cobble/shale>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/claystone>, <tfc:cobble/claystone>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/rocksalt>, <tfc:cobble/rocksalt>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/limestone>, <tfc:cobble/limestone>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/conglomerate>, <tfc:cobble/conglomerate>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/dolomite>, <tfc:cobble/dolomite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/chert>, <tfc:cobble/chert>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/chalk>, <tfc:cobble/chalk>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/rhyolite>, <tfc:cobble/rhyolite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/basalt>, <tfc:cobble/basalt>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/andesite>, <tfc:cobble/andesite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/dacite>, <tfc:cobble/dacite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/quartzite>, <tfc:cobble/quartzite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/slate>, <tfc:cobble/slate>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/phyllite>, <tfc:cobble/phyllite>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/schist>, <tfc:cobble/schist>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/gneiss>, <tfc:cobble/gneiss>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);
ArcFurnace.addRecipe(<tfc:raw/marble>, <tfc:cobble/marble>*2, <immersiveengineering:material:7>, 1200, 300, [<ore:dustFlux>]);