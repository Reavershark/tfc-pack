import crafttweaker.item.IItemStack;
import mods.immersiveengineering.Squeezer;

// Remove existing recipes
Squeezer.removeFluidRecipe(<liquid:plantoil>);

// Seeds
val seeds = [
  <tfc:crop/seeds/barley>,
  <tfc:crop/seeds/maize>,
  <tfc:crop/seeds/oat>,
  <tfc:crop/seeds/rice>,
  <tfc:crop/seeds/rye>,
  <tfc:crop/seeds/wheat>,
  <tfc:crop/seeds/beet>,
  <tfc:crop/seeds/cabbage>,
  <tfc:crop/seeds/carrot>,
  <tfc:crop/seeds/garlic>,
  <tfc:crop/seeds/green_bean>,
  <tfc:crop/seeds/onion>,
  <tfc:crop/seeds/potato>,
  <tfc:crop/seeds/soybean>,
  <tfc:crop/seeds/squash>,
  <tfc:crop/seeds/sugarcane>,
  <tfc:crop/seeds/red_bell_pepper>,
  <tfc:crop/seeds/tomato>,
  <tfc:crop/seeds/yellow_bell_pepper>,
  <tfc:crop/seeds/jute>
] as IItemStack[];

for seed in seeds {
  Squeezer.addRecipe(null, <liquid:plantoil>*80, seed, 6400);
}

// Olives
Squeezer.addRecipe(<tfc:food/olive_paste>, <liquid:olive_oil>*15, <tfc:food/olive>, 3200);
