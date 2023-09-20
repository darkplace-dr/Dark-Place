---@class Bullet
local Bullet, super = Class("Bullet", true)

function Bullet:init(x, y, texture)
	super:init(self, x, y, texture)
	
	self.pierce = false
end

function Bullet:onCollide(soul)
    if not Game.battle.superpower then
		super.onCollide(self, soul)
	end
end

function Bullet:onDamage(soul)
    local damage = self:getDamage()
    if damage > 0 then
		if not self.pierce then
			local battlers = Game.battle:hurt(damage, false, self:getTarget())
			soul.inv_timer = self.inv_timer
			soul:onDamage(self, damage)
			return battlers
		end
		Game.battle:pierce(damage, false, self:getTarget())
		soul.inv_timer = self.inv_timer
		soul:onDamage(self, damage)
    end
    return {}
end

return Bullet
