local SpinHeart, super = Class(Wave)

function SpinHeart:init()
    super.init(self)

    self.actual = true
    self.made = 0
end

function SpinHeart:onStart()
end

function SpinHeart:update()
    super.update(self)

    if self.actual == true then
        if self.made == 0 then
            for i = 1, 16 do
                local bullet = self:spawnBullet("hathy/heartbullet", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
                bullet.alpha = 0
                bullet.index = i
                bullet.remove_offscreen = false
            end
            self.made = 1
        end
    end
end

return SpinHeart