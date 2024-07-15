return {
    tutorial_terry_1 = function(cutscene, event)
		Game:setFlag("tutorial_terry_1", true)
		local jamm = cutscene:getCharacter("jamm")
		cutscene:walkToSpeed(jamm, "jamm_walkto", 4)
		if Game:hasPartyMember("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Hey!", "surprise", "susie")
		elseif Game:hasPartyMember("brenda") then
			cutscene:showNametag("Brenda")
			cutscene:text("* Hey, Jamm!", "happy", "brenda")
		else -- feel free to add more of these if y'all want
			cutscene:text("* You call out to Jamm.")
		end
		cutscene:hideNametag()
		
		cutscene:wait(function()
			return jamm.y <= 440
		end)
		
		jamm:remove()
		
		if Game:hasPartyMember("brenda") then
			cutscene:showNametag("Brenda")
			cutscene:text("* He ignored us...?", "suspicious", "brenda")
		end
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(Game.world.player, "walkto_party", 4))
		
		cutscene:alert(Game.world.player, nil, {play_sound=false})
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Hey, goober.")
		cutscene:hideNametag()
		
		local terry = cutscene:getCharacter("tutorial_terry")
		
		cutscene:look(Game.world.player, "right")
		
		cutscene:wait(cutscene:walkToSpeed(terry, "terry_walkto", 4))
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* You aren't even gonna pick that up?")
		cutscene:text("* The AUDACITY of people these days!")
		cutscene:text("* You think you can just leave stuff anywhere you want, huh??")
		cutscene:text("* Ur associated with him, so I expected you to help.")
		
		if Game:hasPartyMember("brenda") then
			cutscene:showNametag("Brenda")
			cutscene:text("* Sorry...?", "shock", "brenda")
		elseif Game:hasPartyMember("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Uh...", "nervous", "susie")
		else -- feel free to add more of these if y'all want
			cutscene:hideNametag()
			cutscene:text("* You don't know what he expects you to say.")
		end
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* You don't even know what I'm talking about, do you?")
		cutscene:text("* I'm talking about that card pack your friend dropped.")
		
		if Game:hasPartyMember("brenda") then
			cutscene:showNametag("Brenda")
			cutscene:text("* You could've just said so...", "frown_side", "brenda")
		elseif Game:hasPartyMember("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Oh!", "surprise", "susie")
		end
		
		cutscene:hideNametag()
		cutscene:text("* You pick up a deck of cards.")
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Bruh... Don't you know how needed those are?")
		cutscene:text("* Do you even have any braincells?")
		
		local list = {"Yes", "No", "How about I kill you"}
		if #Game.party > 1 then
			list = {"Yes", "No", "How about I kill you"}
		end
		
		Game:setFlag("collected_cards", { {"rodenteer", 5}, {"froglin", 5}, {"rodenteer_ex", 4}, {"froglin_ex", 4}, {"owlen", 2} })
		Game:setFlag("equipped_cards", { {"rodenteer", 5}, {"froglin", 5}, {"rodenteer_ex", 4}, {"froglin_ex", 4}, {"owlen", 2} })
		
		cutscene:hideNametag()
		if cutscene:choicer(list) == 3 then
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* ...")
			cutscene:hideNametag()
			cutscene:startEncounter("terry")
			return
		end
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Bruh.")
		cutscene:text("* A'ight, so number one.\n* We don't do battles around here.")
		cutscene:text("* We ain't about combat, just so we're clear.")
		cutscene:text("* We play BattleCards to settle our differences.")
		cutscene:look(terry, "down")
		cutscene:text("* U got that, developers?\n* Card battles only.")
		cutscene:look(terry, "left")
		cutscene:text("* Of course you wouldn't know that bruh.")
		cutscene:text("* I'm not gonna explain the game to ya but maybe your friend can help.")
		if Game:getFlag("dungeonkiller") then
			cutscene:text("* Speaking of your friend, what's wrong with him?")
			cutscene:text("* It's like he went through some kinda intense trauma recently.")
			cutscene:text("* Hopefully he doesn't attack anyone.")
		end
		cutscene:text("* Oh yeah and be sure to keep finding cards.")
		cutscene:text("* Go collect more. Go. Maybe I'll trade with you sometime...")
		cutscene:text("* ...your collection SUCKS dude. Maybe not.")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(terry, "terry_walkto_2", 4))
		cutscene:look(terry, "down")
		
		cutscene:look(Game.world.player, "up")
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Whatever. Keep your crap off the floor bruh.")
		cutscene:text("* I'm keeping an eye on you.")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed(terry, "terry_walkto_3", 4))
		terry:remove()
    end,
}