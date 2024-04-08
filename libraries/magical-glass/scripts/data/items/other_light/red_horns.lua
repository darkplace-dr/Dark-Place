local item, super = Class(LightEquipItem, "light/red_horns")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Red Horns"
    self.short_name = "RedHorns"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Whether the item can be sold
    self.can_sell = true
    
    -- Item description text (unused by light items outside of debug menu)
    self.description = "Kris's beloved red horned headband."

    -- Light world check text
    self.check = {
        "Armor 1 MG\n* Kris's beloved red horned headband."
    }
    
    self.price = 100
    
    self.shop_magic = true

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        magic = 1
    }

end

return item