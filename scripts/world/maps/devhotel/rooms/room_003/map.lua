local Forest, super = Class(Map)

function Forest:onEnter()
	super.onEnter(self)
	if Game:getFlag("dungeonkiller") and Game.world:getEvent(28) then
		Game.world:getEvent(28):setActor("jamm_hurt")
	elseif Game:getFlag("jamm_party") and Game:getFlag("marcy_joined") then
		Game.world:getEvent(21):remove()
	end
end

return Forest