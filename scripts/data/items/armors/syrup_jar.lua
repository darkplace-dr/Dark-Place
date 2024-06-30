local item, super = Class(Item, "syrup_jar")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Syrup Jar"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A jar of maple syrup.\nIncreases tension gained by 15%."

    -- Default shop price (sell price is halved)
    self.price = 400
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

        graze_tp = 0.15,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "TPGain"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = false,
        noel = false,
    }

    -- Character reactions
    self.reactions = {
        susie = "They make these up north, right?",
        ralsei = "Goes good on pancakes!",
        noelle = "I love syrup!",
        dess = "im racist against canadians",
        brenda = "O Canada!",
		jamm = "No, seriously, try it. It's, like, maple syrup and bacon. Yeah, I know it's weird, TRUST ME, IT'S GOOD.",
        noel = "(I'm not pouring syrup on my head.)",
    }
end

return item