---@class PartyBattler : PartyBattler
---@overload fun(...) : PartyBattler
local PartyBattler, super = Class("PartyBattler", true)

function PartyBattler:init(chara, x, y)
	super:init(self, chara, x, y)
	
	self.shield = 0
	
	self.guard_chance = 0 -- out of 100
    for _,equipment in ipairs(self.chara:getEquipment()) do
        self.guard_chance = self.guard_chance + (equipment.bonuses.guard_chance or 0)
    end
	self.guard_mult = self.chara.guard_mult or 0.8
end

function PartyBattler:addShield(amount)
    Assets.stopAndPlaySound("metal")

    amount = math.floor(amount)

    self.shield = self.shield + amount

    local was_down = self.is_down
    self:checkHealth()

    self:flash()

    if self.shield >= self.chara:getMaxShield() then
        self.shield = self.chara:getMaxShield()
    else
        self:statusMessage("heal", amount, {128/255, 128/255, 128/255})
    end
end

function PartyBattler:breakShield()
    Assets.stopAndPlaySound("hurt")

    self.shield = 0
	
	self:setAnimation("battle/hurt")
	
	self:statusMessage("msg", "break")
end

function PartyBattler:removeHealth(amount, pierce)
    if (self.chara:getHealth() <= 0) then
        amount = Utils.round(amount / 4)
		if not pierce then
			if self.shield < amount then
				amount = amount - self.shield
				self.shield = 0
			else
				self.shield = self.shield - amount
				amount = 0
			end
		end
        self.chara:setHealth(self.chara:getHealth() - amount)
    else
		if not pierce then
			if self.shield < amount then
				amount = amount - self.shield
				self.shield = 0
			else
				self.shield = self.shield - amount
				amount = 0
			end
		end
        self.chara:setHealth(self.chara:getHealth() - amount)
        if (self.chara:getHealth() <= 0) then
            amount = math.abs((self.chara:getHealth() - (self.chara:getStat("health") / 2)))
            self.chara:setHealth(Utils.round(((-self.chara:getStat("health")) / 2)))
        end
    end
    self:checkHealth()
end

function PartyBattler:getHeadIcon()
    if self.is_down then
        return "head_down"
    elseif self.sleeping then
        return "sleep"
    elseif self.defending then
        return "defend"
    elseif self.action and self.action.icon then
        return self.action.icon
    elseif self.hurting then
        return "head_hurt"
	elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
		return "head_low"
    else
        return "head"
    end
end

function PartyBattler:setAnimation(animation, callback)
	if self.chara and (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) and animation == "battle/idle" and self.chara.actor:getAnimation("battle/low_health") then
		return self:setAnimation("battle/low_health", callback)
	end
    return self.sprite:setAnimation(animation, callback)
end

function PartyBattler:hurt(amount, exact, color, options)
	if love.math.random(1,100) < self.guard_chance then
		self:statusMessage("msg", "guard")
		amount = math.ceil(amount * self.guard_mult)
	end
	super:hurt(self, amount, exact, color, options)
	
	if (not self.defending) and (not self.is_down) then
		self.sleeping = false
		self.hurting = true
		self:toggleOverlay(true)
		self.overlay_sprite:setAnimation("battle/hurt", function()
			if self.hurting then
				self.hurting = false
				self:toggleOverlay(false)
			end
			
			if (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) and self.chara.actor:getAnimation("battle/low_health") then
				self:setAnimation("battle/low_health")
			end
		end)
		if not self.overlay_sprite.anim_frames then -- backup if the ID doesn't animate, so it doesn't get stuck with the hurt animation
			Game.battle.timer:after(0.5, function()
				if self.hurting then
					self.hurting = false
					self:toggleOverlay(false)
				end
			end)
		end
	end
end

function PartyBattler:pierce(amount, exact, color, options)
	if love.math.random(1,100) < self.guard_chance then
		self:statusMessage("msg", "guard")
		amount = math.ceil(amount * self.guard_mult)
	end
    options = options or {}

    if not options["all"] then
        Assets.playSound("hurt")
        if not exact then
            amount = self:calculateDamage(amount)
            if self.defending then
                amount = math.ceil((2 * amount) / 3)
            end
            -- we don't have elements right now
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))
        end

        self:removeHealth(amount, true)
    else
        -- We're targeting everyone.
        if not exact then
            amount = self:calculateDamage(amount)
            -- we don't have elements right now
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))

            if self.defending then
                amount = math.ceil((3 * amount) / 4) -- Slightly different than the above
            end

            self:removeHealth(amount, true) -- Use a separate function for cleanliness
        end
    end

    if (self.chara:getHealth() <= 0) then
        self:statusMessage("msg", "down", color, true)
    else
        self:statusMessage("damage", amount, color, true)
    end

    self.sprite.x = -10
    self.hurt_timer = 4
    Game.battle:shakeCamera(4)

    if (not self.defending) and (not self.is_down) then
		self.sleeping = false
		self.hurting = true
		self:toggleOverlay(true)
		self.overlay_sprite:setAnimation("battle/hurt", function()
			if self.hurting then
				self.hurting = false
				self:toggleOverlay(false)
			end
			
			if (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) and self.chara.actor:getAnimation("battle/low_health") then
				self:setAnimation("battle/low_health")
			end
		end)
		if not self.overlay_sprite.anim_frames then -- backup if the ID doesn't animate, so it doesn't get stuck with the hurt animation
			Game.battle.timer:after(0.5, function()
				if self.hurting then
					self.hurting = false
					self:toggleOverlay(false)
				end
			end)
		end
	end
end

return PartyBattler