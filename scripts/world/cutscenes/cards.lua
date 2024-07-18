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
			cutscene:text("* Hey,[wait:5] Jamm!", "happy", "brenda")
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
		cutscene:text("* Hey,[wait:5] goober.")
		cutscene:hideNametag()
		
		local terry = cutscene:getCharacter("tutorial_terry")
		
		cutscene:look(Game.world.player, "right")
		
		cutscene:wait(cutscene:walkToSpeed(terry, "terry_walkto", 4))
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* You aren't even gonna pick that up?")
		cutscene:text("* The [shake:2]AUDACITY[shake:0] of people these days!")
		cutscene:text("* You think you can just leave stuff anywhere you want, huh??")
		cutscene:text("* Ur associated with him,[wait:5] so I expected you to help.")
		
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
		cutscene:text("* You don't even know what I'm talking about,[wait:5] do you?")
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
		cutscene:text("* Bruh...[wait:5] Don't you know how needed those are?")
		cutscene:text("* Do you even have any [shake:2]braincells[shake:0]?")
		
		local list = {"Yes", "No", "How about I kill you"}
		if #Game.party > 1 then
			list = {"Yes", "No", "How about I kill you"}
		end
		
		Game:setFlag("collected_cards", { {"rodenteer", 5}, {"froglin", 5}, {"rodenteer_ex", 4}, {"froglin_ex", 4}, {"owlen", 2} })
		Game:setFlag("equipped_cards", { {"rodenteer", 5}, {"froglin", 5}, {"rodenteer_ex", 4}, {"froglin_ex", 4}, {"owlen", 2} })
		
		cutscene:hideNametag()
		if cutscene:choicer(list) == 3 then
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* [shake:2]...")
			cutscene:hideNametag()
			cutscene:startEncounter("terry")
			return
		end
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Bruh.")
		cutscene:text("* A'ight,[wait:5] so number one.[wait:10]\n* We don't do battles around here.")
		cutscene:text("* We ain't about combat,[wait:5] just so we're clear.")
		cutscene:text("* We play BattleCards to settle our differences.")
		cutscene:look(terry, "down")
		cutscene:text("* U got that,[wait:5] developers?[wait:10]\n* Card battles only.")
		cutscene:look(terry, "left")
		cutscene:text("* Of course you wouldn't know that bruh.")
		cutscene:text("* I'm not gonna explain the game to ya but maybe your friend can help.")
		if Game:getFlag("dungeonkiller") then
			cutscene:text("* Speaking of your friend,[wait:5] what's wrong with him?")
			cutscene:text("* It's like he went through some kinda intense trauma recently.")
			cutscene:text("* Hopefully he doesn't attack anyone.")
		end
		cutscene:text("* Oh yeah and be sure to keep finding cards.")
		cutscene:text("* Go collect more.[wait:10] Go.[wait:10] Maybe I'll trade with you sometime...")
		cutscene:text("* ...your collection [shake:2]SUCKS[shake:0] dude. Maybe not.")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(terry, "terry_walkto_2", 4))
		cutscene:look(terry, "down")
		
		cutscene:look(Game.world.player, "up")
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Whatever.[wait:10] Keep your crap off the floor bruh.")
		cutscene:text("* I'm keeping an eye on you.")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed(terry, "terry_walkto_3", 4))
		terry:remove()
    end,
	
    tutorial_terry_2 = function(cutscene, event)
		local terry = cutscene:getCharacter("tutorial_terry")
		cutscene:detachCamera()
		cutscene:detachFollowers()
		cutscene:wait(cutscene:panTo("camera_to"))
		
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* Ay,[wait:5] bruh.[wait:10]\n* Walk right there,[wait:5] alright?")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed(Game.world.player, "player_walkto", 4))
		cutscene:showNametag("Tutorial Terry")
		cutscene:text("* I'm gonna be real with you here,[wait:5] alright?")
		cutscene:text("* I'm challenging you to a card battle.")
		cutscene:text("* You're gonna be easy pickings for me,[wait:5] bruh.")
		cutscene:text("* I only brought my starter deck,[wait:5] but you can't be any good.")
		cutscene:text("* This game requires braincells to play,[wait:5] after all.")
		local jamm
		if not Game:getFlag("dungeonkiller") then
			cutscene:look(terry, "right")
			cutscene:showNametag("Jamm")
			cutscene:text("* Hey,[wait:5] finally found you guys!", nil, "jamm")
			cutscene:hideNametag()
			jamm = cutscene:spawnNPC("jamm", 1000, 360, {})
			cutscene:wait(cutscene:walkToSpeed(jamm, "jamm_walkto_1", 4))
			cutscene:look(terry, "down")
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* Hey,[wait:5] we're kind-of in the middle of something.")
			cutscene:look(jamm, "up")
			cutscene:showNametag("Jamm")
			cutscene:text("* Okay,[wait:5] Terry.", "stern", "jamm")
			cutscene:hideNametag()
			cutscene:wait(cutscene:walkToSpeed(jamm, "jamm_walkto_2", 4))
			cutscene:look(terry, "left")
			if Game:hasPartyMember("brenda") then
				cutscene:showNametag("Brenda")
				cutscene:text("* Jamm,[wait:5] did you really ignore us back there?", "frown_side", "brenda")
				cutscene:text("* We called out to you before!", "frown", "brenda")
				cutscene:showNametag("Jamm")
				cutscene:text("* You did?[wait:10]\n* My bad,[wait:5] then.", "nervous", "jamm")
				cutscene:text("* I had my focuses on trying to find Jake.", "nervous_left", "jamm")
				cutscene:text("* Speaking of which,[wait:5] however...", "neutral", "jamm")
			end
			cutscene:text("* I went ahead and found both a plane and a jeep.", "side_smile", "jamm")
			cutscene:text("* This field isn't really that big,[wait:5] actually...", "look_left", "jamm")
			cutscene:look(jamm, "right")
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* Don't steal my plane,[wait:5] bruh.")
			cutscene:showNametag("Jamm")
			cutscene:text("* I mean,[wait:5] I found the jeep keys, but not the plane keys.", "stern", "jamm")
			cutscene:text("* Calm your penguin ass,[wait:5] Terry.", "stern", "jamm")
			cutscene:look(jamm, "left")
			cutscene:text("* Anyways,[wait:5] I've never driven in the dark world,[wait:5] so...", "nervous", "jamm")
			cutscene:text("* I hope you can do better than me,[wait:5] " .. Game.party[1].name .. ".", "smile", "jamm")
			cutscene:look(jamm, "right")
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* Bruh...[wait:5]\n* Our card battle.")
			cutscene:showNametag("Jamm")
			cutscene:text("* Oh,[wait:5] right![wait:10]\n* Your card battle!", "shocked", "jamm")
			cutscene:hideNametag()
			cutscene:wait(cutscene:walkToSpeed(jamm, "jamm_walkto_3", 4, "down"))
			cutscene:showNametag("Jamm")
			cutscene:text("* I've had a lot of experience in this game,[wait:5] you know?", "side_smile", "jamm")
			cutscene:text("* That hand I dropped was the one I started with.", "smug", "jamm")
			cutscene:look(jamm, "right")
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* That was on purpose,[wait:5] bruh!?")
			cutscene:text("* Leave your garbage off of the ground!")
			cutscene:showNametag("Jamm")
			cutscene:text("* [shake:2]Mind your damn business,[wait:5] Terry!", "pissed", "jamm")
			cutscene:showNametag("Tutorial Terry")
		end
		cutscene:text("* Whatever,[wait:5] bruh.[wait:10]\n* Let's get started.")
		cutscene:hideNametag()
		
		cutscene:startCards("tutorial")
		
		if Game:getFlag("last_battle_won") then
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* [shake:2]Bruh![shake:0][wait:10]\n* How did you win!?")
			if jamm then
				cutscene:showNametag("Jamm")
				cutscene:text("* Heart of the cards,[wait:5] Terry.", "hotc", "jamm")
				cutscene:showNametag("Tutorial Terry")
			end
		else
			cutscene:showNametag("Tutorial Terry")
			cutscene:text("* Told ya,[wait:5] bruh.")
		end
		cutscene:text("* Whatever.")
		cutscene:text("* Did you check that chest behind you?")
		cutscene:text("* It should have a Block card inside of it.")
		cutscene:text("* You can equip that card in your Cards menu, but...")
		cutscene:text("* No less than 20 cards and no more than 40.")
		cutscene:text("* Build up your deck.[wait:10] Maybe then,[wait:5] I'll trade with you.")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed(terry, terry.x + 160, terry.y, 4))
		terry:remove()
		
		if jamm then
			cutscene:showNametag("Jamm")
			cutscene:text("* Well,[wait:5] that was something.", "nervous", "jamm")
			cutscene:look(jamm, "down")
			cutscene:text("* I don't know what's past this forest,[wait:5] but...", "neutral", "jamm")
			cutscene:text("* Well,[wait:5] we'll find out together.", "side_smile", "jamm")
			cutscene:hideNametag()
			jamm = jamm:convertToFollower()
			Game:addPartyMember("jamm")
		end
		
		cutscene:attachFollowers()
		cutscene:wait(cutscene:attachCamera())
	end
}