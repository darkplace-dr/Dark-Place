local item, super = Class(LightEquipItem, "uty_items/safety_goggles")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Safety Goggles"
    self.short_name = "Goggles"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    self.price = 70
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(Paramount to all Steamworks employees.)"

    -- Light world check text
    self.check = "Armor DF 9\n* (Paramount to all Steamworks\nemployees.)"

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 9
    }

end

return item