local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/eggman/drop_spike")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	
	self.destroy_on_hit = false
	self.remove_offscreen = false
	
	self:setOrigin(0.5,1)
	self:setScale(1)
end

function SmallBullet:update()
	-- For more complicated bullet behaviours, code here gets called every update
	super.update(self)

	if self.y > Game.battle.arena:getBottom() - 37 then
		for _,solid in ipairs(Game.stage:getObjects(Solid)) do
			if solid:collidesWith(self) then
				solid:remove()
			end
		end
	end
end

return SmallBullet