-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "unoplica")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Unoplicate"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n20 HP"
    -- Shop description
    self.shop = nil
    -- Menu description
    self.description = "A duplicate of a duplicating item.\nThankfully it won't duplicate anymore. +20HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 20

    -- Default shop price (sell price is halved)
    self.price = 200
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}
end

return item
