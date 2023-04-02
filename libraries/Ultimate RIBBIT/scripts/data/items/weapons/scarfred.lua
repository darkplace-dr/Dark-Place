local item, super = Class(Item, "scarfred")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Scarfred"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scarf"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A scarf crafted by Noyno's loyal butler.\nSaid butler appears to be MIA."

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
        attack = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noyno = true,
        ralsei = true,
        noelle = true,
    }

    -- Character reactions
    self.reactions = {
        robo_susie = "A lousy strangling device.",
        noyno = "Good old scarfy!",
        susie = "No. Just... no.",
        noelle = "It's vibrant!",
        dess = "ITS NOT FUCKIGN WINTER. ??",
        ralsei = "Good as old!",
    }
end

return item