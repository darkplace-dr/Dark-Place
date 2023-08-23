---@class Bullet
local Bullet, super = Class("Bullet", true)

function Bullet:onCollide(soul)
    if not Game.battle.superpower then
		super.onCollide(self, soul)
	end
end

return Bullet