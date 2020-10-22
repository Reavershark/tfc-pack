package org.reavershark.nametagedit;

import javax.annotation.Nonnull;
import javax.annotation.ParametersAreNonnullByDefault;

import net.minecraft.command.CommandBase;
import net.minecraft.command.CommandException;
import net.minecraft.command.ICommandSender;
import net.minecraft.command.WrongUsageException;
import net.minecraft.entity.Entity;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.item.ItemStack;
import net.minecraft.server.MinecraftServer;

import net.minecraft.inventory.ContainerRepair;

@ParametersAreNonnullByDefault
public class CommandNametag extends CommandBase
{
    @Override
    @Nonnull
    public String getName()
    {
        return "nametag";
    }

    @Override
    @Nonnull
    public String getUsage(ICommandSender sender)
    {
        return "";
    }

    @Override
    public void execute(MinecraftServer server, ICommandSender sender, String[] args) throws CommandException
    {
        // if (args.length != 1) throw new WrongUsageException("");
        EntityPlayer player = (EntityPlayer) sender.getCommandSenderEntity();
        ContainerRepair c = new ContainerRepair(player.inventory, player.getEntityWorld(), player);
        player.openGui(NametagEdit.getInstance(), 0, player.getEntityWorld(), 0, 0, 0);
    }

    @Override
    public int getRequiredPermissionLevel()
    {
        return 2;
    }
}

