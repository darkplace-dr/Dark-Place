---@class PartyBattler
local PartyBattler, super = Class("PartyBattler", true)

function PartyBattler:init(chara, x, y)
	super.init(self, chara, x, y)
	
	self.super_flash = 0
end

function PartyBattler:removeHealth(amount)
	if not Game.battle.superpower then
		amount = amount * (BadgesLib:getBadgeEquipped("double_pain") + 1)
		amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)
		super.removeHealth(self, amount)
	end
end

function PartyBattler:removeHealthBroken(amount)
	if not Game.battle.superpower then
		amount = amount * (BadgesLib:getBadgeEquipped("double_pain") + 1)
		amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)
		super.removeHealth(self, amount)
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