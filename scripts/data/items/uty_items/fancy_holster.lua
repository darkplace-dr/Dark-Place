local item, super = Class(LightEquipItem, "uty_items/fancy_holster")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Fancy Holster"
    self.short_name = "FancHolst"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    self.price = 50
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(A leather weapon-holder, perfect for duels at noon.)"

    -- Light world check text
    self.check = "Armor DF 8\n* (A leather weapon-holder,\nperfect for duels at noon.)"

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 8
    }

end

return item