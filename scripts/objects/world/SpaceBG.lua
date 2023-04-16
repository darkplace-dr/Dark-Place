local SpaceBG, super = Class(Object)

function SpaceBG:init()
    super.init(self)

    self.parallax_x = 0
    self.parallax_y = 0

    local background = Sprite("objects/spacebg", 0, 0)
    background.wrap_texture_x = true
    background:setScale(1)
    background.physics.speed_x = 0.3
    self:addChild(background)
    self.layer = WORLD_LAYERS["bottom"]
end

return SpaceBG