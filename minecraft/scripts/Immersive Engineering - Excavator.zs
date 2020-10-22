import mods.immersiveengineering.Excavator;

// Remove Vanilla / IE ores
Excavator.removeMineral("Galena");
Excavator.removeMineral("Lapis");
Excavator.removeMineral("Gold");
Excavator.removeMineral("Bauxite");
Excavator.removeMineral("Pyrite");
Excavator.removeMineral("Silt");
Excavator.removeMineral("Nickel");
Excavator.removeMineral("Lead");
Excavator.removeMineral("Cinnabar");
Excavator.removeMineral("Uranium");
Excavator.removeMineral("Copper");
Excavator.removeMineral("Magnetite");
Excavator.removeMineral("Iron");
Excavator.removeMineral("Quartzite");
Excavator.removeMineral("Coal");
Excavator.removeMineral("Silver");

// Add some ore dict entries
<ore:oreLimoniteSmall>.add(<tfc:ore/small/limonite>);
<ore:oreLimoniteNormal>.add(<tfc:ore/limonite:0>);
<ore:oreLimonitePoor>.add(<tfc:ore/limonite:1>);
<ore:oreLimoniteRich>.add(<tfc:ore/limonite:2>);

<ore:oreHematiteSmall>.add(<tfc:ore/small/hematite>);
<ore:oreHematiteNormal>.add(<tfc:ore/hematite:0>);
<ore:oreHematitePoor>.add(<tfc:ore/hematite:1>);
<ore:oreHematiteRich>.add(<tfc:ore/hematite:2>);

<ore:oreMagnetiteSmall>.add(<tfc:ore/small/magnetite>);
<ore:oreMagnetiteNormal>.add(<tfc:ore/magnetite:0>);
<ore:oreMagnetitePoor>.add(<tfc:ore/magnetite:1>);
<ore:oreMagnetiteRich>.add(<tfc:ore/magnetite:2>);

<ore:oreNativeCopperSmall>.add([<tfc:ore/small/native_copper>]);
<ore:oreNativeCopperNormal>.add([<tfc:ore/native_copper:0>]);
<ore:oreNativeCopperPoor>.add([<tfc:ore/native_copper:1>]);
<ore:oreNativeCopperRich>.add([<tfc:ore/native_copper:2>]);

<ore:oreTetrahedriteSmall>.add([<tfc:ore/small/tetrahedrite>]);
<ore:oreTetrahedriteNormal>.add([<tfc:ore/tetrahedrite:0>]);
<ore:oreTetrahedritePoor>.add([<tfc:ore/tetrahedrite:1>]);
<ore:oreTetrahedriteRich>.add([<tfc:ore/tetrahedrite:2>]);

<ore:oreMalachiteSmall>.add([<tfc:ore/small/malachite>]);
<ore:oreMalachiteNormal>.add([<tfc:ore/malachite:0>]);
<ore:oreMalachitePoor>.add([<tfc:ore/malachite:1>]);
<ore:oreMalachiteRich>.add([<tfc:ore/malachite:2>]);


// TFC Ores

// Copper
Excavator.addMineral("Native Copper", 10, 0.005, ["oreNativeCopperPoor", "oreNativeCopperNormal", "oreNativeCopperRich"], [0.6, 0.3, 0.1]);
Excavator.addMineral("Tetrahedrite", 10, 0.005, ["oreTetrahedritePoor", "oreTetrahedriteNormal", "oreTetrahedriteRich"], [0.6, 0.3, 0.1]);
Excavator.addMineral("Malachite", 10, 0.005, ["oreMalachitePoor", "oreMalachiteNormal", "oreMalachiteRich"], [0.6, 0.3, 0.1]);

// Gold
Excavator.addMineral("Native Gold", 10, 0.005, ["oreGoldPoor", "oreGoldNormal", "oreGoldRich", "oreTetrahedritePoor", "oreTetrahedriteNormal", "oreTetrahedriteRich", "oreLeadPoor", "oreLeadNormal", "oreLeadRich"], [0.45, 0.15, 0.05, 0.175, 0.075, 0.015, 0.06, 0.0175, 0.0075]);

// Platinum
Excavator.addMineral("Platinum", 7, 0.005, ["orePlatinumPoor", "orePlatinumNormal", "orePlatinumRich", "oreTetrahedritePoor", "oreNickelPoor"], [0.35, 0.175, 0.075, 0.20, 0.20]);

// Iron
Excavator.addMineral("Hematite", 10, 0.005, ["oreHematitePoor", "oreHematiteNormal", "oreHematiteRich"], [0.6, 0.3, 0.1]);
Excavator.addMineral("Magnetite", 10, 0.005, ["oreMagnetitePoor", "oreMagnetiteNormal", "oreMagnetiteRich"], [0.6, 0.3, 0.1]);
Excavator.addMineral("Limonite", 10, 0.005, ["oreLimonitePoor", "oreLimoniteNormal", "oreLimoniteRich"], [0.6, 0.3, 0.1]);

// Silver
Excavator.addMineral("Silver", 20, 0.005, ["oreSilverPoor", "oreSilverNormal", "oreSilverRich", "oreLeadPoor", "oreLeadNormal", "oreLeadRich"], [0.30, 0.15, 0.05, 0.30, 0.15, 0.05]);

// Tin
Excavator.addMineral("Cassiterite", 20, 0.005, ["oreTinPoor", "oreTinNormal", "oreTinRich"], [0.6, 0.3, 0.1]);

// Lead
Excavator.addMineral("Galena", 25, 0.005, ["oreLeadPoor", "oreLeadNormal", "oreLeadRich", "oreSilverSmall", "oreSilverPoor"], [0.70, 0.125, 0.0539, 0.35, 0.0711]);

// Bismuth
Excavator.addMineral("Bismuthinite", 20, 0.005, ["oreBismuthPoor", "oreBismuthNormal", "oreBismuthRich"], [0.6, 0.3, 0.1]);

// Nickel
Excavator.addMineral("Garnierite", 20, 0.005, ["oreNickelPoor", "oreNickelNormal", "oreNickelRich", "oreHematiteSmall", "oreHematitePoor"], [0.70, 0.175, 0.0694, 0.045, 0.0106]);

// Zinc
Excavator.addMineral("Sphalerite", 20, 0.005, ["oreZincPoor", "oreZincNormal", "oreZincRich", "oreSilverSmall", "tfc:ore/small/tetrahedrite"], [0.70, 0.15, 0.05, 0.055, 0.045]);

// Antimony
Excavator.addMineral("Stibnite", 5, 0.005, ["oreAntimonyPoor", "oreAntimonyNormal", "oreAntimonyRich"], [0.6, 0.3, 0.1]);

// Lithium
Excavator.addMineral("Spodumene", 10, 0.005, ["oreLithiumPoor", "oreLithiumNormal", "oreLithiumRich"], [0.6, 0.3, 0.1]);

// Ardite
Excavator.addMineral("Native Ardite", 2, 0.005, ["oreArditeNormal", "oreBismuthPoor", "oreLeadPoor", "oreArditeRich"], [0.5, 0.30, 0.20, 0.1]);

// Osmium
Excavator.addMineral("Native Osmium", 1, 0.005, ["oreOsmiumPoor", "oreOsmiumNormal", "oreOsmiumRich"], [0.6, 0.3, 0.1]);

// Aluminium
Excavator.addMineral("Bauxite", 20, 0.005, ["oreAluminiumPoor", "oreAluminiumNormal", "oreAluminiumRich"], [0.6, 0.3, 0.1]);

// Tungsten
Excavator.addMineral("Wolframite", 1, 0.005, ["oreTungstenNormal", "oreHematitePoor", ], [0.75, 0.25]);

// Cobaltite
Excavator.addMineral("Cobaltite", 2, 0.005, ["oreCobaltPoor", "oreCobaltNormal", "oreCobaltRich"], [0.6, 0.3, 0.1]);

// Titanium
Excavator.addMineral("Rutile", 5, 0.005, ["oreTitaniumPoor", "oreTitaniumNormal", "oreTitaniumRich"], [0.6, 0.3, 0.1]);

// Thorium
Excavator.addMineral("Thorianite", 5, 0.005, ["oreThoriumPoor", "oreThoriumNormal", "oreThoriumRich"], [0.6, 0.3, 0.1]);

// Manganese
Excavator.addMineral("Pyrolusite", 5, 0.005, ["oreManganesePoor", "oreManganeseNormal", "oreManganeseRich"], [0.6, 0.3, 0.1]);

// Magnesium
Excavator.addMineral("Magnesite", 5, 0.005, ["oreMagnesiumPoor", "oreMagnesiumNormal", "oreMagnesiumRich"], [0.6, 0.3, 0.1]);

// Zirconium
Excavator.addMineral("Zircon", 5, 0.005, ["oreZirconiumPoor", "oreZirconiumNormal", "oreZirconiumRich"], [0.6, 0.3, 0.1]);


// TFC Minerals

// Uranium
Excavator.addMineral("Pitchblende", 5, 0.005, ["gemPitchblende", "oreLeadPoor", "oreLeadNormal", "oreLeadRich"], [0.6471, 0.25, 0.075, 0.0279]);

// Borax
Excavator.addMineral("Borax", 5, 0.005, ["gemBorax"], [1]);

// Cinnabar
Excavator.addMineral("Cinnabar", 10, 0.005, ["gemCinnabar", "gemSulfur"], [0.9444, 0.0556]);

// Cryolite
Excavator.addMineral("Cryolite", 10, 0.005, ["gemCryolite", "gemSelenite"], [0.8444, 0.1556]);

// Kaolinite
Excavator.addMineral("Kaolinite", 15, 0.005, ["gemKaolinite"], [1]);

// Gypsum
Excavator.addMineral("Gypsum", 10, 0.005, ["gemGypsum"], [1]);

// Graphite
Excavator.addMineral("Graphite", 10, 0.005, ["gemGraphite"], [1]);

// Kimberlite
Excavator.addMineral("Kimberlite", 2, 0.005, ["gemKimberlite", "gemChippedDiamond", "gemFlawedDiamond", "gemDiamond", "gemFlawlessDiamond", "gemExquisiteDiamond"], [0.80, 0.10, 0.05, 0.03, 0.015, 0.005]);

// Saltpeter
Excavator.addMineral("Saltpeter", 10, 0.005, ["gemSaltpeter"], [1]);

// Sylvite
Excavator.addMineral("Sylvite", 10, 0.005, ["gemSylvite"], [1]);

// Petrified Wood
Excavator.addMineral("Petrified Wood", 20, 0.005, ["gemPetrifiedWood"], [1]);

// Microcline
Excavator.addMineral("Microcline", 5, 0.005, ["gemMicrocline"], [1]);

// Serpentine
Excavator.addMineral("Serpentine", 5, 0.005, ["gemSerpentine", "oreBismuthPoor", "oreLeadPoor"], [0.5, 0.30, 0.20]);

// Chromite
Excavator.addMineral("Chromite", 5, 0.005, ["gemChromite"], [0.1]);

// Coal
Excavator.addMineral("Bituminous Coal", 20, 0.005, ["gemCoal"], [1]);
Excavator.addMineral("Lignite", 20, 0.005, ["gemLignite"], [1]);

// Lapis
Excavator.addMineral("Lapis Lazuli", 10, 0.005, ["gemLapis", "oreHematitePoor", "gemSulfur"], [0.6842, 0.2895, 0.0263]);

// Silt
Excavator.addMineral("Silt", 20, 0.005, ["clay"], [1]);