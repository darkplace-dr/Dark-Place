local Forest, super = Class(Map)

function Forest:init(world, data)
	super:init(self, world, data)
	if Game:getFlag("Route") == "Insanity" then
		self.music = "iforest"
	end
end

function Forest:onEnter()
	super:onEnter(self)
	local shape = Game.world.map:getHitbox("postcs")
	if not Game:getFlag("forest_fall") then
		shape.collidable = false
	end
end

return Forest