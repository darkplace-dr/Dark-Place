return function(cutscene, event, player, dir)
	if event.girl == nil then
		cutscene:text("* (It's a chair.)")
	else
		cutscene:wait(cutscene:walkTo(player, 390, 200))
		cutscene:look(player, "left")
		cutscene:wait(0.5)
		cutscene:showNametag("Girl")
		cutscene:text("* Am I real...?")
		cutscene:hideNametag()
		cutscene:wait(0.5)
		cutscene:showNametag("Girl")
		cutscene:text("* Am I real...?")
		cutscene:hideNametag()
		cutscene:wait(0.5)
		cutscene:showNametag("Girl")
		cutscene:text("* Am I real...?")
		cutscene:hideNametag()
		local c = cutscene:choicer({"Yes", "No"})
		while c==2 do
			cutscene:showNametag("Girl")
			cutscene:text("* Am I real...?")
			cutscene:hideNametag()
			c = cutscene:choicer({"Yes", "No"})
		end
		event.girl:setAnimation({"world/npcs/gonergirl/lower_hands", 0.3, false})
		cutscene:wait(function()
			return not event.girl.playing
		end)
		cutscene:wait(1)
		cutscene:showNametag("Girl")
		cutscene:text("* Then...")
		cutscene:hideNametag()
		cutscene:wait(2)
		event.girl:setAnimation({"world/npcs/gonergirl/reveal", 0.6, false})
		cutscene:wait(function()
			return not event.girl.playing
		end)
		cutscene:wait(2)
		cutscene:showNametag("      ")
		cutscene:text("[voice:null][noskip][speed:0.8]* What am I?")
		cutscene:hideNametag()
		event.girl:remove()
		Assets.playSound("mysterygo")
		event.girl = nil
	end
end