local item, super = Class(Item, "cracked_bat")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CrackedBat"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/bat"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A bat that's also an\nEarthBound reference."

    -- Default shop price (sell price is halved)
    self.price = 4
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
        attack = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = true,
    }

    -- Character reactions
    self.reactions = {
		dess = "yes",
		ralsei = "Isn't that a bit violent?",
		susie = "...That's gonna break.",
		noelle = "That's not mine!",
        brenda = "SMASH!",
		jamm = "I... don't think this works.",
                noel = "?.. This isn't meant to be here."
    }
end

--function item:convertToLightEquip(chara)
--    return "light/pencil"
--end

return item