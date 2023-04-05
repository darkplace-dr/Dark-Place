-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "syringe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Syringe"
    -- Name displayed when used in battle (optional)
    self.use_name = "SYRINGE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Useless."
    -- Shop description
    self.shop = "Not sure what's\ninside\n+?? HP"
    -- Menu description
    self.description = "An empty syringe. Probably for the better.\nPretty useless."

    -- Amount healed (HealItem variable)
    self.heal_amount = 0

    -- Default shop price (sell price is halved)
    self.price = 10
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "none"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil
end

return item
