local item, super = Class(HealItem, "uty_items/gunpowder")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Gunpowder"
    --self.short_name = "ButtsPie"
    --self.serious_name = "Pie"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "ate"
    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.price = 40
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(The forbidden spice.)"

    -- Light world check text
    self.check = "Heals ??? HP\"\n* (The forbidden spice.)"

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
    target:setHealth(target:getStat("health"))
    Game.world:showText(self:getWorldUseText(target))
    return true
end

function item:getWorldUseText(target)
    if target.id == Game.party[1].id then
        return "* (You put the gunpowder in your\nmouth and nearly choke to\ndeath.)"
    else
        return "* ("..target:getName().." puts the gunpowder in their\nmouth and nearly chokes to\ndeath.)"
    end
end

function item:getLightBattleText(user, target)
    if target.chara.id == Game.battle.party[1].chara.id then
        return {
            "* (You put the gunpowder in your\nmouth and nearly choke to\ndeath.)",
            "* (...HP fully restored.)"
        }
    else
        return {
            "* ("..target.chara:getName().." puts the gunpowder in their\nmouth and nearly chokes to\ndeath.)",
            "* (...HP fully restored.)"
        }
    end
end

function item:onLightBattleUse(user, target)
    self:battleUseSound(user, target)
    if self.target == "ally" then
        target.chara:setHealth(target.chara:getStat("health"))
    elseif self.target == "enemy" then
        target:heal(target.max_health)
    end
    Game.battle:battleText(self:getLightBattleText(user, target))
    return true
end

function item:onBattleUse(user, target)
    target:heal(math.huge)
    return true
end

return item