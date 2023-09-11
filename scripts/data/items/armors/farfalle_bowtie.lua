local item, super = Class(Item, "farfalle_bowtie")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Farfalle B.Tie"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "WARNING:\nNOT EDIBLE"
    -- Menu description
    self.description = "A bow tie in the shape of farfalle pasta"

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
        defense = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Al Dente"
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    --[[self.can_equip = {
		noelle = false,
	}]]

    -- Character reactions
    self.reactions = {
        susie = "Can I eat it?",
        ralsei = "Fancy!",
        noelle = "I don't usually play with my food but sure...",
        dess = "somebody touched my spaghet",
        brandon = "Pasta la Vista!",
		jamm = "...He pasta way!"
    }
end

return item
