local SmallBullet_BH, super = Class(Bullet)

function SmallBullet_BH:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/smallbullet")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.physics.friction = -0.1
end

function SmallBullet_BH:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if self.y <= 50 then
        self:remove()
    end

    super.update(self)
end

return SmallBullet_BH