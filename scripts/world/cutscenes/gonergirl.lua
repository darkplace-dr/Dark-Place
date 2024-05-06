return function(cutscene, event, player, dir)
	if event.girl == nil then
		cutscene:text("* (It's a chair.)")
	else
		cutscene:wait(cutscene:walkToSpeed(player, 390, 200))
		cutscene:look(player, "left")
		for i=1,3 do
			cutscene:wait(0.5)
			cutscene:showNametag("Girl")
			cutscene:text("* Am I real...?")
			cutscene:hideNametag()
		end
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
		cutscene:text("[voice:null][noskip][speed:0.4]* ワッテ　", {auto=true}) --アメ　アイ－?
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* Waッテ　[stopinstant]ア[wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* Watテ　[stopinstant]ア[wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* Watte　ア[stopinstant]メ[wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What　aメ[stopinstant]　ア[wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What ame　ア[stopinstant]イ[wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What am　aイ[stopinstant]－[wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What am　ai－?[stopinstant][wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What am aii?[stopinstant][wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What am I?[stopinstant][wait:1]", {auto=true})
		cutscene:text("[instant][voice:null][noskip][speed:0.4]* What am I?")
		cutscene:hideNametag()
		event.girl:remove()
		Assets.playSound("mysterygo")
		Game:setFlag("seen_gonergirl", true)
		event.girl = nil
	end
end