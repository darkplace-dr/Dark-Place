local item, super = Class(Item, "iron_sword")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Iron Sword"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Advancement Get!"

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
        attack = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        gerome = true,
        goob = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Hey, ain't this from Minecrap?",
        ralsei = "Fancy like a knight!... No, not that one.",
        asriel = "I'd prefer a diamond one..",
        synthlave = "Shiny."
    }
end

function item:convertToLightEquip(chara)
    return "light/knife"
end

return item