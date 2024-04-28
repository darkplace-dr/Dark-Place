-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "apple_core")

function item:init()
    super.init(self)

    -- Display name
    self.name = "AppleCore"
    -- Name displayed when used in battle (optional)
    self.use_name = "APPLE CORE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n?? HP"
    -- Shop description
    self.shop = nil
    -- Menu description
    self.description = "An apple core. You probably shouldn't eat this. +?? HP"

    -- Amount healed (HealItem variable)
    self.heal_amounts = {
        kris = 5,
        susie = 10,
        ralsei = 5,
        noelle = 5,
        YOU = 10,
        dess = 15,
        brenda = 5,
		jamm = 0
    }

    -- Default shop price (sell price is halved)
    self.price = 10
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "apple_seeds"
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
        susie = "Better than nothing...",
        ralsei = "This tastes... not good...",
        noelle = "Wh-why did you make me eat this?!",
		dess = "yeah this is still good",
        brenda = "...Ew.",
		jamm = "Yeah... No way am I eating that..."
    }
end

return item
