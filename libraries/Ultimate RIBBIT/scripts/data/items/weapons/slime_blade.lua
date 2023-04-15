local item, super = Class(Item, "slime_blade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Slime Blade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Technically just a regular blade, turned to\ngooey madness once YOU touched it."

    -- Default shop price (sell price is halved)
    self.price = 69
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
        attack = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        YOU = true,
        kris = true,
    }

    -- Character reactions
    self.reactions = {
        robo_susie = "*lick* Interesting taste.",
        noyno = "Oh my God, that's disgusting.",
        susie = "(WHY IS IT SO... SLIMY???)",
        noelle = "(Uhhhh no i'm not touching that)",
        dess = "Okay no What the FUCK. is This???",
        ralsei = "(U-Um... No, thanks.)",
    }
end

function item:convertToLightEquip(chara)
    return "light/guilt_tripping"
end

return item