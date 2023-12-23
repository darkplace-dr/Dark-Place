local Forest, super = Class(Map)

function Forest:onEnter()
	super.onEnter(self)
	if Game:getFlag("dungeonkiller") then
		Game.world.music.pitch = 0.5
	end
end

return Forest