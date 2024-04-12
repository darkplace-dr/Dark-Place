local item, super = Class(HealItem, "ut_items/astronaut_food")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Astronaut Food"
    self.short_name = "AstroFood"
    self.serious_name = "Astr.Food"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 21

    -- Default shop sell price
    self.sell_price = 25
    -- Whether the item can be sold
    self.can_sell = true
    
    -- Item description text (unused by light items outside of debug menu)
    self.description = "For feeding a pet astronaut."

    -- Light world check text
    self.check = "Heals 21 HP\n* For feeding a pet astronaut."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

return item