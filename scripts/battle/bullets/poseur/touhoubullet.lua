local TouhouBullet, super = Class(Bullet)

function TouhouBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/poseurbullet")
    self:setScale(1, 1)

    self.destroy_on_hit = false
    self.remove_offscreen = true

    self.timer = 0
    self.offset = 0
    self.neg = 1
    self.negmult = 0
	self.lerp = 0
end

function TouhouBullet:update(dt)
    local posx = (70 * self.lerp) * math.sin(self.timer * self.negmult + self.offset)
    local posy = (70 * self.lerp) * math.cos(self.timer + self.offset) + (self.lerp * 50)
    self:move(posx * DTMULT, posy * DTMULT)
    self.timer = self.timer + (1/40 * DTMULT)
    self.lerp = Utils.approach(self.lerp, 4, 1/90 * DTMULT)

    super:update(self, dt)
end

return TouhouBullet
