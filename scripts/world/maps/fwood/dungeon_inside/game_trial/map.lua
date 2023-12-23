local Forest, super = Class(Map)

function Forest:onEnter()
	super.onEnter(self)
	local layer = Game.world.map:getTileLayer("door_layer")
	local shape = Game.world.map:getHitbox("door_collision")
	if Game:getFlag("acj_game_win") then
		shape.collidable = false
		layer.visible = false
	end
end

return Forest