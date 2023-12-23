local Forest, super = Class(Map)

function Forest:onEnter()
	super.onEnter(self)
	if Game:getFlag("dungeonkiller") and Game.world:getEvent(28) then
		Game.world:getEvent(28):setActor("jamm_hurt")
	end
end

return Forest