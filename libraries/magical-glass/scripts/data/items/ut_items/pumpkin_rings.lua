local item, super = Class(HealItem, "ut_items/pumpkin_rings")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Pumpkin Rings"
    self.short_name = "PunkRings"
    self.serious_name = "PmknRings"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 8

    -- Default shop price (sell price is halved)
    self.price = 3
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A small pumpkin cooked like onion rings."

    -- Light world check text
    self.check = "Heals 8 HP\n* A small pumpkin\ncooked like onion rings."

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