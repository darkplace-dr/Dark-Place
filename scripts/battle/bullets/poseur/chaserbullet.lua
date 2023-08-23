local ChaserBullet, super = Class(Bullet)

function ChaserBullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/poseurbullet")
    self:setScale(1, 1)

    self.destroy_on_hit = false

    self.speed_x_ours = 0
    self.speed_y_ours = 0
end

function ChaserBullet:update()
    local dtmult60 = DT * 60

    local x_diff = Game.battle.soul.x - self.x
    local y_diff = Game.battle.soul.y - self.y
    self.speed_x_ours = self.speed_x_ours + (-self.speed_x_ours/2 + x_diff / 100) * dtmult60
    self.speed_y_ours = self.speed_y_ours + (-self.speed_y_ours/2 + y_diff / 100) * dtmult60
    self:move(self.speed_x_ours, self.speed_y_ours, dtmult60)

    super.update(self)
end

return ChaserBullet