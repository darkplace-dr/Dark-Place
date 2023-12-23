local ArenaHazard, super = Class(Bullet)

function ArenaHazard:init(x, y, w, h)
    -- Last argument = sprite path
    super.init(self, x, y)

    -- Top-center origin point (will be rotated around it)
    self:setOrigin(0.5, 0)
	
	self:setHitbox(0,0,w,h)

    -- Don't destroy this bullet when it damages the player
    self.destroy_on_hit = false
	
	self.lifetime = 0
	
	self:setScale(1)
end

function ArenaHazard:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
	
	self.lifetime = self.lifetime + DTMULT
	if self.lifetime >= 2 then
		self:remove()
	end
end

return ArenaHazard