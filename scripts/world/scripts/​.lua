return function(script, chara)
	if Game.world.map.back then script:remove() return end
	if Game:getFlag("finish") then
		Game.world.map:casuallyApproachChild()
		script:remove()
		return
	end
	if Game:getFlag("loop", 0) < 5 then
		local x, _ = Game.world.map:getMarker("restart")
		chara:setPosition(x, chara.y)
		Game:addFlag("loop", 1)
	end
end