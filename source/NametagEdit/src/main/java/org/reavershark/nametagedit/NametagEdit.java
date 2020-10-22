package org.reavershark.nametagedit;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.Mod.EventHandler;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;
import org.apache.logging.log4j.Logger;

import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.event.world.BlockEvent;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;

@Mod(modid = NametagEdit.MODID, name = NametagEdit.NAME, version = NametagEdit.VERSION)
public class NametagEdit
{
    public static final String MODID = "nametagedit";
    public static final String NAME = "Nametag Edit";
    public static final String VERSION = "1.0";

    private static Logger logger;

    @Mod.Instance
    private static TerraFirmaCraft INSTANCE = null;

    public static TerraFirmaCraft getInstance()
    {
        return INSTANCE;
    }

    @EventHandler
    public void onServerStarting(FMLServerStartingEvent event)
    {
        event.registerServerCommand(new CommandNametag());
    }

}
