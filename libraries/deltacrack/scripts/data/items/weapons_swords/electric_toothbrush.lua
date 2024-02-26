local item, super = Class(Item, "electric_toothbrush")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ElectricToothbrush"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Press hilt"
    -- Menu description
    self.description = "Press the hilt and throw it at your enemy's face! (True Damage)"

    -- Default shop price (sell price is halved)
    self.price = 400
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
        attack = 6,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Clean"
    self.bonus_icon = "ui/menu/icon/magic"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        goob = true,
    }

    -- Character reactions
    self.reactions = {
        asriel      = "My worst enemy! Don't let it touch me!",
        ralsei      = "Hygiene!",
        synthlave   = "Robot ~= Clean.",
    }
end

function item:convertToLightEquip(chara)
    return "light/mech_pencil"
end

return item