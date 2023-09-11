---@class PartyBattler : PartyBattler
---@overload fun(...) : PartyBattler
local PartyBattler, super = Class("PartyBattler", true)

function PartyBattler:init(chara, x, y)
	super:init(self, chara, x, y)
	
	self.shield = 0
end

function PartyBattler:addShield(amount)
    Assets.stopAndPlaySound("metal")

    amount = math.floor(amount)

    self.shield = self.shield + amount

    local was_down = self.is_down
    self:checkHealth()

    self:flash()

    if self.shield >= self.chara:getStat("health") then
        self.shield = self.chara:getStat("health")
    else
        self:statusMessage("heal", amount, {128/255, 128/255, 128/255})
    end
end

function PartyBattler:removeHealth(amount)
    if (self.chara:getHealth() <= 0) then
        amount = Utils.round(amount / 4)
		if self.shield < amount then
			amount = amount - self.shield
			self.shield = 0
		else
			self.shield = self.shield - amount
			amount = 0
		end
        self.chara:setHealth(self.chara:getHealth() - amount)
    else
		if self.shield < amount then
			amount = amount - self.shield
			self.shield = 0
		else
			self.shield = self.shield - amount
			amount = 0
		end
        self.chara:setHealth(self.chara:getHealth() - amount)
        if (self.chara:getHealth() <= 0) then
            amount = math.abs((self.chara:getHealth() - (self.chara:getStat("health") / 2)))
            self.chara:setHealth(Utils.round(((-self.chara:getStat("health")) / 2)))
        end
    end
    self:checkHealth()
end

return PartyBattler