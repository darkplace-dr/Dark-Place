local item, super = Class(Item, "power_helmet")

function item:init()
    super.init(self)

    -- Display name
    self.name = "PowerHelmet"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Helmet which increases both\nattack and defense somehow."

    -- Default shop price (sell price is halved)
    self.price = 400
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
        attack = 5,
        defense = 2,
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
        susie = "I'm gonna floop someone.",
        ralsei = "More headwear? YES!",
        noelle = "I can't wear this...",
        brenda = "Hopefully this doesn't mess up my hair.",
		jamm = "Always wanted to play Football. No, not Soccer."
    }
end

return item