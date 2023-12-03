-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "hotdog")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Hotdog...?"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n120 HP"
    -- Shop description
    self.shop = nil
    -- Menu description
    self.description = "A hot dog. It seems to be wagging...?\n+120 HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 120

    -- Default shop price (sell price is halved)
    self.price = 200
    -- Whether the item can be sold
    self.can_sell = true

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

    -- Character reactions (key = party member id)
    self.reactions = {
		jamm = "(Did it bark at me!?)"
    }
end

return item
