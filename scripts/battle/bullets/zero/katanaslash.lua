local KatanaSlash, super = Class(Bullet)

function KatanaSlash:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/zero/KatanaSlash")
    self.flip_x = true
    self:setScale(1,1)
    self:setOrigin(0.5,0.5)
    self:setSprite("battle/bullets/zero/KatanaSlash", 1/15, false, function ()
        self:remove()
    end)
    Assets.playSound("zero/normal_slash_" .. math.ceil(Utils.random(3)))
    self.collider = Hitbox(self, 20, 4, 69, 19) -- Eh, good enough


    self.destroy_on_hit = false

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function KatanaSlash:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return KatanaSlash