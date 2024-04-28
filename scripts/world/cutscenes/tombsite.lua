return {
    grave_1 = function(cutscene, event)
        cutscene:text("* \"When you find all hopes have left,[wait:5] you're not right.\"")
    end,
    grave_2 = function(cutscene, event)
        cutscene:text("* Ania Jamm[wait:5]\n* 1999-2023")
        cutscene:text("* \"Always look up.[wait:5] Your dreams are waiting.\"")
    end,
    grave_3 = function(cutscene, event)
        cutscene:text("* \"Life is designed to knock you down.[wait:5] Just get back up.\"")
    end,
    grave_4 = function(cutscene, event)
        cutscene:text("* \"I believe in doing the right things;[wait:5] not knocking others down.\"")
    end,
    grave_5 = function(cutscene, event)
        cutscene:text("* \"Our greatest weakness lies in giving up.\"")
    end,
	-- left, right, up, down, up, right, down, up
	
	fake_jamm = function(cutscene,event)
		local jamm = cutscene:getCharacter("fake_jamm")
		local brenda = cutscene:getCharacter("brenda")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Oh, hey.", "shaded_neutral", "jamm")
		
		if brenda then
			cutscene:showNametag("Brenda")
			cutscene:text("* Jamm, is that you?", "shock", "brenda")
			cutscene:text("* You don't look to good.\n* Are you alright?", "neutral", "brenda")
			cutscene:showNametag("Jamm")
			cutscene:text("* As alright as I can be, I guess.", "shaded_neutral", "jamm")
			cutscene:text("* It's just that I'm visiting my wife.", "shaded_frown", "jamm")
		else
			cutscene:text("* Sorry, you didn't catch me at a bad time.", "shaded_neutral", "jamm")
			cutscene:text("* Just that I'm visiting my wife...", "shaded_frown", "jamm")
		end
		
		cutscene:text("* I miss her.", "shaded_frown", "jamm")
		
		if brenda then
			cutscene:showNametag("Brenda")
			cutscene:text("* Looks like you need to get your mind off of it.", "neutral_side", "brenda")
		else
			cutscene:hideNametag()
			cutscene:text("* You tell Jamm to try to get his mind off of it.")
		end
		
		cutscene:showNametag("Jamm")
		cutscene:text("* I mean, yeah, I guess that would help.", "shaded_neutral", "jamm")
		cutscene:hideNametag()
		
		jamm:convertToFollower(#Game.party, true)
		cutscene:interpolateFollowers()
		cutscene:wait(cutscene:attachFollowers(4))
		
		Game:setFlag("fake_jamm", true)
		
		if brenda then
			cutscene:showNametag("Brenda")
			cutscene:text("* (Why does something feel off?)", "frown_side", "brenda")
		end
		cutscene:hideNametag()
		
		Kristal.callEvent("setDesc", "acj", "You found AcousticJamm in the forest. However, something seems off about him. Not only that, but the forest seems different than when you entered. Try to find your way out!")
	end,
	transition_1 = function(cutscene, event)
		Game.world:mapTransition("fwood/graves", "entry")
	end,
	transition_2 = function(cutscene, event)
		if Game:getFlag("fake_jamm", false) then
			Game.world:mapTransition("fwood/cross", "up")
		else
			Game.world:mapTransition("fwood/entry", "exit")
		end
	end,
	up = function(cutscene, event)
		local has_value = function (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end

			return false
		end
		
		if has_value({2,4,7},Game:getFlag("jamm_cross")) then
			if Game:getFlag("jamm_cross") == 7 then
				Game.world:mapTransition("fwood/boss", "top")
				Game:setFlag("jamm_cross", 0)
			else
				Game.world:mapTransition("fwood/cross", "down")
				Game:addFlag("jamm_cross", 1)
			end
		elseif Game:getFlag("jamm_cross_2") == 3 then
			Game.world:mapTransition("fwood/dungeon", "entry")
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Assets.playSound("incorrect", 1, 1)
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        end
	end,
	down = function(cutscene, event)
		local has_value = function (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end

			return false
		end
		
		if has_value({3,6},Game:getFlag("jamm_cross")) then
            Game.world:mapTransition("fwood/cross", "up")
			Game:addFlag("jamm_cross", 1)
		elseif Game:getFlag("jamm_cross_2") == 1 then
            Game.world:mapTransition("fwood/cross", "up")
			Game:setFlag("jamm_cross", 0)
			Game:addFlag("jamm_cross_2", 1)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Assets.playSound("incorrect", 1, 1)
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        end
	end,
	left = function(cutscene, event)
		if Game:getFlag("jamm_cross", 0) < 1 then
            Game.world:mapTransition("fwood/cross", "right")
			Game:addFlag("jamm_cross", 1)
			Game:addFlag("jamm_cross_2", 1)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Assets.playSound("incorrect", 1, 1)
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        end
	end,
	right = function(cutscene, event)
		local has_value = function (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end

			return false
		end
		
		if has_value({1,5},Game:getFlag("jamm_cross")) then
            Game.world:mapTransition("fwood/cross", "left")
			Game:addFlag("jamm_cross", 1)
		elseif Game:getFlag("jamm_cross_2") == 2 then
            Game.world:mapTransition("fwood/cross", "left")
			Game:setFlag("jamm_cross", 0)
			Game:addFlag("jamm_cross_2", 1)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
			Assets.playSound("incorrect", 1, 1)
        end
	end,
	
	final_jamm = function(cutscene,event)
		local fake_jamm = cutscene:getCharacter("fake_jamm"):convertToNPC()
		Game:removeFollower(fake_jamm)
		local jamm = cutscene:getCharacter("jamm")
		local brenda = cutscene:getCharacter("brenda")
		local susie = cutscene:getCharacter("susie")
		
		local members = {}
		for _, member in ipairs(Game.party) do
			table.insert(members, cutscene:getCharacter(member.id))
		end
		local leader = members[1]
		cutscene:wait(cutscene:walkToSpeed(leader, "party", 4))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Good job at making it out of the bulk of the forest.", "shaded_pissed", "jamm")
		cutscene:text("* I should've known the solution was on the gravestones.", "shaded_neutral", "jamm")
		cutscene:text("* However...", "shaded_neutral", "jamm")
		cutscene:hideNametag()
		
		cutscene:detachFollowers()
		cutscene:wait(cutscene:walkToSpeed(fake_jamm, "jamm", 4))
		cutscene:showNametag("Jamm?")
		cutscene:text("* I can't let you pass alive.", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		cutscene:setAnimation(fake_jamm, "attack")
		cutscene:wait(1/15)
		
		cutscene:setAnimation(leader, "battle/defeat")
		Assets.playSound("hurt", 1, 1)
		
		cutscene:wait(cutscene:slideTo(leader, "party_1", 1, "out-cubic"))
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* Do you see how easy it was to knock you down?", "shaded_revealed", "jamm")
		cutscene:text("* It will be even easier to break you entirely.", "shaded_revealed", "jamm")
		cutscene:text("* So then, how will this go?", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		local party_walk_wait = nil
		for i, member in ipairs(members) do
			party_walk_wait = cutscene:walkTo(member, "party_" .. i, 0.5)
		end
		cutscene:wait(party_walk_wait)
		
		for i, member in ipairs(members) do
			cutscene:setAnimation(member, "battle/attack")
		end
		Assets.playSound("laz_c", 1, 1)
		
		cutscene:wait(1)
		
		cutscene:look(fake_jamm, "left")
		cutscene:resetSprite(fake_jamm)
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* The hard way, huh?", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(fake_jamm, "fake_jamm", 4, "left"))
		cutscene:setAnimation(fake_jamm, "idle")
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* You're just making this more fun for me!", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		cutscene:startEncounter("fake_jamm", false, {{"fake_jamm", fake_jamm}})
		
		cutscene:setAnimation(fake_jamm, "attack")
		cutscene:wait(1/15)
		
		for i, member in ipairs(members) do
			cutscene:setAnimation(member, "battle/defeat")
		end
		Assets.playSound("hurt", 1, 1)
		
		cutscene:wait(1)
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* Pathetic.", "shaded_revealed", "jamm")
		cutscene:text("* Well, it's time to--", "shaded_revealed", "jamm", {auto = true})
		
		cutscene:showNametag("???")
		cutscene:text("* Hold it!", nil, "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(jamm, "jamm", 8, "right"))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Well, Enzio.\n* Never thought you'd stoop this low.", "smirk", "jamm")
		cutscene:text("* Stealing my Guilded account, sure.\n* But impersonation?", "smirk", "jamm")
		
		cutscene:showNametag("Enzio")
		cutscene:text("* How did you escape!?", "shaded_desperate", "jamm")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Does it matter?\n* All that matters is you're done.", "smirk", "jamm")
		
		cutscene:resetSprite(fake_jamm)
		
		cutscene:showNametag("Enzio")
		cutscene:text("* Well, in that case, I guess I'll take my leave.", "shaded_neutral", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:fadeOut(0.75))
		fake_jamm:remove()
		cutscene:wait(cutscene:fadeIn(0.75))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* That was completely unexpected.", "stern", "jamm")
		cutscene:look(jamm, "left")
		cutscene:text("* You okay?", "worried", "jamm")
		cutscene:hideNametag()
		
		for i, member in ipairs(members) do
			cutscene:resetSprite(member)
			cutscene:look(member, "right")
			Assets.stopAndPlaySound("noise")
			cutscene:wait(0.75)
		end
		
		if brenda then
			cutscene:showNametag("Brenda")
			cutscene:text("* Yeah, I think we're good now.", "neutral", "brenda")
		end
		
		if susie then
			cutscene:showNametag("Susie")
			cutscene:text("[voice:susie]* What the hell was that!?", "angry", "susie")
			cutscene:showNametag("Jamm")
			cutscene:text("* It was some petty rivalry.", "nervous", "jamm")
			cutscene:text("* Sorry that you were involved.", "look_left", "jamm")
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Phew, you're alright...", "nervous", "jamm")
			cutscene:text("* Sorry that you were involved in all this..", "look_left", "jamm")
		end
		
		if #Game.party >= Game:getFlag("party_max") then
			cutscene:text("* I'd join you guys, but it looks like you have a full party.", "neutral", "jamm")
			cutscene:text("* I'll see you later then.\n* Let me think for now.", "neutral", "jamm")
			cutscene:hideNametag()
			
			cutscene:wait(cutscene:fadeOut(0.75))
			jamm:remove()
			cutscene:wait(cutscene:fadeIn(0.75))
		
			cutscene:attachFollowers()
			cutscene:wait(2)
		else
			cutscene:text("* I'll join your party, then.", "neutral", "jamm")
			cutscene:hideNametag()
			Game:addPartyMember("jamm")
			Game:setFlag("jamm_party", true)
			jamm:convertToFollower(#Game.party - 1)
			cutscene:text("* Jamm joined the party.")
			cutscene:attachFollowers()
			cutscene:wait(0.5)
		end
		Game:setFlag("jamm_inparty", true)
		Mod:unlockPartyMember("jamm")
		Kristal.callEvent("completeQuest", "acj")
		Kristal.callEvent("setDesc", "acj", "You found AcousticJamm (for real this time) during your battle against Enzio. Now, AcousticJamm is on your side! However, with Enzio, this may only be the start...")
	end,
	jamm = function(cutscene, event)
		cutscene:showNametag("Jamm")
		cutscene:text("* See you later!", "smile", "jamm")
		cutscene:hideNametag()
	end,
	door = function(cutscene, event)
		local jamm = cutscene:getCharacter("jamm")
		local dess = cutscene:getCharacter("dess")
		
		if Game:getFlag("video_jamm_watched") then
			if jamm then
				if Game:getFlag("jamm_closure") then
					cutscene:showNametag("Jamm")
					cutscene:text("* Never again.", "neutral", "jamm")
				elseif dess then
					local x,y = event:getRelativePos()
					cutscene:detachCamera()
					cutscene:detachFollowers()
					cutscene:walkTo(Game.world.player, x + 20, y + 150, 0.75, "up")
					for i, v in ipairs(Game.world.followers) do
                        local transformed_x = (i+1 - 1) % 2
                        local transformed_y = math.floor((i+1 - 1) / 2)

                        -- Transform the grid into coordinates
                        local offset_x = transformed_x * 120
                        local offset_y = transformed_y * 40
                        cutscene:walkTo(v, offset_x + x + 20, offset_y + y + 150, 0.75, "up")
					end
					cutscene:showNametag("Jamm")
					cutscene:text("* I can give it a shot.", "smile", "jamm")
					cutscene:hideNametag()
					cutscene:wait(cutscene:walkTo(jamm, x + 20, y + 80, 0.75, "up"))
					cutscene:showNametag("Dess")
					cutscene:text("* opening a door with your mind is definitely possible", "condescending", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* Oh, you have no idea, Dess.", "smirk", "jamm")
					cutscene:showNametag("Dess")
					cutscene:text("* okay", "condescending", "dess")
					cutscene:hideNametag()
					cutscene:wait(cutscene:walkTo(dess, x + 80, y + 80, 0.75, "up"))
					
					local layer = Game.world.map:getTileLayer("door_closed")
					layer.visible = false
					Assets.playSound("noise")
					
					cutscene:wait(1)
					cutscene:look(jamm, "right")
					cutscene:look(dess, "left")
					cutscene:showNametag("Jamm")
					cutscene:text("* ...So I guess it's you and me, huh?", "stern", "jamm")
					cutscene:showNametag("Dess")
					cutscene:text("* are you asking me out?", "condescending", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* Hell no.\n* Let's just go in already.", "stern", "jamm")
					cutscene:hideNametag()
					cutscene:look(jamm, "up")
					cutscene:look(dess, "up")
					
					cutscene:wait(cutscene:fadeOut(0.75))
					for k,chara in ipairs(Game.party) do
						Game:setFlag(chara.id .. "_party", false)
					end
					Game.party = {}
					Game:addPartyMember("jamm")
					Game:addPartyMember("dess")
					Game:setFlag("jamm_party", true)
					Game:setFlag("dess_party", true)
					Assets.playSound("impact")
					cutscene:wait(1)
					cutscene:loadMap("fwood/dungeon_inside/entrance", "entry", "up")
					
					cutscene:wait(cutscene:fadeIn(0.75))
					
					cutscene:showNametag("Dess")
					cutscene:text("* hey Jamm, the door locked behind us.", "condescending", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* ...That makes this a lot worse.", "nervous", "jamm")
					cutscene:hideNametag()
					local jamm_party = Game:getPartyMember("jamm")
					jamm_party.has_act = true
					Game:setFlag("jamm_canact", true)
					cutscene:text("* Jamm can now use ACTs!")
				else
					cutscene:showNametag("Jamm")
					cutscene:text("* Well, this is the door Ania mentioned.", "smile", "jamm")
					cutscene:text("* She said she's been working on this a lot, but...", "neutral", "jamm")
					cutscene:text("* She told me I need help from [color:yellow]a certain person[color:white].", "neutral", "jamm")
				end
			else
				cutscene:text("* It's a door.\n* It doesn't seem to budge.")
			end
		else
			if jamm then
				cutscene:showNametag("Jamm")
				cutscene:text("* ...Not yet.", "shaded_frown", "jamm")
			else
				cutscene:text("* It's a door.\n* It doesn't seem to budge.")
			end
		end
		cutscene:hideNametag()
	end
}
