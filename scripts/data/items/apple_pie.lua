-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "apple_pie")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ApplePie"
    -- Name displayed when used in battle (optional)
    self.use_name = "APPLE PIE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "All\nAmerican"
    -- Shop description
    self.shop = "Why does\nthis exist"
    -- Menu description
    self.description = "It's just pie.\nHeals everyone. +??HP"

    -- Amount healed (HealItem variable)
    self.heal_amounts = {
        ["kris"] = 90,
        ["susie"] = 100,
        ["ralsei"] = 20,
        ["noelle"] = 40,
		["dess"] = 250,
        ["brenda"] = 60,
		["jamm"] = 99999
	}

    -- Default shop price (sell price is halved)
    self.price = 200
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
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

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Heck yeah!!",
        ralsei = "It's... sweet!",
        noelle = "I've never been a fan. Sorry!",
		dess = "YEAH WOO AMERICA BABY YEAH",
        brenda = "Eh, pumpkin's better.",
		jamm = "I'm lovin' it!"
    }
end

return item