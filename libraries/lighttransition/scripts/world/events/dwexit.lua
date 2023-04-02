local DWExit, super = Class(Event)

function DWExit:init(data)
    super:init(self, data.x, data.y, data.width, data.height)

    local t = LightTransition(0, 0, data.properties)
	self:addChild(t)
	
	self.light = t
end

return DWExit