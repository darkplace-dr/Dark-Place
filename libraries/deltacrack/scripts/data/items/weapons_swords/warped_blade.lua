local item, super = Class(Item, "warped_blade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Warped Blade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Warped, like the acts of some."

    -- Default shop price (sell price is halved)
    self.price = 9999
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
        attack = 16,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Trance"
    self.bonus_icon = "ui/menu/icon/down"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        goob = true,
    }

    -- Character reactions
    self.reactions = {
        asriel      = "Eh, I'll stick to this...",
        ralsei      = "...",
        synthlave   = "Interesting path.",
    }
end

return item