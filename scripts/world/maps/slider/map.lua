local Slider, super = Class(Map)

function Slider:init(world, data)
	super:init(self, world, data)
	
	self.slide_time = 0
	self.slide_time_display = "00"
end

function Slider:update()
	super:update(self)
	
	if self.sliding then
		self.slide_time = self.slide_time + DT
		if Utils.round(self.slide_time) < 10 then
			self.slide_time_display = "0" .. Utils.round(Game.world.map.slide_time)
		else
			self.slide_time_display = Utils.round(Game.world.map.slide_time)
		end
	end
end

return Slider