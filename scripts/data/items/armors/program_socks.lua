local item, super = Class(Item, "program_socks")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ProgramSocks"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Intelligent\nLegwear"
    -- Menu description
    self.description = "Long socks that improve\nblood circulation to the brain."

    -- Default shop price (sell price is halved)
    self.price = 450
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
        defense = 3,
		magic = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
		susie = false,
		dess = false,
	}

    -- Character reactions
    self.reactions = {
        susie = "...Just, no.",
        ralsei = "These really help?",
        noelle = "Sure?????",
		dess = "These are for femboys",
        brenda = "D-do I look cute?",
		jamm = "For (i = 0, i < 2, i++), equip socks.",
        noel = "*wears like gloves* Same stats...",
    }
end

return item