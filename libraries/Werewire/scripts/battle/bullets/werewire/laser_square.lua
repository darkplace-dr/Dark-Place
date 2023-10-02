local LaserSquare, super = Class(Bullet, "werewire/laser_square")

function LaserSquare:init(x, y, speed, accel, angle, spin)
    super:init(self, x, y, "bullets/werewire/laser_square")

    self:setScale(2, 1)

    self.rotation = angle or math.rad(180)
    self.physics.spin = spin or 0
    self.physics.match_rotation = true

    self.physics.speed = speed or 0
    self.physics.friction = -accel or 0

    self.destroy_on_hit = false

    self.stretch = true
end

function LaserSquare:update()
    if self.stretch then
        self.scale_x = 2 + (self.physics.speed / 20)
    end

    super:update(self)
end

return LaserSquare