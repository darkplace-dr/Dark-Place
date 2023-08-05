return function(script, chara)
	if Game:getFlag("glitch_oob") == "step1" then
		Game:setFlag("glitch_oob", nil)
		Game:addFlag("nb_bonk", 1)
		print(Game:getFlag("nb_bonk", "NaN"))
		for i=1,1+Game:getFlag("nb_bonk", 0) do
			print("loop #"..i)
			if Utils.random(0, 10) <= 3 then
				print("Passed")
				Game.world.map:setTile(Utils.pick({58, 59, 60}), Utils.pick({15, 16}), love.math.random(0, 924))
			end
		end
	end
end

--x=58-60
--y=15-16