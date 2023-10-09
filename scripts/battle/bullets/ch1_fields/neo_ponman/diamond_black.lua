local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/rudinn/diamond_black")

    self.physics.speed = speed
    self.physics.direction = dir
	self.physics.match_rotation = true
end

function SmallBullet:update()
    super.update(self)
end

return SmallBullet