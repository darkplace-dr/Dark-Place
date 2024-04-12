local item, super = Class(LightEquipItem, "light/toothbrush")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Toothbrush"
    self.short_name = "TthBrush"
    self.serious_name = "Brush"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Keeps the plaque away...\nOr, that's what the dentists say."

    -- Light world check text
    self.check = "Weapon 1 AT\n* Keeps the plaque away...\n* Or, that's what the dentists say."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    
    self.price = 30

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 1
    }

    -- Default dark item conversion for this item
    self.dark_item = "mane_ax"
end

return item