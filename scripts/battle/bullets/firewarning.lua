local FireWarning, super = Class(Bullet)

function FireWarning:init(x, y, dir, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/firewarning")

	self:setScale(1, 1)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	self.collider = nil
end

function FireWarning:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

return FireWarning
