local item, super = Class(HealItem, "ut_items/abandoned_quiche")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Abandoned Quiche"
    self.short_name = "Ab Quiche"
    self.serious_name = "Quiche"
    self.use_name = "quiche"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 34

    -- Default shop sell price
    self.sell_price = 76
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A psychologically damaged spinach egg pie."

    -- Light world check text
    self.check = "Heals 34 HP\n* A psychologically damaged\nspinach egg pie."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:onToss()
    Game.world:showText("* You leave the Quiche on the\nground and tell it you'll\nbe right back.")
    return true
end

return item