local item, super = Class(Item, "old_tome")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Old Tome"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An old tome written in an unkown language. It's completely unreadable"

    -- Default shop price (sell price is halved)
    self.price = 30
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
        attack = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
    }

    -- Character reactions
    self.reactions = {
        noel = "*reads it* It's blank...",
        susie = "I can't read this.",
        ralsei = "What language is this in?",
        noelle = "It feels... magical...",
		dess = "I'm REALLY not a fucking nerd",
        brenda = "Ooo, I love books!",
		jamm = "They don't pay me enough for this!"
    }
end

return item