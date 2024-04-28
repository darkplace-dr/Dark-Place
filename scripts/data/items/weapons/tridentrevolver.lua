local item, super = Class(Item, "tridentrevolver")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Tri.Revolver"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/gun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A large gun worn on the forearm.\nShoots three bullets at a time."

    -- Default shop price (sell price is halved)
    self.price = 2500
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
        magic = 3,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        brenda = true,
		pauling = true,
    }

    self.bolt_count = 3

    -- Character reactions
    self.reactions = {
        susie = "It's time to rize and shine!",
        ralsei = "Wow, it's um... very big.",
        noelle = "Is this supposed to replace your arm?",
		dess = "pokemon is better tbh",
        brenda = "It's fightin' time!",
		jamm = "Three times what I'm used to..."
    }
end

return item