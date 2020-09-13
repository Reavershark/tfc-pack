import crafttweaker.item.IItemStack;
import mods.jei.JEI;

/*       */
/* Items */
/*       */

// Dirt bucket
JEI.removeAndHide(<dynamictrees:dirtbucket>);

// Creative staff
JEI.hide(<dynamictrees:staff>);


/*               */
/* Vanilla trees */
/*               */

// Seeds
val vanillaSeeds = [
    <dynamictrees:appleseed>,
    <dynamictrees:oakseed>,
    <dynamictrees:spruceseed>,
    <dynamictrees:birchseed>,
    <dynamictrees:jungleseed>,
    <dynamictrees:acaciaseed>,
    <dynamictrees:darkoakseed>,
    <dynamictrees:cactusseed>
] as IItemStack[];
for item in vanillaSeeds {JEI.removeAndHide(item);}

// Branches
val vanillaBranches = [
    <dynamictrees:oakbranch>,
    <dynamictrees:oakbranchx>,
    <dynamictrees:sprucebranch>,
    <dynamictrees:sprucebranchx>,
    <dynamictrees:birchbranch>,
    <dynamictrees:junglebranch>,
    <dynamictrees:junglebranchx>,
    <dynamictrees:acaciabranch>,
    <dynamictrees:darkoakbranch>,
    <dynamictrees:darkoakbranchx>,
    <dynamictrees:cactusbranch>
] as IItemStack[];
for item in vanillaBranches {JEI.hide(item);}


/*         */
/* Potions */
/*         */

JEI.hide(<dynamictrees:dendropotion:*>);

// Removing dynamic trees pots brewing doensn't work
/*
    // Awkward -> Base potion
    brewing.removeRecipe(<minecraft:potion>.withTag({Potion: "minecraft:awkward"}), <minecraft:coal:2>);
    
    // Base -> Potion effects
    val ingredients = [
        <minecraft:slime_ball>,
        <minecraft:ghast_tear>,
        <minecraft:fish>,
        <minecraft:red_flower:1>,
        <minecraft:prismarine_crystals>
    ] as IItemStack[];
    for item in ingredients {brewing.removeRecipe(<dynamictrees:dendropotion:0>, item);}
    
    // Add seed to transformation effect
    val seeds = [
        <dynamictrees:acaciaseed>,
        <dynamictrees:spruceseed>,
        <dynamictrees:birchseed>,
        <dynamictrees:oakseed>,
        <dynamictrees:jungleseed>,
        <dynamictrees:darkoakseed>
    ] as IItemStack[];
    for item in ingredients {brewing.removeRecipe(<dynamictrees:dendropotion:0>, item);}
*/
