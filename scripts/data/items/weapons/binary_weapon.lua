local item, super = Class(Item, "bin_weapon")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Bin Weapon"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = ""

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "It's just 0s\nand 1s"
    -- Menu description
    self.description = "Looks like trash, but it makes the world run."

    -- Default shop price (sell price is halved)
    self.price = 101
    -- Whether the item can be sold
    self.can_sell = true
    self.sell_price = 11

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
        attack = 10,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Low-Level?"
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
        YOU = true,
        susie = true,
        ralsei = false,
        noelle = true,
        dess = true,
        brenda = true,
        jamm = true,
		mario = true,
		pauling = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "It looks sick!",
        ralsei = "How is it supposed to work...?",
        noelle = "Oh it's just like that movie!",
        dess = "LMAO wtf is that?",
        brenda = "Does it say something?",
        noel = "no...",
		jamm = "What did you say about Ania!?"
    }
end

return item