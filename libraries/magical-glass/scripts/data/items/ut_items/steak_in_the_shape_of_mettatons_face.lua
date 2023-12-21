local item, super = Class(HealItem, "ut_items/steak_in_the_shape_of_mettatons_face")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Face Steak"
    self.short_name = "FaceSteak"
    self.serious_name = "Steak"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 60

    -- Default shop price (sell price is halved)
    self.price = 300
    -- Default shop sell price
    self.sell_price = 14
    -- Whether the item can be sold
    self.can_sell = true

    -- Light world check text
    self.check = {
        "Heals 60 HP\n* Huge steak in the shape\nof Mettaton's face.",
        "* (You don't feel like it's\nmade of real meat...)"
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

function item:getShortName()
    local name = Kristal.Config["defaultName"]
    if name == "DRAK" or name == "GIGI" or name == "GUGU" or name == "SAM" then
        return "Fsteak"
    else
        return super.getShortName(self)
    end
end

return item