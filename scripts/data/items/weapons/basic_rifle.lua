local item, super = Class(Item, "basic_rifle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Basic Rifle"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/gun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A cheap rifle that just barely gets the job done."

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
        brenda = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Nah, I don't use guns.",
        ralsei = "U-um... No thanks.",
        noelle = "I-it's not deer season, is it?",
		dess = "pew pew",
        brenda = "Uh, okay then?",
		jamm = "But I'm not an NRA member!",
        noel = "Pathetic"
    }
end

function item:convertToLightEquip(inventory)
    return "light/foam_dart_rifle"
end

return item