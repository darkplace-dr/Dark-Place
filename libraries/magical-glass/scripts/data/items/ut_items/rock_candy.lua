local item, super = Class(HealItem, "ut_items/rock_candy")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Rock Candy"
    self.short_name = "RockCandy"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 1

    -- Default shop sell price
    self.sell_price = 3
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Here is a recipe to make this at home:\n1. Find a rock"

    -- Light world check text
    self.check = {
        "Heals 1 HP\n* Here is a recipe to make\nthis at home:",
        "* 1. Find a rock"
    }

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