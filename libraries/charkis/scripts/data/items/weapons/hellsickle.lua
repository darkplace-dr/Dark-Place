local item, super = Class(Item, "hellsickle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Hellsickle"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scythe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A scythe carefully crafted by Junkil.\nMake sure not to be very naughty, naughty with this!"

    -- Default shop price (sell price is halved)
    self.price = 0
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
        attack = 6,
        magic  = 5,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        charkis = true,
        dess = true,
        goobert = true,
        alseri = true,
        noyno = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "(Say, do you have an extra sized version?)",
        charkis = "I'll be taking this!",
        brandon = "I'm sticking to the gun, yes?",
        bor = "nah blud too late",
        dess = "AYYYYYYYYY hell fuckin yea basbe!!!!!!!11",
        alseri = "Hell yeah!",
        goobert = "boogert like this. sythc good. smyle",
        robo_susie = "Let's not, my friend.",
        noyno = "Let the games begin!",
        ralsei = "It's too, um, evil.",
        noelle = "...? It smiled at me?",
    }
end

return item