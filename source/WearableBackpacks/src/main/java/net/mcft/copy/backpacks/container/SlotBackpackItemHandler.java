package net.mcft.copy.backpacks.container;

import net.minecraft.item.ItemStack;
import net.minecraftforge.items.IItemHandler;
import net.minecraftforge.items.SlotItemHandler;

import net.dries007.tfc.api.capability.size.CapabilityItemSize;
import net.dries007.tfc.api.capability.size.IItemSize;
import net.dries007.tfc.api.capability.size.Size;

public class SlotBackpackItemHandler extends SlotItemHandler
{
    public SlotBackpackItemHandler(IItemHandler itemHandler, int index, int xPosition, int yPosition)
    {
        super(itemHandler, index, xPosition, yPosition);
    }

    @Override
    public boolean isItemValid(ItemStack stack)
    {
        IItemSize cap = CapabilityItemSize.getIItemSize(stack);
        if (cap != null)
        {
            return cap.getSize(stack).isSmallerThan(Size.LARGE);
        }
        return true;
    }
}