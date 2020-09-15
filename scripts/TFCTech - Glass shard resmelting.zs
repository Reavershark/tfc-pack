import mods.terrafirmacraft.Heating;
import mods.tfctech.Smeltery;

// Glass now drops glass shards, but still uses the TFC way of heating into glass
// This removes the TFC heating recipe and adds resmelting to molten glass in the TFCTech smeltery
Heating.removeRecipe(<minecraft:glass>);
val builder = Smeltery.addRecipe("ct:glass_shard", <liquid:glass>*1000, 800); // recipe name, millibuckets, melting temperature
builder.addInput(<tfc:glass_shard>);
builder.build();