local item, super = Class(HealItem, "ut_items/butterscotch_pie")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Butterscotch Pie"
    self.short_name = "ButtsPie"
    self.serious_name = "Pie"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 180
    -- Whether the item can be sold
    self.can_sell = true

    -- Light world check text
    self.check = "All HP\n* Butterscotch-cinnamon\npie,[wait:10] one slice."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
end

function item:onWorldUse(target)
    self:worldUseSound(target)
    target:setHealth(target:getStat("health"))
    Game.world:showText(self:getLightWorldHealingText(target).."\n"..self:getLightWorldHealingText(target))
    return true
end

function item:onLightBattleUse(user, target)
    self:battleUseSound(user, target)
    if self.target == "ally" then
        target.chara:setHealth(target.chara:getStat("health"))
    elseif self.target == "enemy" then
        target:heal(target.max_health)
    end
    Game.battle:battleText(self:getLightBattleText(user, target).."\n"..self:getLightBattleHealingText(user, target))
    return true
end

return item