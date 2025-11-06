local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/shade_hammer")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
	self.dx = math.cos(dir)
	self.dy = 4/3.5 * (math.sin(dir) - MathUtils.random(0, 0.6))
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
	self.x = self.x + (self.physics.speed * self.dx * DTMULT * 1.5)
	self.y = self.y + (self.physics.speed * self.dy * DTMULT * 1.5)
	self.dy = self.dy + 0.04 * DTMULT * 1.5
	self.rotation = self.rotation + 1 * DTMULT / 4
end

return SmallBullet