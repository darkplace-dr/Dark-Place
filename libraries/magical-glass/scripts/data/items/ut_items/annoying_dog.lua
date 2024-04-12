local item, super = Class(Item, "ut_items/annoying_dog")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Annoying Dog"
    self.short_name = "AnnoyDog"
    self.serious_name = "Dog"
    self.use_name = "Dog"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "deployed"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 999
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A little white dog.\nIt's fast asleep..."

    -- Light world check text
    self.check = "Dog\n* A little white dog.[wait:10]\n* It's fast asleep..."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:onToss()
    Game.world:showText("* (You put the dog on the\nground.)")
    return true
end

return item