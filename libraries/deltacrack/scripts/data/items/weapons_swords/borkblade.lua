local item, super = Class(Item, "borkblade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "BorkBlade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A clean white bladed sword with a hilt with the shape of a dog's face."

    -- Default shop price (sell price is halved)
    self.price = 580
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
        attack  = 6,
        defense = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Annoying"
    self.bonus_icon = "ui/menu/icon/smile_dog"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        goob = true,
    }

    -- Character reactions
    self.reactions = {
        asriel      = "Hey, it's that annoying dog from back home!",
        ralsei      = "T-tell it to stop barking at me!",
        synthlave   = "Bark bark.",
    }
end

function item:convertToLightEquip(chara)
    return "light/eraser"
end

return item