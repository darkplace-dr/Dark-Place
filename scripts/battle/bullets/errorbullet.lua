local ErrorBullet, super = Class(Bullet)

function ErrorBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/error")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function ErrorBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return ErrorBullet