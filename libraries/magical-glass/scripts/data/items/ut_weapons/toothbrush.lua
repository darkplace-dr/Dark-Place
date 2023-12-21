local item, super = Class(LightEquipItem, "weapons/toothbrush")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Toothbrush"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Light world check text
    self.check = "Weapon 1 AT\n* Keeps the plaque away...\n* Or, that's what the dentists say."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 1
    }

    -- Default dark item conversion for this item
    self.dark_item = "mane_ax"
end

return item