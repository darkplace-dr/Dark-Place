-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "punch_bowl")

-- look man I gave up
-- I just wanted a healing item which heals the spellcasters a lot

function item:init()
    super.init(self)

    -- Display name
    self.name = "PunchBowl"
    -- Name displayed when used in battle (optional)
    self.use_name = "PUNCH BOWL"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Lots of\njuice"
    -- Shop description
    self.shop = "It's a\npunch bowl."
    -- Menu description
    self.description = "Fruit punch.\nHeals everyone. +??HP"

    -- Amount healed (HealItem variable)
    self.heal_amounts = {
        ["kris"] = 60,
        ["susie"] = 50,
        ["ralsei"] = 100,
        ["noelle"] = 80,
		["dess"] = 20,
        ["brenda"] = 40,
		["jamm"] = 0
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
        susie = "Too much juice.",
        ralsei = "I love punch!",
        noelle = 'Why is it called "punch?"',
		dess = "I don't trust it",
        brenda = "Never really been a fan.",
		jamm = "Alright. I punched it. What next?"
    }
end

return item