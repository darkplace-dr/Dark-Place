local Forest, super = Class(Map)

function Forest:init(world, data)
	super:init(self, world, data)
	if Game:getFlag("Route") == "Insanity" then
		self.music = "iforest"
	end
end

return Forest