local item, super = Class(Item, "veere")

function item:init()
    super.init(self)

    -- Display name
    self.name = "VeeRe"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/guitar"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "This upgraded guitar slows the enemy's time on\nimpact, so that they savor each moment of pain."

    -- Default shop price (sell price is halved)
    self.price = 200
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
    self.bonus_name = "ItsJustFlavaTxt"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        YOU = true,
        kris = true,
    }

    -- Character reactions
    self.reactions = {
        robo_susie = "Keep it. It looks good on you.",
        noyno = "Is this thing even real?",
        susie = "(You're not getting me to touch that.)",
        noelle = "(What's... this for?)",
        dess = "Wwowow hahah real as fuck righyt guys? NO",
        ralsei = "(W-Wow! Can you play any... songs?? Or literally anything?)",
    }
end

function item:convertToLightEquip(chara)
    return "light/guilt_tripping"
end

return item