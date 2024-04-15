local Bullet, super = Class(Bullet)

function Bullet:init(x, y, dir, speed)
    super.init(self, x, y, "battle/bullets/voidstar")
	
    self.physics.direction = dir
    self.physics.speed = speed
end

function Bullet:update()
    super.update(self)

    self.rotation = self.rotation - math.rad(8*DTMULT)
end

return Bullet