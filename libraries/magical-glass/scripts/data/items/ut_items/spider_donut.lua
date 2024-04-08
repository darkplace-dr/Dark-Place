local item, super = Class(HealItem, "ut_items/spider_donut")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Spider Donut"
    self.short_name = "SpidrDont"
    self.serious_name = "SpidrDonut"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 12

    -- Default shop price (sell price is halved)
    self.price = 7
    -- Default shop sell price
    self.sell_price = 30
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A donut made with Spider Cider in the batter."

    -- Light world check text
    self.check = "Heals 12 HP\n* A donut made with Spider\nCider in the batter."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
end

function item:getLightBattleText(user, target)
    local message = ""
    if not MagicalGlassLib.serious_mode then
        local picker = Utils.random(10)
        if picker > 9 then
            message = "\n* Don't worry,[wait:10] Spider didn't."
        end
    end

    return "* " .. target.chara:getNameOrYou() .. " ate the Spider Donut."..message
end

return item