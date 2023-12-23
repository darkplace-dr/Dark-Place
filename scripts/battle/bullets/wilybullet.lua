local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/smallbullet")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	
	self.supertimer = 0
	
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
	
	self.x = self.x + math.cos(self.supertimer / 2) * self.physics.speed * 0.3
	self.y = self.y + math.sin(self.supertimer / 2) * self.physics.speed * 0.3
	
	self.supertimer = self.supertimer + 1
	
	self.physics.speed = self.physics.speed * 1.05
	
    super.update(self)
end

return SmallBullet