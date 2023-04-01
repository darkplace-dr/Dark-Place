return {
	moss = function(cutscene, event)
		local kris = cutscene:getCharacter("kris")
		local susie = cutscene:getCharacter("susie")
		local you = cutscene:getCharacter("YOU")
		local krisP = Game:getPartyMember("kris")
		local susieP = Game:getPartyMember("susie")
		local youP = Game:getPartyMember("YOU")

		if Game:getFlag("globalEatenMossFlag") == true then
			cutscene:text("* (Moss. There's not enough to eat.)")
		else
			Game.world.music:fade(0, 0.05)
			Game.world.music:pause()
			Assets.playSound("moss_fanfare")
			cutscene:text("[noskip:true]* You found the [color:green][Moss][color:white]![wait:3s]")
			Game.world.music:resume()
			Game.world.music:fade(1, 1)
			cutscene:text("* Your title was upgraded to [Moss Finder].")

			if kris and krisP then
				krisP.title = "Moss Finder\nBasic moss-finding\nabilities."
			end
			if you and youP then
				youP.title = "Moss Finder\nBasic moss-finding\nabilities."
			end
			if susie and susieP then
				if Game.party[1].id == "susie" then -- is Susie the party leader?
					susieP.title = "Moss Finder\nBasic moss-finding\nabilities."
				else
					susieP.title = "Moss Enjoyer\nSupports those that\nfind moss."
				end
				cutscene:showNametag("Susie")
				cutscene:setSpeaker("susie")
				cutscene:text("* Heck yeah, more moss!", "surprise_smile")
				cutscene:hideNametag()
			end

			Game.world.map:getEvent(37):remove()
			Game:setFlag("globalEatenMossFlag", true)
		end
	end,
	moss2 = function(cutscene, event)
		cutscene:text("* (Moss. There's not enough to eat.)")
	end,
	prefountain1 = function(cutscene, event)
		local kris = cutscene:getCharacter("kris")
		local susie = cutscene:getCharacter("susie")
		local you = cutscene:getCharacter("YOU")

		if susie then
			if kris then
				cutscene:showNametag("Susie")
				cutscene:setSpeaker("susie")
				cutscene:text("* Hey, Kris, there's a... fountain, over there? Let's go seal it.", "smirk")
				cutscene:hideNametag()
			elseif you then
				cutscene:showNametag("Susie")
				cutscene:setSpeaker("susie")
				cutscene:text("* Hey, Kr-[wait:3]YOU, there's a... fountain, over there? Let's go seal it. ", "smirk")
				cutscene:hideNametag()
			else
				cutscene:showNametag("Susie")
				cutscene:setSpeaker("susie")
				cutscene:text("* Hey, there's a... fountain, over there? Let's go seal it.", "smirk")
				cutscene:hideNametag()
			end

			Game:setFlag("seenPreFountain1Event1", true)
		end
	end,
	fountain1 = function(cutscene, event)
		cutscene:text("* (As this is a fountain of [color:blue]PURE DARKNESS[color:white], it cannot be sealed.)")
		cutscene:text("* (Would you like to return to the LIGHT WORLD? You will be able to come back later.)")

		if cutscene:choicer({ "Yes", "No" }) == 1 then
			Assets.playSound("snd_great_shine")
			Assets.playSound("snd_usefountain")
			cutscene:fadeOut(5, { color = { 1, 1, 1 }, music = 0.1 })
		end
	end,
}
