local item, super = Class(HealItem, "ut_items/nice_cream")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Nice Cream"
    self.short_name = "NiceCream"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 15

    -- Default shop price (sell price is halved)
    self.price = 15
    -- Default shop sell price
    self.sell_price = 2
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Instead of a joke, the wrapper says something nice."

    -- Light world check text
    self.check = "Heals 15 HP\n* Instead of a joke,[wait:10] the\nwrapper says something nice."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:getWorldUseText(target)
    local picker = math.floor(Utils.random(8))
    local message = {
        "* You're just great!",
        "* You look nice today!",
        "* Are those claws natural?",
        "* You're super spiffy!",
        "* Have a wonderful day!",
        "* Is this as sweet as you?",
        "* (An illustration of a hug.)",
        "* Love yourself! I love you!"
    }
    return message[picker]
end

function item:getLightBattleText(user, target)
    local picker = math.floor(Utils.random(8))
    local message = {
        "* You're just great!",
        "* You look nice today!",
        "* Are those claws natural?",
        "* You're super spiffy!",
        "* Have a wonderful day!",
        "* Is this as sweet as you?",
        "* (An illustration of a hug.)",
        "* Love yourself! I love you!"
    }
    return message[picker]
end

return item