import mods.terrafirmacraft.Barrel;

// A log gives 1 bucket of tannin instead of 10
Barrel.removeRecipe(null, <liquid:tannin>*10000);
Barrel.addRecipe("ct:barrel_tannin", <ore:logWoodTannin>, <liquid:fresh_water>*1000, null, <liquid:tannin>*1000, 8);
