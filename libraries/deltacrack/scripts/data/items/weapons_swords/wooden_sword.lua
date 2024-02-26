local item, super = Class(Item, "wooden_sword")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Wooden Sword"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Crafted with two wooden planks and a stick."

    -- Default shop price (sell price is halved)
    self.price = 40
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
        goob = true,
    }

    -- Character reactions
    self.reactions = {
        asriel      = "Ew, default gear! Get that thing away from me!",
        ralsei      = "(No thanks...)",
        synthlave   = "(This isn't Minecrap, you GOOBER!)",
    }
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item