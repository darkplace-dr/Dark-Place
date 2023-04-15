local item, super = Class(LightEquipItem, "light/guilt_tripping")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Guilt Tripping"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Light world check text
    self.check = "Weapon -999 AT\n* STOP TRYING, KID."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 1,
        defense = 0
    }

    -- Default dark item conversion for this item
    self.dark_item = "slime_blade"
end

return item