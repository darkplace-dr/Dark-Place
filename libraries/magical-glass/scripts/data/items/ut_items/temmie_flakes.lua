local item, super = Class(HealItem, "ut_items/temmie_flakes")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Temmie Flakes"
    self.short_name = "TemFlakes"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 2

    -- Shop description
    self.shop = "Heals 2HP\nfood of\ntem"
    -- Default shop price (sell price is halved)
    self.price = 3
    -- Default shop sell price
    self.sell_price = 2
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "It's just town up pieces of colored construction paper."

    -- Light world check text
    self.check = "Heals 2 HP\n* It's just town up pieces\nof colored construction paper."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- How this item is used on you (ate, drank, eat, use, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, uses, etc.) (defaults to use_method_self)
    self.use_method_other = "eats"
    
end

return item