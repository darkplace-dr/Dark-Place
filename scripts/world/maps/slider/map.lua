local Slider, super = Class(Map)

function Slider:init(world, data)
	super:init(self, world, data)
	
	self.slide_time = 0
end

function Slider:update()
	super:update(self)
	
	if self.sliding then
		self.slide_time = self.slide_time + DT
	end
end

return Slider