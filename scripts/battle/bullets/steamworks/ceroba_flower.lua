local CerobaFlower, super = Class(Bullet)

function CerobaFlower:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/ceroba/flower")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.destroy_on_hit = false
    self.sprite:setAnimation({"battle/bullets/ceroba/flower", 1/10, true})
    self:setScale(1, 1)
end

function CerobaFlower:update()

    super.update(self)
end

return CerobaFlower