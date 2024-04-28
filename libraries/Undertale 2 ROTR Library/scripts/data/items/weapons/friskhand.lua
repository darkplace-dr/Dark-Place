local item, super = Class(Item, "friskhand")

function item:init()
    super.init(self)

    -- Display name
    self.name = "FriskHand"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/hand"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Do not unequip\nIt will hurt alot"

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
        attack = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        frisk2 = true,
        dess = true,
    }

    -- Character reactions
    self.reactions = {
		dess = "nice",
		ralsei = "OH MY GOD",
		susie = "PLEASE PUT THAT BACK",
		noelle = "*Screaming*",
        brenda = "OH GOODNESS",
		frisk2 = "Back where it belongs.",
    }
end

--function item:convertToLightEquip(chara)
--    return "light/pencil"
--end

return item