local item, super = Class(HealItem, "ut_items/snowman_piece")

function item:init(inventory)
    -- this guy's probably pretty happy he got moved to an entirely different game
    super.init(self)

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Display name
    self.name = "Snowman Piece"
    self.short_name = "SnowPiece"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 45

    -- Default shop sell price
    self.sell_price = 40
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Please take this to the ends of the earth."

    -- Light world check text
    self.check = "Heals 45 HP\n* Please take this to the\nends of the earth."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

return item