local Bullet, super = Class(Bullet)

function Bullet:init(x, y, dir, speed)
    super.init(self, x, y, "battle/bullets/voidstar_big")
	
    self.physics.direction = dir
    self.physics.speed = speed

    self.timer = 0
end

function Bullet:update()
    super.update(self)

    self.timer = self.timer + 1*DTMULT
    if self.timer >= 30 then
        Assets.stopAndPlaySound("bomb")
        for i = 1, 8 do
            local angle = math.rad(45*i)
            self.wave:spawnBullet("voidstar", self.x, self.y, angle, 5)
            self:remove()
        end
    end

    self.rotation = self.rotation - math.rad(5*DTMULT)
end

return Bullet