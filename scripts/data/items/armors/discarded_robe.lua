local item, super = Class(Item, "discarded_robe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "DiscdRobe"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An old discarded robe.\nIncreases magic by a lot."

    -- Default shop price (sell price is halved)
    self.price = 700
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
        magic = 5,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        susie = "This is way too small.",
        ralsei = "It's... really dirty",
        noelle = "Smells like cats...",
		dess = "Yo is that a kirby reference??????",
        brenda = "I look good in this!",
		jamm = "Oops, put it on backwards! Let me just... There we go!",
        noel = "Smells like cats!!! :D",
    }
end

return item