local item, super = Class(Item, "trick_o_kill")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Trick O' Kill"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Black-and\norange"
    -- Menu description
    self.description = "A sword perfect for trick or treating. Wait, why do you even need a sword for trick or treating?"

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
        attack = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Halloweeness UP"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        goob = true,
    }

    -- Character reactions
    self.reactions = {
        asriel      = "You guys have halloween here?!",
        ralsei      = "Oh, it's too scary!",
        synthlave   = "Halloween? More like hall-o-wieners!",
    }
end

function item:convertToLightEquip(chara)
    return "light/halloween_pencil"
end

return item