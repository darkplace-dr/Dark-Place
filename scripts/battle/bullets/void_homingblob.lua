local Bullet, super = Class(Bullet)

function Bullet:init(x, y, dir, speed)
    super.init(self, x, y, "battle/bullets/void_homingblob")

    self.physics.direction = dir
    self.physics.speed = speed

    -- Don't mind me just shamelessly stealing this code from Vitellary
    self.physics.speed_x = speed*math.cos(dir)
    self.physics.speed_y = speed*math.cos(dir)
end

function Bullet:update()
    -- Sorry Vitellary :c
    local soul = Game.battle.soul
    local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.speed_x = Utils.approach(self.physics.speed_x, 8*math.cos(angle), 0.25*DTMULT)
    self.physics.speed_y = Utils.approach(self.physics.speed_y, 8*math.sin(angle), 0.25*DTMULT)
    self.rotation = Utils.approach(self.rotation, angle, 1*DTMULT)

    super.update(self)
end

return Bullet