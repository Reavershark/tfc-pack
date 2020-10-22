import mods.immersiveengineering.Fermenter;

// Remove vanilla items
Fermenter.removeByInput(<minecraft:reeds>);
Fermenter.removeByInput(<minecraft:melon>);
Fermenter.removeByInput(<minecraft:apple>);
Fermenter.removeByInput(<minecraft:potato>);

Fermenter.addRecipe(null, <liquid:ethanol> * 80, <ore:categoryVegetable>, 512);
Fermenter.addRecipe(null, <liquid:ethanol> * 80, <ore:categoryFruit>, 512);
Fermenter.addRecipe(null, <liquid:ethanol> * 80, <tfc:food/sugarcane>, 512);
Fermenter.addRecipe(null, <liquid:ethanol> * 80, <tfc:food/maize>, 512);
