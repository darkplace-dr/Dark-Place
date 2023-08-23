return function(script, chara)
	if Game:getFlag("glitch_oob") == "step1" then
		Game:setFlag("glitch_oob", nil)
		Game:addFlag("nb_bonk", 1)
		for i=1,1+Game:getFlag("nb_bonk", 0) do
			if Utils.random(0, 10) <= 3 then
				Game.world.map:setTile(Utils.pick({32, 33, 34}), Utils.pick({15, 16}), love.math.random(0, 924))
			end
		end
	end
end

--x=58-60
--y=15-16