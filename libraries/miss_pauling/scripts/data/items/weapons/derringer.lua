local item, super = Class(Item, "derringer")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Derringer"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/pistol"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A worn-down pistol."

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
        pauling = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "My finger won't fit!",
        ralsei = "*Chapter 1 flashbacks*",
        noelle = "I-is that a gun!?",
    }
end

function item:convertToLightEquip(inventory)
    return "light/rb_gun"
end

return item