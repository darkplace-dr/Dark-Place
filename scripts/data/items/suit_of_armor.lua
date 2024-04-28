local item, super = Class(Item, "suitofarmor")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Suit of Armor"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Full\nsuit"
    -- Menu description
    self.description = "An entire suit of armor. Don't\nask how you can equip two."

    -- Default shop price (sell price is halved)
    self.price = 350
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
        defense = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
		noelle = false,
	}

    -- Character reactions
    self.reactions = {
        susie = "This is badass!",
        ralsei = "*huff* Now I'm protected! *puff*",
        noelle = "No way can I wear that!",
        brenda = "Y'know I wore a suit of armor before, actually.",
		jamm = "No different than the Halloween I went as a knight.",
    }
end

return item