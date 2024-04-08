local item, super = Class(LightEquipItem, "ut_armors/manly_bandanna")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Manly Bandanna"
    self.short_name = "Mandanna"
    self.serious_name = "Bandanna"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Shop description
    self.shop = "It has abs\non it."
    -- Default shop price (sell price is halved)
    self.price = 50
    -- Default shop sell price
    self.sell_price = 50
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "It has seen some wear.\nIt has abs drawn on it."

    -- Light world check text
    self.check = "Armor DF 7\n* It has seen some wear.\nIt has abs drawn on it."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 7
    }

end

return item