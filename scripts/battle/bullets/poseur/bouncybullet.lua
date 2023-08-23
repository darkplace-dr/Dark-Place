local BouncyBullet, super = Class(Bullet)

function BouncyBullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/poseurbullet")
    self:setScale(1, 1)

    self.destroy_on_hit = false

    -- very unfortature
    self.velocity_x = 1 - 2*Utils.random()
    self.velocity_y = 0
end

function BouncyBullet:update()
    local dtmult60 = DT * 60

    local new_x = self.x + self.velocity_x * dtmult60
    local new_y = self.y - self.velocity_y * dtmult60
    if (self.x > Game.battle.arena.left and self.x < Game.battle.arena.right)
        and (self.y > Game.battle.arena.bottom - 8) then
        new_y = Game.battle.arena.bottom - 8
        self.velocity_y = 4
    end
    self.velocity_y = self.velocity_y - (0.04 * dtmult60)
    self:setPosition(new_x, new_y)

    super.update(self)
end

return BouncyBullet