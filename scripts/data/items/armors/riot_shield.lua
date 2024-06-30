local item, super = Class(Item, "riot_shield")

function item:init()
    super.init(self)

    -- Display name
    self.name = "RiotShield"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Funny\nShield"
    -- Menu description
    self.description = "Equipping this is sure\nto make you a riot."

    -- Default shop price (sell price is halved)
    self.price = 600
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
        susie = "What's black and blue and red all over?",
        ralsei = "Knock knock!",
        noelle = "Wh- uh... airline food?",
		dess = "69 lmao",
        brenda = "Sus Among U-",
		jamm = "Well, I'm on my way to the White House. Don't wait up.",
        noel = "An oversized mug would be better.",
    }
end

return item