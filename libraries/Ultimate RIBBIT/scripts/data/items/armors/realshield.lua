local item, super = Class(Item, "realshield")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Real Shield"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/placebo"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Imaginary item. Despite being non-existent,\njust believing in it gives you strength."

    -- Default shop price (sell price is halved)
    self.price = 69
    -- Whether the item can be sold
    self.can_sell = false

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
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Imagination"
    self.bonus_icon = "up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        robo_susie = false,
        noelle = false,
        susie = false,
        dess = false,
        kris = false,
    }

    -- Character reactions
    self.reactions = {
        robo_susie = "But that's not real.",
        noyno = "Pew, pew! Shield bullets!",
        susie = "(I'm not gonna hold hands with you!)",
        noelle = "Is this some kind of prank???",
        dess = "bitch htwhat the UFKC are you doing , you litel rat",
        ralsei = "(I believe!)",
        kris = "(...?)",
    }

    
end

function item:convertToLightEquip(chara)
    return "light/ignorance"
end

return item