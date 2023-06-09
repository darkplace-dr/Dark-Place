local item, super = Class(Item, "leaf")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Leaf"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "A leaf."
    -- Menu description
    self.description = "A leaf that got stuck in Frisk's Hair\nLooks kinda cute."

    -- Default shop price (sell price is halved)
    self.price = 100
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
        defense = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        susie = "Hell yeah, free food.",
        ralsei = "I'm a tree now, Kris!",
        noelle = "It, is sorta cute...",
		dess = "It's not crispy. 0/10",
		frisk2 = "its my hat.",
    }
end

return item