local Bullet, super = Class(Bullet)

function Bullet:init(x, y, dir, speed)
    super.init(self, x, y, "battle/bullets/voidstar_huge")
	
    self.physics.direction = dir
    self.physics.speed = speed

    self.timer = 0
end

function Bullet:update()
    super.update(self)

    self.timer = self.timer + 1*DTMULT
    if self.timer >= 40 then
        Assets.stopAndPlaySound("explosion")
        for i = 1, 6 do
            local angle = math.rad(60*i)
            self.wave:spawnBullet("voidstar_big", self.x, self.y, angle, 4)
            self:remove()
        end
    end

    self.rotation = self.rotation - math.rad(4*DTMULT)
end

return Bullet