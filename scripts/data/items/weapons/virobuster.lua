local item, super = Class(Item, "virobuster")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ViroBuster"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/axe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An axe designed specifically to kill corrupted programs.\nBuster spells deal 2x damage to foes under half health"

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
        attack = 5,
        magic  = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Final Blow"
    self.bonus_icon = "ui/menu/icon/demon"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = true,
        robo_susie = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Time for some imminent axecution!",
        ralsei = "It feels... dangerous?",
        noelle = "U-um, th-this is for Susie.",
        dess = "woah it hates me, cool!",
        brenda = "Yeah uh, keep that away from me please.",
		jamm = "Hey, can I use this for Deoxynn? No? Damn...",
    }
end

return item