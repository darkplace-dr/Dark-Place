local item, super = Class(LightEquipItem, "ut_armors/old_tutu")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Old Tutu"
    self.serious_name = "Tutu"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 80
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Finally, a protective piece of armor."

    -- Light world check text
    self.check = "Armor DF 10\n* Finally,[wait:10] a protective piece\nof armor."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 10
    }

end

return item