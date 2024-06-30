local item, super = Class(Item, "leadmaker")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Leadmaker"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Makes\nLead"
    -- Menu description
    self.description = "A machine that makes lead.\nSell at the end of battles for $ +25%!"

    -- Default shop price (sell price is halved)
    self.price = 750
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "$ +25%"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
		noelle = false,
		dess = false,
        brenda = false
	}

    -- Character reactions
    self.reactions = {
        susie = "It's a humble job but it pays well.",
        ralsei = "I'll work hard!",
        noelle = "What? How do I use it?",
		dess = "I hate work",
        brenda = "How the hell does this work?",
		jamm = "I could use some lead, but if I have to sell it...",
        noel = "(I will treat this like a candy dispenser.)",
    }
end

function item:applyMoneyBonus(gold)
    return gold * 1.25
end

return item