local map, super = Class(Map)

function map:onEnter()
	super.onEnter(self)

	if (Game:getFlag("fun", 0) >= 13 and Game:getFlag("fun", 0) <= 15) and not Game:getFlag("met_strange_girl", false) then
		local elevator_marker_x, elevator_marker_y = self:getMarker("entry_elevator")
		if Utils.dist(Game.world.player.x, Game.world.player.y, elevator_marker_x, elevator_marker_y) <= 5 then
			Game.world:startCutscene("floor3.elevator_strange")
		end
	end
end

return map