local item, super = Class(HealItem, "ut_items/puppydough_icecream")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Puppydough Icecream"
    self.short_name = "PDIceCram"
    self.serious_name = "Ice Cream"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 28

    -- Default shop sell price
    self.sell_price = 2
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Made by young pups."

    -- Light world check text
    self.check = "Heals 28 HP\n* Made by young pups."

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