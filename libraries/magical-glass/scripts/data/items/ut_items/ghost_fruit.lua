local item, super = Class(HealItem, "ut_items/ghost_fruit")

function item:init(inventory)
    super.init(self)

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Display name
    self.name = "Ghost Fruit"
    self.short_name = "GhostFrut"
    self.serious_name = "GhstFruit"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 16

    -- Default shop sell price
    self.sell_price = 10
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "If eaten, it will never pass to the other side."

    -- Light world check text
    self.check = "Heals 16 HP\n* If eaten,[wait:10] it will never\npass to the other side."

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