local item, super = Class(HealItem, "ut_items/dog_salad")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Dog Salad"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 8
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(Hit Poodles.)"

    -- Light world check text
    self.check = "Heals ?? HP\n* Recovers HP.\n* (Hit Poodles.)"

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

-- welcome to the most poorly coded item in the library
-- honestly, fitting considering it's a toby reference

function item:battleUseSound(user, target)
    Game.battle.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        if not MagicalGlassLib.serious_mode then
            Assets.stopAndPlaySound("dogresidue")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

function item:worldUseSound(target)
    Game.world.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        if not MagicalGlassLib.serious_mode then
            Assets.stopAndPlaySound("dogresidue")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

function item:onWorldUse(target)
    local amount = 1
    local dogsad = math.floor(Utils.random(4))
    local text = self:getWorldUseText(target, dogsad)

    if dogsad == 0 then
        amount = 30
    end
    if dogsad == 1 then
        amount = 10
    end
    if dogsad == 2 then
        amount = 2
    end
    if dogsad == 3 then
        self.heal_amount = math.huge
    end

    if self.target == "ally" then
        self:worldUseSound(target)
        amount = amount
        Game.world:heal(target, amount, text, self)
        return true
    elseif self.target == "party" then
        self:worldUseSound(target)
        for _,party_member in ipairs(target) do
            amount = amount
            Game.world:heal(party_member, amount, text, self)
        end
        return true
    else
        return false
    end
end

function item:getWorldUseText(target, dogsad)
    local message = ""
    if dogsad == 0 then
        message = "\n* Oh.[wait:10] Tastes yappy..."
    end
    if dogsad == 1 then
        message = "\n* Oh.[wait:10] Fried tennis ball..."
    end
    if dogsad == 2 then
        message = "\n* Oh.[wait:10] There are bones..."
    end
    if dogsad == 3 then
        message = "\n* It's literally garbage???"
    end
    return "* " ..target:getNameOrYou().." "..self:getUseMethod(target).." the Dog Salad."..message
end

function item:getLightBattleText(user, target, dogsad)
    local message
    if dogsad == 0 then
        message = "\n* Oh.[wait:10] Tastes yappy..."
    end
    if dogsad == 1 then
        message = "\n* Oh.[wait:10] Fried tennis ball..."
    end
    if dogsad == 2 then
        message = "\n* Oh.[wait:10] There are bones..."
    end
    if dogsad == 3 then
        message = "\n* It's literally garbage???" -- noelle quote, probably
    end
    
    return "* " ..target.chara:getNameOrYou().." "..self:getUseMethod(target.chara).." the Dog Salad."..message
end

function item:onLightBattleUse(user, target)
    local dogsad = math.floor(Utils.random(4))

    self.heal_amount = 1

    if dogsad == 0 then
        self.heal_amount = 30
    end
    if dogsad == 1 then
        self.heal_amount = 10
    end
    if dogsad == 2 then
        self.heal_amount = 2
    end
    if dogsad == 3 then
        self.heal_amount = math.huge
    end

    self:battleUseSound(user, target)
    target:heal(self:getHealAmount())
    Game.battle:battleText(self:getLightBattleText(user, target, dogsad).."\n"..self:getLightBattleHealingText(user, target, self:getHealAmount()))
    return true
end

function item:onBattleUse(user, target)
    local dogsad = math.floor(Utils.random(4))

    self.heal_amount = 1

    if dogsad == 0 then
        self.heal_amount = 30
    end
    if dogsad == 1 then
        self.heal_amount = 10
    end
    if dogsad == 2 then
        self.heal_amount = 2
    end
    if dogsad == 3 then
        self.heal_amount = math.huge
    end

    if not MagicalGlassLib.serious_mode then
        Assets.stopAndPlaySound("dogresidue")
    end
    target:heal(self:getHealAmount())
    return true
end

return item