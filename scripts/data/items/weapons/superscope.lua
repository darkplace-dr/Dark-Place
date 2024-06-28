local item, super = Class(Item, "superscope")

function item:init()
    super.init(self)

    -- Display name
    self.name = "SuperScope"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/gun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A rifle from a 90s video game console."

    -- Default shop price (sell price is halved)
    self.price = 650
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
        attack = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        brenda = true,
		pauling = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Looks cool, but nah.",
        noel = "Look, a gun. How origoan- FUCK, I CANT CPELL!!!",
        ralsei = "This looks really retro!",
        noelle = "I think I have one of these at home.",
		dess = "so retro",
        brenda = "Let's-a go!",
		jamm = "Never thought I'd see one of these again..."
    }
end

function item:convertToLightEquip(inventory)
    return "light/light_gun"
end

return item
