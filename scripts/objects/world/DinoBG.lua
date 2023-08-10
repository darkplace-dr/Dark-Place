local DinoBG, super = Class(Object)

function DinoBG:init()
    super.init(self)
	
    self.parallax_x = 0
    self.parallax_y = 0

    local sky = Rectangle(0, 0, 640, 480)
    sky:setColor({1, 1, 1})
    sky.wrap_texture_x = true
    sky:setScale(2)
    self:addChild(sky)
end

return DinoBG
