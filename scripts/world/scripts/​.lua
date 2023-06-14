return function(script, chara)
	if Game:getFlag("finish") then
		Game.world.map.back = true
		for i=#Game.world.map.collision, 1, -1 do
			table.remove(Game.world.map.collision, i)
		end
		local mb = Game.world:getEvent(10)
		mb:setHitbox(0, 0, mb.width, mb.height)
		Game.world.camera.keep_in_bounds = false
		script:remove()
		return
	end
	if Game:getFlag("loop", 0) < 10 then
		local x, _ = Game.world.map:getMarker("restart")
		chara:setPosition(x, chara.y)
		Game:addFlag("loop", 1)
	end
end