---@class PartyBattler
local PartyBattler, super = Class("PartyBattler", true)

function PartyBattler:init(chara, x, y)
	super.init(self, chara, x, y)
	
	self.super_flash = 0
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
	if not Game.battle.superpower then
		amount = amount * (BadgesLib:getBadgeEquipped("double_pain") + 1)
		amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)
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
end

function PartyBattler:removeHealthBroken(amount)
	if not Game.battle.superpower then
		amount = amount * (BadgesLib:getBadgeEquipped("double_pain") + 1)
		amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)
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
end

function PartyBattler:update()
	super.update(self)
	
	if Game.battle.superpower then
		if (self.super_flash - (DT * 30))%30 > self.super_flash%30 then
			self:sparkle(unpack({1, 1, 1}))
		end
		
		self.super_flash = self.super_flash + DT * 30
	end
end

return PartyBattler