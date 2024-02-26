local item, super = Class(LightEquipItem, "light/knife")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Knife"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Light world check text
    self.check = "Weapon 4 AT\n* ...\n* This isn't mine..."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 4,
        defense = 0
    }

    -- Default dark item conversion for this item
    self.dark_item = "iron_sword"
end

return item