local item, super = Class(Item, "pipis_popper")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Pipis Popper"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/gun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Placeholder text"

    -- Default shop price (sell price is halved)
    self.price = nil
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
        attack = 7,
        magic = 5
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        brandon = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Can I eat the eggs?",
        ralsei = "This looks great for a party!",
        noelle = "(It's so familiar...)",
		dess = "holy fuck scampton",
        brandon = "The power of NEO pipis!"
    }
end

return item