local item, super = Class(HealItem, "ut_items/monster_candy")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Monster Candy"
    self.short_name = "MnstrCndy"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 10

    -- Default shop sell price
    self.sell_price = 25
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Has a distinct, non licorice flavor."

    -- Light world check text
    self.check = "Heals 10 HP\n* Has a distinct,[wait:10]\nnon licorice flavor."

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
    if not MagicalGlassLib.serious_mode then
        local picker = Utils.random(15)
        if picker == 15 then
            message = "\n* ... tastes like licorice."
        end

        if picker <= 2 then
            message = "\n* Very un-licorice-like."
        end
    end

    return "* " .. target:getNameOrYou() .. " ate the Monster Candy."..message
end

function item:getLightBattleText(user, target)
    local message = ""
    if not MagicalGlassLib.serious_mode then
        local picker = Utils.random(15)
        if picker == 15 then
            message = "\n* ... tastes like licorice."
        end

        if picker <= 2 then
            message = "\n* Very un-licorice-like."
        end
    end

    return "* " .. target.chara:getNameOrYou() .. " ate the Monster Candy."..message
end

return item