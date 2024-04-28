local item, super = Class(Item, "hyper_knife")

function item:init()
    super.init(self)

    -- Display name
    self.name = "HyperKnife"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/knife"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Well, i found this knife in the ground."
    -- Menu description
    self.description = "The completely (not) exclusive Knife of Dumbie."

    -- Default shop price (sell price is halved)
    self.price = 500
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
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Ultra Knife"
    self.bonus_icon = "ui/menu/ui/knife"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dumbie = true,
		kris = true,
    }

    -- Character reactions
    self.reactions = {
        dumbie = "THE POWER OF SUN, IN THE PALM OF MY HAND!!!!!",
        brenda = "I... don't really like knives.",
		jamm = "Not my weapon. I said no!"
    }
end

return item