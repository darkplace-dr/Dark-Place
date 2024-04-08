local item, super = Class(HealItem, "ut_items/stoic_onion")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Stoic Onion"
    self.short_name = "StocOnion"
    self.serious_name = "Onion"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 5

    -- Default shop sell price
    self.sell_price = 10
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Even eating it raw, the tears just won't come."

    -- Light world check text
    self.check = "Heals 5 HP\n* Even eating it raw,[wait:10] the\ntears just won't come."

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
    local message = ""
    local picker = Utils.random(10)
    if picker > 8 then
        message = "\n* "..target:getNameOrYou().." didn't cry..."
    end
    return "* "..target:getNameOrYou().." ate the Stoic Onion."..message
end

function item:getLightBattleText(user, target)
    local message = ""
    local picker = Utils.random(10)
    if picker > 8 then
        message = "\n* "..target.chara:getNameOrYou().." didn't cry..."
    end
    return "* "..target.chara:getNameOrYou().." ate the Stoic Onion."..message
end

return item