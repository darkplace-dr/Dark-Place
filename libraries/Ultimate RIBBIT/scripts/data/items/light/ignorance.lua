local item, super = Class(LightEquipItem, "light/ignorance")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Blind Ignorance"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Light world check text
    self.check = "Armor 0 DF\n* Just makes you an idiot."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 0,
        defense = 0
    }

    -- Default dark item conversion for this item
    self.dark_item = nil
end

return item