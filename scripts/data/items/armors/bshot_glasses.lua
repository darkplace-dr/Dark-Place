local item, super = Class(Item, "bshot_glasses")

function item:init()
    super.init(self)

    -- Display name
    self.name = "B.ShotGlasses"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A pair of pink-yellow colored glasses.\nIncreases money gained after battle by 50%."

    -- Default shop price (sell price is halved)
    self.price = 100
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
        defense = 2,
        magic = 1
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "$ +50%"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
    noel = false,
    }

    -- Character reactions
    self.reactions = {
        susie = "Reminds me of someone...",
        noel = "Do I look BLIND to you PLAYER?",
        ralsei = "Two pairs of glasses?",
        noelle = "How can you see through this?!",
		dess = "holy shit spamton reference",
        brenda = "Time to be a Big Shot!",
		jamm = "(The glasses are clear...)"
    }
end

function item:applyMoneyBonus(gold)
    return gold * 1.5
end

return item