local item, super = Class(Item, "hornet_gun")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Hornet's Gun"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/gun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A revolver with quite the illegal history behind it."

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
        attack = 8,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Illegal"
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        brenda = true,
        pauling = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "What is this, a toy?",
        ralsei = "Seems illegal...",
        noelle = "(Too dangerous...)",
        brenda = "Shot over a game of cards...",
		jamm = "Why, Hornet...?",
    }
end

function item:convertToLightEquip(inventory)
    return "light/pellet_gun"
end

return item