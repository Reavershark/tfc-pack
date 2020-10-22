// Disable furnace
furnace.removeAll();

// Remove iron recipes
recipes.remove(<minecraft:iron_door>);

// Replace iron with wrought iron
recipes.replaceAllOccurences(<minecraft:iron_ingot>, <tfc:metal/ingot/wrought_iron>);
<ore:ingotIron>.remove(<minecraft:iron_ingot>);
<ore:ingotIron>.add(<tfc:metal/ingot/wrought_iron>);
