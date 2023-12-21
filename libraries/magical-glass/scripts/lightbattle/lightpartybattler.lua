local LightPartyBattler, super = Class(Battler)

function LightPartyBattler:init(chara)
    self.chara = chara
    self.actor = chara:getActor()

    super.init(self, x, y, self.actor:getSize())

    self.action = nil

    self.defending = false
    self.hurting = false

    self.is_down = false
    self.sleeping = false

    self.targeted = false
end

function LightPartyBattler:canTarget()
    return (not self.is_down)
end

function LightPartyBattler:onTurnStart()
    if Game.battle.turn_count == 1 then
        self:onBattleStart()
    end
end

function LightPartyBattler:calculateDamage(amount, min, cap)
    local def = self.chara:getStat("defense")
    local max_hp = self.chara:getStat("health")

    -- good shit toby
--[[     if max_hp >= 90 then
        amount = amount + 1
    end
    if max_hp >= 80 then
        amount = amount + 1
    end
    if max_hp >= 70 then
        amount = amount + 1
    end
    if max_hp >= 60 then
        amount = amount + 1
    end
    if max_hp >= 50 then
        amount = amount + 1
    end
    if max_hp >= 40 then
        amount = amount + 1
    end
    if max_hp >= 30 then
        amount = amount + 1
    end
    if max_hp > 20 then
        amount = amount + 1
    end ]]

    for i = 21, math.min(max_hp, 99) do
        if i % 10 == 0 or i == 21 then
            amount = amount + 1
        end
    end
    amount = Utils.round((amount - def) / 5)
    
    if min and amount < min then
        amount = min
    end

    if cap and amount > cap then
        amount = cap
    end

    return math.max(amount, 1)
end

function LightPartyBattler:calculateDamageSimple(amount)
    return math.ceil(amount - (self.chara:getStat("defense")))
end

function LightPartyBattler:getElementReduction(element)
    -- TODO: this

    if (element == 0) then return 1 end

    local armor_elements = {
        {element = 0, element_reduce_amount = 0},
        {element = 0, element_reduce_amount = 0}
    }

    local reduction = 1
    for i = 1, 2 do
        local item = armor_elements[i]
        if (item.element ~= 0) then
            if (item.element == element)                              then reduction = reduction - item.element_reduce_amount end
            if (item.element == 9 and (element == 2 or element == 8)) then reduction = reduction - item.element_reduce_amount end
            if (item.element == 10)                                   then reduction = reduction - item.element_reduce_amount end
        end
    end
    return math.max(0.25, reduction)
end

function LightPartyBattler:hurt(amount, exact, color, options)
    options = options or {}

    if not options["all"] then
        Assets.playSound("hurt")
        if not exact then
            amount = self:calculateDamage(amount)
            if self.defending then
                amount = math.ceil((2 * amount) / 3)
            end
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))
        end

        self:removeHealth(amount)
    else
        if not exact then
            amount = self:calculateDamage(amount)
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))

            if self.defending then
                amount = math.ceil((3 * amount) / 4)
            end

            self:removeHealthBroken(amount)
        end
    end

    Game.battle:shakeCamera(2)
end

function LightPartyBattler:removeHealth(amount)
    if (self.chara:getHealth() <= 0) then
        amount = Utils.round(amount / 4)
        self.chara:setHealth(self.chara:getHealth() - amount)
    else
        self.chara:setHealth(self.chara:getHealth() - amount)
        if (self.chara:getHealth() <= 0) then
            amount = math.abs((self.chara:getHealth() - (self.chara:getStat("health") / 2)))
            self.chara:setHealth(Utils.round(((-self.chara:getStat("health")) / 2)))
        end
    end
    self:checkHealth()
end

function LightPartyBattler:removeHealthBroken(amount)
    self.chara:setHealth(self.chara:getHealth() - amount)
    if (self.chara:getHealth() <= 0) then
        -- BUG: Use Kris' max health...
        self.chara:setHealth(Utils.round(((-Game.party[1]:getStat("health")) / 2)))
    end
    self:checkHealth()
end

function LightPartyBattler:down()
    self.is_down = true
    self.sleeping = false
    if self.action then
        Game.battle:removeAction(Game.battle:getPartyIndex(self.chara.id))
    end
    Game.battle:checkGameOver()
end

function LightPartyBattler:setSleeping(sleeping)
    if self.sleeping == (sleeping or false) then return end

    if sleeping then
        if self.is_down then return end
        self.sleeping = true
        self:toggleOverlay(true)
        if self.action then
            Game.battle:removeAction(Game.battle:getPartyIndex(self.chara.id))
        end
    else
        self.sleeping = false
        self:toggleOverlay(false)
    end
end

function LightPartyBattler:revive()
    self.is_down = false
    self:toggleOverlay(false)
end

function LightPartyBattler:heal(amount, show_up, sound)
    if sound then
        Assets.stopAndPlaySound("power")
    end

    amount = math.floor(amount)

    if self.chara:getHealth() < self.chara:getStat("health") then
        self.chara:setHealth(math.min(self.chara:getStat("health"), self.chara:getHealth() + amount))
    end

    local was_down = self.is_down
    self:checkHealth()
end

function LightPartyBattler:checkHealth()
    if (not self.is_down) and self.chara:getHealth() <= 0 then
        self:down()
    elseif (self.is_down) and self.chara:getHealth() > 0 then
        self:revive()
    end
end

function LightPartyBattler:statusMessage(...)
    local message = super.statusMessage(self, 0, self.height/2, ...)
    message.y = message.y - 4
    return message
end

function LightPartyBattler:recruitMessage(...)
    return super.recruitMessage(self, ...)
end

function LightPartyBattler:isActive()
    return not self.is_down and not self.sleeping
end

function LightPartyBattler:isTargeted()
    return self.targeted
end

function LightPartyBattler:getHeadIcon()
    if self.sleeping then
        return "sleep"
    elseif self.defending then
        return "defend"
    elseif self.action and self.action.icon then
        return self.action.icon
    elseif self.hurting then
        return "head_hurt"
    else
        return "head"
    end
end

function LightPartyBattler:resetSprite() end

function LightPartyBattler:update()
    if self.actor then
        self.actor:onBattleUpdate(self)
    end

    if self.chara:getWeapon() then
        self.chara:getWeapon():onBattleUpdate(self)
    end
    for i = 1, 2 do
        if self.chara:getArmor(i) then
            self.chara:getArmor(i):onBattleUpdate(self)
        end
    end

    super.update(self)
end

return LightPartyBattler