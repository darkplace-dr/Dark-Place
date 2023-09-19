local item, super = Class(Item, "gold_bell")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Gold Bell"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    -- I couldn't draw a bell sprite that looked good, so...
    self.icon = "ui/menu/icon/star"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A large golden bell. It makes a pleasant\nsound when you ring it."
    
    -- Default shop price (sell price is halved)
    self.price = 60
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
        ostarwalker = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Too noisy.",
        ralsei = "It's a little heavy...",
        noelle = "I prefer jingle bells...",
        ostarwalker = "The original                   bell"
    }
end


return item