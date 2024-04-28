local item, super = Class(Item, "pizza_toque")

function item:init()
    super.init(self)

    -- Display name
    self.name = "PizzaToque"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Party can run\nat mach speed."
    -- Menu description
    self.description = "A toque that belonged to certain pizzeria owner.\nAllows the party to run at mach speed and...?"

    -- Default shop price (sell price is halved)
    self.price = 1000
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
        defense = 6,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Italian"
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    --[[self.can_equip = {
		noelle = false,
	}]]

    -- Character reactions
    self.reactions = {
        susie = "Does this mean I get to make AND eat pizza?",
        ralsei = "Hello there!",
        noelle = "Wh-why do I feel paranoid all of a sudden?",
        dess = "i cooka da pizza",
        brenda = "Y'all ready to get funky?",
		jamm = "Pizza, pasta, put it in my box! Deliver it to my house and put it on my--"
    }
end

return item
