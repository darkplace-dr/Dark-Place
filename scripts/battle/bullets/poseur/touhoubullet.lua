local TouhouBullet, super = Class(Bullet)

function TouhouBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/poseurbullet")
    self:setScale(1, 1)

    self.destroy_on_hit = false
    self.remove_offscreen = false

    self.timer = 0
    self.offset = 0
	
    self.negmult = 0
	self.lerp = 0
end

function TouhouBullet:update(dt)
    self.timer = self.timer
    self.offset = self.offset
    self.lerp = self.lerp
    self.neg = 1
    -- For more complicated bullet behaviours, code here gets called every update
    local posx = (70 * self.lerp) * math.sin(self.timer * self.negmult + self.offset)
    local posy = (70 * self.lerp) * math.cos(self.timer + self.offset) + self.lerp * 50
    self:move(posx, posy)
    self.timer = self.timer + (1/40)*DTMULT

    self.lerp = self.lerp + (1/90)*DTMULT
	if self.lerp > 4 then
        self.lerp = 4
	end

    super:update(self, dt)
end

return TouhouBullet
