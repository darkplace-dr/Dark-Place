local SpinHeart, super = Class(Wave)

function SpinHeart:init()
    super.init(self)

    self.actual = true
end

function SpinHeart:onStart()
    if self.actual then
        for i = 1, 16 do
            local bullet = self:spawnBullet("hathy/heartbullet", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
            bullet.alpha = 0
            bullet.index = i
            bullet.remove_offscreen = false
        end
    end
end

return SpinHeart