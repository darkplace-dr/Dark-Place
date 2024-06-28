local item, super = Class(LightEquipItem, "light/old_umbrella")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Old Umbrella"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop price (sell price is halved)
    self.price = 1
    -- Default shop sell price
    self.sell_price = 1
    -- Whether the item can be sold
    self.can_sell = false

    -- Item description text (unused by light items outside of debug menu)
    self.description = "* This is my umbrella.\n* I carry it with me everywhere.."

    -- Light world check text
    self.check = {
        "How are you checking this?"
    }

    self.bonuses = {
        attack = 1
    }

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
end

function item:convertToDarkEquip(chara)
    return "old_umbrella"
end

return item