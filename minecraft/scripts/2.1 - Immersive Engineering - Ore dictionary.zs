import mods.jei.JEI;

// Replace hemp with jute
JEI.removeAndHide(<immersiveengineering:material:4>);
<ore:fiberHemp>.remove(<immersiveengineering:material:4>);
<ore:fiberHemp>.add(<tfc:crop/product/jute_fiber>);

// Remove ie nitrate
JEI.removeAndHide(<immersiveengineering:material:24>);
<ore:dustSaltpeter>.remove(<immersiveengineering:material:24>);

// Remove ie sulfur
JEI.removeAndHide(<immersiveengineering:material:25>);
<ore:dustSulfur>.remove(<immersiveengineering:material:25>);

// Replace ie ingots with tfc ingots
// This removes block / nugget to ingot recipes
JEI.removeAndHide(<immersiveengineering:metal:0>);
JEI.removeAndHide(<immersiveengineering:metal:1>);
JEI.removeAndHide(<immersiveengineering:metal:2>);
JEI.removeAndHide(<immersiveengineering:metal:3>);
JEI.removeAndHide(<immersiveengineering:metal:4>);
JEI.removeAndHide(<immersiveengineering:metal:5>);
JEI.removeAndHide(<immersiveengineering:metal:6>);
JEI.removeAndHide(<immersiveengineering:metal:7>);
JEI.removeAndHide(<immersiveengineering:metal:8>);
<ore:ingotCopper>.remove(<immersiveengineering:metal:0>);
<ore:ingotAluminum>.remove(<immersiveengineering:metal:1>);
<ore:ingotLead>.remove(<immersiveengineering:metal:2>);
<ore:ingotSilver>.remove(<immersiveengineering:metal:3>);
<ore:ingotNickel>.remove(<immersiveengineering:metal:4>);
<ore:ingotUranium>.remove(<immersiveengineering:metal:5>);
<ore:ingotConstantan>.remove(<immersiveengineering:metal:6>);
<ore:ingotElectrum>.remove(<immersiveengineering:metal:7>);
<ore:ingotSteel>.remove(<immersiveengineering:metal:8>);

// Replace ie rods with tfc rods
JEI.removeAndHide(<immersiveengineering:material:1>);
JEI.removeAndHide(<immersiveengineering:material:2>);
JEI.removeAndHide(<immersiveengineering:material:3>);
JEI.removeAndHide(<immersiveposts:metal_rods:*>);
<ore:stickIron>.remove(<immersiveengineering:material:1>);
<ore:stickSteel>.remove(<immersiveengineering:material:2>);
<ore:stickAluminum>.remove(<immersiveengineering:material:2>);
<ore:stickGold>.remove(<immersiveposts:metal_rods:0>);
<ore:stickCopper>.remove(<immersiveposts:metal_rods:1>);
<ore:stickLead>.remove(<immersiveposts:metal_rods:2>);
<ore:stickSilver>.remove(<immersiveposts:metal_rods:3>);
<ore:stickNickel>.remove(<immersiveposts:metal_rods:4>);
<ore:stickConstantan>.remove(<immersiveposts:metal_rods:5>);
<ore:stickElectrum>.remove(<immersiveposts:metal_rods:6>);
<ore:stickUranium>.remove(<immersiveposts:metal_rods:7>);
// Special cases, wrought iron / alumini(u)m spelling
<ore:stickIron>.add(<tfctech:metal/wrought_iron_rod>);
<ore:stickAluminum>.add(<tfctech:metal/aluminium_rod>);

// Replace ie wires with tfc wires
JEI.removeAndHide(<immersiveengineering:material:20>);
JEI.removeAndHide(<immersiveengineering:material:21>);
JEI.removeAndHide(<immersiveengineering:material:22>);
JEI.removeAndHide(<immersiveengineering:material:23>);
<ore:wireCopper>.remove(<immersiveengineering:material:20>);
<ore:wireElectrum>.remove(<immersiveengineering:material:21>);
<ore:wireAluminum>.remove(<immersiveengineering:material:22>);
<ore:wireSteel>.remove(<immersiveengineering:material:23>);
// Special case, alumini(u)m spelling
<ore:wireAluminum>.add(<tfctech:metal/aluminium_wire>);

// Remove ie grits
JEI.removeAndHide(<immersiveengineering:metal:9>);
JEI.removeAndHide(<immersiveengineering:metal:10>);
JEI.removeAndHide(<immersiveengineering:metal:11>);
JEI.removeAndHide(<immersiveengineering:metal:12>);
JEI.removeAndHide(<immersiveengineering:metal:13>);
JEI.removeAndHide(<immersiveengineering:metal:14>);
JEI.removeAndHide(<immersiveengineering:metal:15>);
JEI.removeAndHide(<immersiveengineering:metal:16>);
JEI.removeAndHide(<immersiveengineering:metal:17>);
JEI.removeAndHide(<immersiveengineering:metal:18>);
JEI.removeAndHide(<immersiveengineering:metal:19>);
<ore:dustCopper>.remove(<immersiveengineering:metal:9>);
<ore:dustAluminum>.remove(<immersiveengineering:metal:10>);
<ore:dustLead>.remove(<immersiveengineering:metal:11>);
<ore:dustSilver>.remove(<immersiveengineering:metal:12>);
<ore:dustNickel>.remove(<immersiveengineering:metal:13>);
<ore:dustUranium>.remove(<immersiveengineering:metal:14>);
<ore:dustConstantan>.remove(<immersiveengineering:metal:15>);
<ore:dustElectrum>.remove(<immersiveengineering:metal:16>);
<ore:dustSteel>.remove(<immersiveengineering:metal:17>);
<ore:dustIron>.remove(<immersiveengineering:metal:18>);
<ore:dustGold>.remove(<immersiveengineering:metal:19>);
// Special case, wrought iron
<ore:dustIron>.add(<tfc:metal/dust/wrought_iron>);

// Replace ie plates with tfc sheets
JEI.removeAndHide(<immersiveengineering:metal:30>);
JEI.removeAndHide(<immersiveengineering:metal:31>);
JEI.removeAndHide(<immersiveengineering:metal:32>);
JEI.removeAndHide(<immersiveengineering:metal:33>);
JEI.removeAndHide(<immersiveengineering:metal:34>);
JEI.removeAndHide(<immersiveengineering:metal:35>);
JEI.removeAndHide(<immersiveengineering:metal:36>);
JEI.removeAndHide(<immersiveengineering:metal:37>);
JEI.removeAndHide(<immersiveengineering:metal:38>);
JEI.removeAndHide(<immersiveengineering:metal:39>);
JEI.removeAndHide(<immersiveengineering:metal:40>);
<ore:plateCopper>.remove(<immersiveengineering:metal:30>);
<ore:plateAluminum>.remove(<immersiveengineering:metal:31>);
<ore:plateLead>.remove(<immersiveengineering:metal:32>);
<ore:plateSilver>.remove(<immersiveengineering:metal:33>);
<ore:plateNickel>.remove(<immersiveengineering:metal:34>);
<ore:plateUranium>.remove(<immersiveengineering:metal:35>);
<ore:plateConstantan>.remove(<immersiveengineering:metal:36>);
<ore:plateElectrum>.remove(<immersiveengineering:metal:37>);
<ore:plateSteel>.remove(<immersiveengineering:metal:38>);
<ore:plateIron>.remove(<immersiveengineering:metal:39>);
<ore:plateGold>.remove(<immersiveengineering:metal:40>);
<ore:plateCopper>.add(<tfc:metal/sheet/copper>);
<ore:plateAluminum>.add(<tfc:metal/sheet/aluminium>);
<ore:plateLead>.add(<tfc:metal/sheet/lead>);
<ore:plateSilver>.add(<tfc:metal/sheet/silver>);
<ore:plateNickel>.add(<tfc:metal/sheet/nickel>);
<ore:plateUranium>.add(<tfc:metal/sheet/uranium>);
<ore:plateConstantan>.add(<tfc:metal/sheet/constantan>);
<ore:plateElectrum>.add(<tfc:metal/sheet/electrum>);
<ore:plateSteel>.add(<tfc:metal/sheet/steel>);
<ore:plateIron>.add(<tfc:metal/sheet/wrought_iron>);
<ore:plateGold>.add(<tfc:metal/sheet/gold>);

// Remove ie nuggets
JEI.removeAndHide(<immersiveengineering:metal:20>);
JEI.removeAndHide(<immersiveengineering:metal:21>);
JEI.removeAndHide(<immersiveengineering:metal:22>);
JEI.removeAndHide(<immersiveengineering:metal:23>);
JEI.removeAndHide(<immersiveengineering:metal:24>);
JEI.removeAndHide(<immersiveengineering:metal:25>);
JEI.removeAndHide(<immersiveengineering:metal:26>);
JEI.removeAndHide(<immersiveengineering:metal:27>);
JEI.removeAndHide(<immersiveengineering:metal:28>);
JEI.removeAndHide(<immersiveengineering:metal:29>);
<ore:nuggetCopper>.remove(<immersiveengineering:metal:20>);
<ore:nuggetAluminum>.remove(<immersiveengineering:metal:21>);
<ore:nuggetLead>.remove(<immersiveengineering:metal:22>);
<ore:nuggetSilver>.remove(<immersiveengineering:metal:23>);
<ore:nuggetNickel>.remove(<immersiveengineering:metal:24>);
<ore:nuggetUranium>.remove(<immersiveengineering:metal:25>);
<ore:nuggetConstantan>.remove(<immersiveengineering:metal:26>);
<ore:nuggetElectrum>.remove(<immersiveengineering:metal:27>);
<ore:nuggetSteel>.remove(<immersiveengineering:metal:28>);
<ore:nuggetIron>.remove(<immersiveengineering:metal:29>);
// Special case, wrought iron
<ore:nuggetIron>.add(<tfc:metal/nugget/wrought_iron>);