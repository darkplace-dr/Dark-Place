return {
	moss = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local susie_party = Game:getPartyMember("susie")
		local fstmem = Game.party[1]

		if Game:getFlag("globalEatenMossFlag") then
			cutscene:text("* (Moss. There's not enough to eat.)")
			return
		end

		Game.world.music:fade(0, 0.05)
		Game.world.music:pause()
		Assets.playSound("moss_fanfare")
		cutscene:text("[noskip]* You found the [color:green][Moss][color:white]![wait:3s]")
		Game.world.music:resume()
		Game.world.music:fade(1, 1)

		if fstmem.id == "kris" or fstmem.id == "YOU" or fstmem.id == "susie" then
			cutscene:text("* Your title was upgraded to [Moss Finder].")
			fstmem.title = "Moss Finder\nBasic moss-finding\nabilities."
		end

		if susie and susie_party then
			if fstmem.id ~= "susie" then
				susie_party.title = "Moss Enjoyer\nSupports those that\nfind moss."
			end

			cutscene:showNametag("Susie")
			cutscene:setSpeaker("susie")
			cutscene:text("* Heck yeah, more moss!", "surprise_smile")
			cutscene:hideNametag()
		end

		Game.world.map:getEvent(37):remove() -- remove shine
		Game:setFlag("globalEatenMossFlag", true)
	end,

	moss2 = function(cutscene, event)
		cutscene:text("* (Moss. There's not enough to eat.)")
	end,

	prefountain1 = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")

		if not susie then
			return
		end

		cutscene:showNametag("Susie")
		cutscene:setSpeaker("susie")
		local fstmem = Game.party[1]
		if fstmem.id == "kris" then
			cutscene:text("* Hey, Kris, there's a... fountain, over there? Let's go seal it.", "smirk")
		elseif fstmem.id == "YOU" then
			cutscene:text("* Hey, Kr-[wait:3]YOU, there's a... fountain, over there? Let's go seal it. ", "smirk")
		else
			cutscene:text("* Hey, there's a... fountain, over there? Let's go seal it.", "smirk")
		end
		cutscene:hideNametag()

		Game:setFlag("seenPreFountain1Event1", true)
	end,

	fountain1 = function(cutscene, event)
		cutscene:text("* (As this is a fountain of [color:blue]PURE DARKNESS[color:white], it cannot be sealed.)")
		cutscene:text("* (Would you like to return to the LIGHT WORLD?[wait:5] You will be able to come back later.)")

		if cutscene:choicer({ "Yes", "No" }) == 2 then
			return
		end

		--[[
			local music_fade_done = false
			Game.world.music:fade(0, 0.2, function() music_fade_done = true end)
			cutscene:wait(function() return music_fade_done end)
		]]
		cutscene:playSound("snd_great_shine")
		cutscene:fadeOut(0.75, { color = { 1, 1, 1 } })
	end,
}
