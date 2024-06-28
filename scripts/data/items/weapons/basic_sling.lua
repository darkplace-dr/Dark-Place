local item, super = Class(Item, "basic_sling")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Basic Sling"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sling"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A weak slingshot. It's so overused, you have to hold it together."

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
        attack = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        jamm = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "What is this, a chew toy?",
        ralsei = "U-um... No thanks.",
        noelle = "O-oh, you just... Ow, my eye!",
        jamm = "Ol' reliable.",
        noel = "I will break it..."
    }
end

function item:convertToLightEquip(inventory)
    return "light/rope_sling"
end

return item