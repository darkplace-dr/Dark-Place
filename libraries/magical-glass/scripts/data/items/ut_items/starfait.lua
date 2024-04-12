local item, super = Class(HealItem, "ut_items/starfait")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Starfait"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "drink"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "drinks"

    -- note: in the mettaton ex fight, you *eat* the starfait, rather than drink it

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 14

    -- Shop description
    self.shop = "Heals 14HP\nVery popular\nfood."
    -- Default shop price (sell price is halved)
    self.price = 60
    -- Default shop sell price
    self.sell_price = 10
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A sweet treat made of sparkling stars."

    -- Light world check text
    self.check = "Heals 14 HP\n* A sweet treat made of\nsparkling stars."

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