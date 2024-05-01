local Slider, super = Class(Map)

function Slider:init(world, data)
	super.init(self, world, data)

	self.sliding = false
	self.slide_time = 0
end

function Slider:onEnter()
	super.onEnter(self)

	self.world:addChild(SliderHUD(self))
end

function Slider:update()
	if self.sliding then
		self.slide_time = self.slide_time + DT
	end

	super.update(self)
end

return Slider