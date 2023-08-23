local TimeVortex, super = Class(Event)


function TimeVortex:init(x, y, width, height, properties)
    super.init(self, x, y, width, height)

--function TimeVortex:init(data)
--    super.init(self, data.center_x, data.center_y, data.width, data.height)

    properties = properties or {}

    self.solid = true

    self:setOrigin(0.5, 0.5)
    self:setSprite("timevortex")
end


return TimeVortex