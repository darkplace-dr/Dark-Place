local item, super = Class(HealItem, "ut_items/bad_memory")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Bad Memory"
    self.short_name = "BadMemory"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "consume"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "consumes"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 300
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "?????"

    -- Light world check text
    self.check = "Hurts 1 HP\n* ?????"

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
    if hurt then
        return "* "..target:getNameOrYou().." "..self:getUseMethod(target).." the Bad Memory.\n* "..target:getNameOrYou().." lost 1HP."
    else
        return "* "..target:getNameOrYou().." "..self:getUseMethod(target).." the Bad Memory.\n"..self:getLightWorldHealingText(target)
    end
end

function item:onWorldUse(target)
    if target:getHealth() <= 2 then
        target:setHealth(target:getStat("health"))
        self:worldUseSound(target, false)
        Game.world:showText(self:getWorldUseText(target, true))
    else
        target:setHealth(target:getHealth() - 1)
        self:worldUseSound(target, true)
        Game.world:showText(self:getWorldUseText(target, true))
    end
end

function item:getLightBattleText(user, target, hurt)
    if hurt then
        return "* "..target.chara:getNameOrYou().." "..self:getUseMethod(target.chara).." the Bad Memory.\n* "..target.chara:getNameOrYou().." lost 1HP."
    else
        return "* "..target.chara:getNameOrYou().." "..self:getUseMethod(target.chara).." the Bad Memory.\n"..self:getLightBattleHealingText(user, target, self:getBattleHealAmount(target.chara.id))
    end
end

function item:onLightBattleUse(user, target)
    if target.chara:getHealth() <= 2 then
        target.chara:setHealth(target.chara:getStat("health"))
        self:battleUseSound(user, target, false)
        Game.battle:battleText(self:getLightBattleText(user, target, false))
    else
        target.chara:setHealth(target.chara:getHealth() - 1)
        self:battleUseSound(user, target, true)
        Game.battle:battleText(self:getLightBattleText(user, target, true))
    end
    return true
end

function item:onBattleUse(user, target)
    if target.chara:getHealth() <= 2 then
        target:heal(math.huge)
    else
        target.chara:setHealth(target.chara:getHealth() - 1)
        Assets.stopAndPlaySound("hurt")
    end
    return true
end

function item:battleUseSound(user, target, hurt)
    Game.battle.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        if hurt then
            Assets.stopAndPlaySound("hurt")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

function item:worldUseSound(target, hurt)
    Game.world.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        if hurt then
            Assets.stopAndPlaySound("hurt")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

return item