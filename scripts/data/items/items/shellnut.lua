-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "shellnut")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Shellnut"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Shield"
    -- Shop description
    self.shop = "Protection"
    -- Menu description
    self.description = "A nut with a strange, protective property. Apply it in battle."

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "battle"
    -- Item this item will get turned into when consumed
    self.result_item = nil
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

function item:onBattleUse(user, target)
	target:addShield(35)
end

return item