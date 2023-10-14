local BG, super = Class(Sprite)

function BG:init()
    super.init(self, "world/maps/void", 0, 0)

    self:setScale(1)
    self:setParallax(0, 0)

    self.wrap_texture_x = true
    self.wrap_texture_y = true

    self.physics.speed_x = 1
    self.physics.speed_y = 1
end

return BG
