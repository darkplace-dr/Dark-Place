local TouhouBullet, super = Class(Bullet)

function TouhouBullet:init(x, y, y_offset)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/poseurbullet")
    self:setScale(1, 1)

    self.destroy_on_hit = false
    self.remove_offscreen = true

    self.y_offset = y_offset
    self.timer = 0
    self.offset = 0
	self.lerp = 0
    self.negmult = 0
end

function TouhouBullet:update()
    local dtmult60 = DT * 60

    local posx = (70 * self.lerp) * math.sin(self.timer * self.negmult + self.offset)
    local posy = (70 * self.lerp) * math.cos(self.timer + self.offset) + self.y_offset - self.lerp * 50
    self:setPosition(Game.battle.arena.x + posx, Game.battle.arena.y - posy)
    self.timer = self.timer + 1/40 * dtmult60
    self.lerp = Utils.approach(self.lerp, 4, 1/90 * dtmult60)

    super.update(self)
end

return TouhouBullet
