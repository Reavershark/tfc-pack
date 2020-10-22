import mods.immersiveengineering.AlloySmelter;

// Remove existing recipes
AlloySmelter.removeRecipe(<immersiveengineering:metal:6>);
AlloySmelter.removeRecipe(<immersiveengineering:metal:7>);
AlloySmelter.removeRecipe(<tfc:metal/ingot/invar>);
AlloySmelter.removeRecipe(<tfc:metal/ingot/bronze>);
AlloySmelter.removeRecipe(<tfc:metal/ingot/brass>);
AlloySmelter.removeRecipe(<tfc:metal/ingot/red_alloy>);

// Add constatan and electrum
AlloySmelter.addRecipe(<tfc:metal/ingot/constantan>*2, <ore:ingotCopper>*3, <ore:ingotNickel>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/constantan>*2, <ore:dustCopper>*3, <ore:dustNickel>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/constantan>*2, <ore:ingotCopper>*3, <ore:dustNickel>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/constantan>*2, <ore:dustCopper>*3, <ore:ingotNickel>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/electrum>*2, <ore:ingotGold>*3, <ore:ingotSilver>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/electrum>*2, <ore:dustGold>*3, <ore:dustSilver>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/electrum>*2, <ore:ingotGold>*3, <ore:dustSilver>, 1200);
AlloySmelter.addRecipe(<tfc:metal/ingot/electrum>*2, <ore:dustGold>*3, <ore:ingotSilver>, 1200);
