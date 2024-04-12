local item, super = Class(Item, "ut_items/invalid")

-- This item is used if you somehow have a non existent item in your inventory.
-- If this somehow happens in Kristal, the game will only load the items that came before the non existent one.
-- instead of doing the above, it will use Undertale's method, which still allows the rest of your items
-- to load normally.

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = ""
    -- self.name = "Invalid Item"
    -- self.short_name = "InvalidItm"
    -- self.serious_name = "Invalid"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Whether the item can be sold
    self.can_sell = false

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Placeholder item."

    -- Light world check text
    self.check = "* If you are reading this,\nI messed up somehow."
    -- self.check = "Error\n* Placeholder item.\n* Did your item got deleted?"

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- self.usable_in = "none"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:onBattleSelect(user, target)
    return false
end

function item:onCheck()
    Game.world:showText(self.check)
end

function item:getBattleText(user, target) return false end

function item:onLightBattleUse(user, target) end

function item:onWorldUse()
    Game.world:closeMenu()
    return false
end

return item