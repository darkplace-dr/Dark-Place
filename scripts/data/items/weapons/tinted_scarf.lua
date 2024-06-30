local item, super = Class(Item, "tinted_scarf")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Tinted Scarf"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scarf"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An originally pink scarf\ntinted green."

    -- Default shop price (sell price is halved)
    self.price = 100
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
        ralsei = true,
        prince = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Who the hell painted this so badly?",
        ralsei = "It's... Familiar!",
        prince = "Going classy, are we?",
        noelle = "Huh? N-No, I'm not cold.",
		jamm = "Missed a spot. Yeah, right there.",
        noel = "*thumbs up*",
    }
end

return item