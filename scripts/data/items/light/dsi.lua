local item, super = Class(LightEquipItem, "light/dsi")

function item:init()
    super.init(self)

    -- Display name
    self.name = "DSi"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 150

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Surely nobody cares if this is damaged."

    -- Light world check text
    self.check = "Weapon AT 3\n* Surely nobody cares if\nthis is damaged."

    self.bonuses = {
        attack = 3
    }

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
end

function item:convertToDarkEquip(chara)
    return "ds_hammer"
end

return item