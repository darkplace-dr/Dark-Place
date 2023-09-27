local LaserCircle, super = Class(Bullet, "werewire/laser_circle")

function LaserCircle:init(x, y, length, speed, accel, angle, spin)
    super:init(self, x, y, "bullets/werewire/laser_circle")

    self:setScale(0, 0)

    self.collidable = false

    self.tp = 0.4

    -- GROW, SHOOT, SHRINK
    self.state = "GROW"

    self.siner = 0
    self.timer = 0

    self.speed = speed or 4
    self.accel = accel or 0
    self.angle = angle or math.rad(180)
    self.spin = spin or 0

    self.length = length or 1
    self.length_used = 0
end

function LaserCircle:update()
    self.siner = self.siner + 0.5 * DTMULT
    self.timer = self.timer + DTMULT

    if self.state == "GROW" then
        self.scale_x = Utils.approach(self.scale_x, 1.6, 0.8 * DTMULT)
        self.scale_y = Utils.approach(self.scale_y, 1.6, 0.8 * DTMULT)

        if self.timer >= 3 then
            self.timer = self.timer - 3
            self:setScale(1.6, 1.6)
            self.state = "SHOOT"
        end
    elseif self.state == "SHOOT" then
        while math.min(math.ceil(self.timer), self.length) > self.length_used do
            local laser = self.wave:spawnBulletTo(self.parent, "werewire/laser_square", self.x, self.y, self.speed, self.accel, self.angle, self.spin)
            laser.attacker = self.attacker
            laser.tp = self.tp
            laser:setLayer(self.layer - 0.01)

            self.length_used = self.length_used + 1
        end
        self.scale_x = self.scale_x - (math.sin(self.siner * 2.6) * 0.2 * DTMULT)
        self.scale_y = self.scale_y - (math.sin(self.siner * 2.6) * 0.2 * DTMULT)

        if self.timer >= self.length then
            self.timer = self.timer - self.length
            self.state = "SHRINK"
        end
    elseif self.state == "SHRINK" then
        self.scale_x = Utils.approach(self.scale_x, 0, 0.1 * DTMULT)
        self.scale_y = Utils.approach(self.scale_y, 0, 0.1 * DTMULT)

        if self.scale_x == 0 and self.scale_y == 0 then
            self:remove()
            return
        end
    end

    super:update(self)
end

return LaserCircle