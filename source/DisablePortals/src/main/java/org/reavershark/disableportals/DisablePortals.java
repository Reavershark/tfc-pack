package org.reavershark.disableportals;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.Mod.EventHandler;
import net.minecraftforge.fml.common.event.FMLInitializationEvent;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import org.apache.logging.log4j.Logger;

import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.event.world.BlockEvent;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;

@Mod(modid = DisablePortals.MODID, name = DisablePortals.NAME, version = DisablePortals.VERSION)
public class DisablePortals
{
    public static final String MODID = "disableportals";
    public static final String NAME = "Disable Portals";
    public static final String VERSION = "1.0";

    private static Logger logger;

    @EventHandler
    public void preInit(FMLPreInitializationEvent event)
    {
        logger = event.getModLog();
    }

    @EventHandler
    public void init(FMLInitializationEvent event)
    {
        logger.info("Disabling nether portal creation.");
        MinecraftForge.EVENT_BUS.register(new Object() {
            @SubscribeEvent
            public void tick(BlockEvent.PortalSpawnEvent event) {
                event.setCanceled(true);
            }
        });
    }
}
