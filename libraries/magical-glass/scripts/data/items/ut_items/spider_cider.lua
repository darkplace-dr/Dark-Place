local item, super = Class(HealItem, "ut_items/spider_cider")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Spider Cider"
    self.short_name = "SpidrCidr"
    self.serious_name = "SpidrCider"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 24

    -- Default shop price (sell price is halved)
    self.price = 18
    -- Default shop sell price
    self.sell_price = 60
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Made with whole spiders, not just the juice."

    -- Light world check text
    self.check = "Heals 24 HP\n* Made with whole spiders,[wait:10]\nnot just the juice."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "drank"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = nil

end

return item