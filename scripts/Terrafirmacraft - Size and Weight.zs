import mods.terrafirmacraft.ItemRegistry;

// 1 Huge + Very heavy item increases food/water consumption
// Multiple makes you/horses overburdened

// Wearable backpack (can store up to normal size items)
ItemRegistry.registerItemSize(<wearablebackpacks:backpack>, "HUGE", "LIGHT");

// Immersive engineering barrels
ItemRegistry.registerItemSize(<immersiveengineering:wooden_device0:1>, "HUGE", "VERY_HEAVY");
ItemRegistry.registerItemSize(<immersiveengineering:metal_device0:4>, "HUGE", "VERY_HEAVY");
ItemRegistry.registerItemSize(<immersivetech:metal_barrel:1>, "HUGE", "VERY_HEAVY");
ItemRegistry.registerItemSize(<immersivetech:metal_barrel:2>, "HUGE", "VERY_HEAVY");
