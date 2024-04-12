local HealItem, super = Class("HealItem", false)

function HealItem:onWorldUse(target)
    local text = self:getWorldUseText(target)
    if self.target == "ally" then
        self:worldUseSound(target)
        local amount = self:getWorldHealAmount(target.id)
        for _,member in ipairs(Game.party) do
            for _,equip in ipairs(member:getEquipment()) do
                if equip.applyHealBonus then
                    amount = equip:applyHealBonus(amount)
                end
            end
        end
        Game.world:heal(target, amount, text, self)
        return true
    elseif self.target == "party" then
        self:worldUseSound(target)
        for _,party_member in ipairs(target) do
            local amount = self:getWorldHealAmount(party_member.id)
            for _,member in ipairs(Game.party) do
                for _,equip in ipairs(member:getEquipment()) do
                    if equip.applyHealBonus then
                        amount = equip:applyHealBonus(amount)
                    end
                end
            end
            Game.world:heal(party_member, amount, text, self)
        end
        return true
    else
        return false
    end
end

function HealItem:onLightBattleUse(user, target)
    local text = self:getLightBattleText(user, target)

    if self.target == "ally" then
        self:battleUseSound(user, target)
        local amount = self:getBattleHealAmount(target.chara.id)

        for _,equip in ipairs(user.chara:getEquipment()) do
            if equip.applyHealBonus then
                amount = equip:applyHealBonus(amount)
            end
        end

        target:heal(amount)
        text = text .. "\n" .. self:getLightBattleHealingText(user, target, amount)
        Game.battle:battleText(text)
        return true
    elseif self.target == "party" then
        self:battleUseSound(user, target)

        for _,battler in ipairs(target) do
            local amount = self:getBattleHealAmount(battler.chara.id)
            for _,equip in ipairs(user.chara:getEquipment()) do
                if equip.applyHealBonus then
                    amount = equip:applyHealBonus(amount)
                end
            end

            battler:heal(amount)
        end

        local amount = self:getBattleHealAmount(target[1].chara.id)
        text = text .. "\n" .. self:getLightBattleHealingText(user, target, amount)
        Game.battle:battleText(text)
        return true
    elseif self.target == "enemy" then
        local amount = self.heal_amount

        target:heal(amount)
        
        text = text .. "\n" .. self:getLightBattleHealingText(user, target, amount)
        Game.battle:battleText(text)
        return true
    elseif self.target == "enemies" then
        for _,enemy in ipairs(target) do
            local amount = self.heal_amount
            enemy:heal(amount)
        end
        
        local amount = self.heal_amount
        text = text .. "\n" .. self:getLightBattleHealingText(user, target, amount)
        Game.battle:battleText(text)
        return true
    else
        -- No target or enemy target (?), do nothing
        return false
    end
end

function HealItem:onBattleUse(user, target)
    if self.target == "ally" then
        -- Heal single party member
        local amount = self:getBattleHealAmount(target.chara.id)
        for _,equip in ipairs(user.chara:getEquipment()) do
            if equip.applyHealBonus then
                amount = equip:applyHealBonus(amount)
            end
        end
        target:heal(amount)
    elseif self.target == "party" then
        -- Heal all party members
        for _,battler in ipairs(target) do
            local amount = self:getBattleHealAmount(battler.chara.id)
            for _,equip in ipairs(user.chara:getEquipment()) do
                if equip.applyHealBonus then
                    amount = equip:applyHealBonus(amount)
                end
            end
            battler:heal(amount)
        end
    elseif self.target == "enemy" then
        -- Heal single enemy
        local amount = self:getBattleHealAmount(target.id)
        target:heal(amount)
    elseif self.target == "enemies" then
        -- Heal all enemies
        for _,enemy in ipairs(target) do
            local amount = self:getBattleHealAmount(enemy.id)
            enemy:heal(amount)
        end
    else
        -- No target, do nothing
    end
end

function HealItem:getLightBattleText(user, target)
    if self.target == "ally" then
        return "* " .. target.chara:getNameOrYou() .. " "..self:getUseMethod(target.chara).." the " .. self:getUseName() .. "."
    elseif self.target == "party" then
        if #Game.battle.party > 1 then
            return "* Everyone "..self:getUseMethod("other").." the " .. self:getUseName() .. "."
        else
            return "* You "..self:getUseMethod("self").." the " .. self:getUseName() .. "."
        end
    elseif self.target == "enemy" then
        return "* " .. target.name .. " "..self:getUseMethod("other").." the " .. self:getUseName() .. "."
    elseif self.target == "enemies" then
        return "* The enemies "..self:getUseMethod("other").." the " .. self:getUseName() .. "."
    end
end

function HealItem:getWorldUseText(target)
    if self.target == "ally" then
        return "* " .. target:getNameOrYou() .. " "..self:getUseMethod(target).." the " .. self:getUseName() .. "."
    elseif self.target == "party" then
        if #Game.party > 1 then
            return "* Everyone "..self:getUseMethod("other").." the " .. self:getUseName() .. "."
        else
            return "* You "..self:getUseMethod("self").." the " .. self:getUseName() .. "."
        end
    end
end

function HealItem:getLightBattleHealingText(user, target, amount)
    local maxed = false
    if self.target == "ally" then
        maxed = target.chara:getHealth() >= target.chara:getStat("health") or amount == math.huge
    elseif self.target == "enemy" then
        maxed = target.health >= target.max_health or amount == math.huge
    end
    local message = ""
    if self.target == "ally" then
        if target.chara.id == Game.battle.party[1].chara.id and maxed then
            message = "* Your HP was maxed out."
        elseif maxed then
            message = "* " .. target.chara:getNameOrYou() .. "'s HP was maxed out."
        else
            message = "* " .. target.chara:getNameOrYou() .. " recovered " .. amount .. " HP."
        end
    elseif self.target == "party" then
        if #Game.battle.party > 1 then
            message = "* Everyone recovered " .. amount .. " HP."
        else
            message = "* You recovered " .. amount .. " HP."
        end
    elseif self.target == "enemy" then
        if maxed then
            message = "* " .. target.name .. "'s HP was maxed out."
        else
            message = "* " .. target.name .. " recovered " .. amount .. " HP."
        end
    elseif self.target == "enemies" then
        message = "* The enemies recovered " .. amount .. " HP."
    end
    return message
end

function HealItem:getLightWorldHealingText(target, amount)
    local maxed = false

    if self.target == "ally" then
        maxed = target:getHealth() >= target:getStat("health")
    end

    local message
    if self.target == "ally" then
        if target.id == Game.party[1].id and maxed then
            message = "* Your HP was maxed out."
        elseif maxed then
            message = "* " .. target:getName() .. "'s HP was maxed out."
        else
            message = "* " .. target:getNameOrYou() .. " recovered " .. amount .. " HP."
        end
    elseif self.target == "party" then
        if #Game.party > 1 then
            message = "* Everyone recovered " .. amount .. " HP."
        else
            message = "* You recovered " .. amount .. " HP."
        end
    end
    return message
end

function HealItem:battleUseSound(user, target)
    Game.battle.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        Assets.stopAndPlaySound("power")
    end)
end

function HealItem:worldUseSound(target)
    if Game:isLight() then
        Game.world.timer:script(function(wait)
            Assets.stopAndPlaySound("swallow")
            wait(0.4)
            Assets.stopAndPlaySound("power")
        end)
    end
end

return HealItem