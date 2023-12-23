local SpaceBG, super = Class(Sprite)

function SpaceBG:init()
    super.init(self, "world/maps/labfog", 0, 0)

    self.wrap_texture_x = true
    self.wrap_texture_y = true
    self:setScale(2)
	
    self.alpha = 0.5

    self:setParallax(1, 0)

    self.physics.speed_x = 0.5
    self.physics.speed_y = 0.5
    self.debug_select = false
end

return SpaceBG
