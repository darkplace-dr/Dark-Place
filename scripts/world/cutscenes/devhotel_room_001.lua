return {

    dresser = function(cutscene, event)
        cutscene:text("* It looks like a dresser,[wait:5] will you peek inside?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            if Game.party[1].id ~= "brandon" then
                cutscene:text("[noskip]* You open the dr", nil, nil, {auto = true})
                cutscene:showNametag("Brandon")
                cutscene:text("* Hey,[wait:5] no!", "miffed", "brandon")
                cutscene:text("* Don't look at my stuff without my permission,[wait:5] okay?", "frown", "brandon")
                cutscene:hideNametag()
                cutscene:text("* Brandon closed the dresser.")
            else
                cutscene:text("* Brandon opened the dresser.")
                cutscene:text("* It's a drawer filled with socks.")
                cutscene:text("* Scandelous!")
            end
        else
            cutscene:text("* You decide not to.")
        end
    end,

    foodbowl = function(cutscene, event)
        cutscene:text("* It's a bowl for putting pet food in.")
        cutscene:text("* The name on it is \"Breadulous\".")
        if not Game:getFlag("pikpik_quest") then
            cutscene:showNametag("Brandon")
            cutscene:text("* Ah crap,[wait:5] I gotta get more Pikpik carrots.", "shock", "brandon")
            cutscene:text("* Breadulous can eat other things,[wait:5] but...", "neutral_side", "brandon")
            cutscene:text("* He really,[wait:5] really likes Pikpik carrots!", "happy_b", "brandon")
            cutscene:text("* I don't blame him either,[wait:5] I like 'em too.", "happy", "brandon")
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* Where the hell do you get those?", "nervous_side", "susie")
                cutscene:showNametag("Brandon")
            else
                cutscene:text("* Hm?[wait:5] Where do I get them from?", "neutral_side", "brandon")
            end
            cutscene:text("* Well,[wait:5] they're normally pretty expensive.", "neutral", "brandon")
            cutscene:text("* Interstellar shipping is NOT cheap.", "dissapointed", "brandon")
            cutscene:text("* But,[wait:5] I know of a place where they naturally grow.", "grin", "brandon")
            cutscene:text("* The downside is,[wait:5] that place is SUPER dangerous.", "frown_side", "brandon")
            cutscene:text("* That is,[wait:5] if you're going alone.", "happy", "brandon")
            cutscene:text("* What do I mean by that?", "neutral_side", "brandon")
            cutscene:text("* Well,[wait:5] you'll see eventually.", "happy", "brandon")
            cutscene:text("* I actually know the Warp Bin code to that place.", "happy_side", "brandon")
            cutscene:text("* It's \"PIKNF404\".", "happy", "brandon")
            cutscene:text("* Man,[wait:5] hopefully Breadulous doesn't get mad at me...", "suspicious", "brandon")
            cutscene:hideNametag()
            Game:setFlag("pikpik_quest", true)
            Kristal.callEvent("createQuest", "Pikpik Dandori", "pikpik", "Brandon is out of Pikpik carrots to feed Breadulous with. Buying them outright is too expensive, so you're going to have to find naturally grown carrots instead. Brandon said the code to where they grow is \"PIKNF404\", but be warned, the place is dangerous even with a full party!")
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Good luck getting those carrots.", "happy_b", "brandon")
            cutscene:hideNametag()
        end
    end,

    breadulous = function(cutscene, event)
        --WIP (I really gotta sleep)
        if Mod:isNight() then
            cutscene:text("* A mimir.")
        else
            cutscene:text("* The boy.")
        end
    end,

    bed = function(cutscene, event)
        cutscene:text("* It's a bed for two people.")
        cutscene:text("* It looks very comfortable.")
        if Mod:isNight() and #Game.party >= 4 then
            cutscene:showNametag("Brandon")
            cutscene:text("* Actually...[wait:10] It's getting pretty late,[wait:5] isn't it?", "happy_side", "brandon")
            cutscene:text("* You guys can spend the night here if you'd like!", "happy_b", "brandon")
            cutscene:hideNametag()
            if cutscene:choicer({"Yes", "No"}) == 1 then
                cutscene:showNametag("Brandon")
                cutscene:text("* Great!", "happy_b", "brandon")
                cutscene:text("* You guys can sleep in the living room.", "happy", "brandon")
                cutscene:text("* I'd let one of you guys sleep with me,[wait:5] but...", "neutral", "brandon")
                cutscene:text("* That just feels a bit weird,[wait:5] since well...", "neutral_side", "brandon")
                cutscene:text("* It just feels off sleeping with someone you aren't super close with.", "frown_side", "brandon")
                cutscene:text("* But uh anyways...", "neutral", "brandon")
                cutscene:text("* Goodnight guys,[wait:5] sweet dreams!", "joy", "brandon")
                cutscene:hideNametag()
                cutscene:wait(cutscene:fadeOut(2, {color = {0, 0, 0}, music = true}))
                Game:removePartyMember("brandon")
                -- TODO: Make this actually work
                --[[local x,y = 300,260
                Game.world:mapTransition("devhotel/rooms/room_001/entrance", "sleepover")
                cutscene:detachCamera()
                cutscene:detachFollowers()
                if Game:hasPartyMember("YOU") and Game:hasPartyMember("susie") and Game:hasPartyMember("dess") then
                    cutscene:walkTo("YOU", x, y - 20, 0.1, "up")
                    cutscene:walkTo("susie", x - 50, y, 0.1, "up")
                    cutscene:walkTo("dess", x + 50, y, 0.1, "up")
                    cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}, music = true}))
                end]]
                cutscene:text("* Everyone had a good night's rest.")
                Game:addPartyMember("brandon")
                cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}, music = true}))
            else
                cutscene:showNametag("Brandon")
                cutscene:text("* Alright then,[wait:5] suit yourselves.", "neutral_side", "brandon")
                cutscene:hideNametag()
            end
        else
            cutscene:text("* A sleepover would be nice if there were at least 4 people.")
        end
    end,

    tv = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local brandon = cutscene:getCharacter("brandon")
		local dess = cutscene:getCharacter("dess")
		local jamm = Game:hasPartyMember("jamm")
	
        cutscene:text("* It's a TV.")
        cutscene:text("* It doesn't seem to be working though...")
		if Game:getFlag("video_jamm") and not Game:getFlag("video_jamm_watched") then
			cutscene:text("* (Insert Jamm's VHS into the TV?)")
			if cutscene:choicer({"Yes", "No"}) == 1 then
				Game:setFlag("video_jamm_watched", true)
				cutscene:text("* You insert the VHS into the TV.")
				cutscene:text("* Suddenly, the TV comes to life.")
				
				if brandon then
					cutscene:showNametag("Brandon")
					cutscene:text("* Huh?\n* I thought the TV wasn't working?", "shock", "brandon")
					
					if jamm then
						cutscene:showNametag("Jamm")
						cutscene:text("* (At this point, I wish it wasn't...)", "shaded_frown", "jamm")
					end
					cutscene:hideNametag()
				end
				
				Game.world.music:fade(0,1)
				cutscene:wait(cutscene:fadeOut(1))
				
				cutscene:text("[voice:ania]* And are you sure that we'll be friends?")
				cutscene:text("[voice:enzio]* Trust me, Ania.\n* I knew Jamm my whole life.")
				cutscene:text("[voice:enzio]* You will make great friends, I just know it!")
				cutscene:text("[voice:enzio]* Oh, here he comes now!\n* Hey! Jamm!")
				cutscene:text("[voice:jamm]* Heya, Enzi! Who did you want me to meet?")
				cutscene:text("[voice:enzio]* Jamm, this is my sister, Ania.")
				cutscene:text("[voice:ania]* H-hello!")
				cutscene:text("[voice:jamm]* Ania, huh?\n* It's nice to meet you!")
				cutscene:text("[voice:ania]* I-it is...?")
				cutscene:text("[voice:enzio]* Oh, don't be so worried, Ania!\n* You're doing great!")
				cutscene:text("[voice:jamm]* Oh, sorry!\n* I don't really have much time!")
				cutscene:text("[voice:jamm]* Simbel, J.A.R.U., and I are working on a mod together.")
				cutscene:text("[voice:jamm]* Though...\n* Ania, would you object to meeting later?")
				cutscene:text("[voice:ania]* O-oh, not at all!")
				cutscene:text("[voice:jamm]* Great!\n* See you later!")
				
				cutscene:wait(2)
				
				local party_talk = false
				
				if brandon then
					party_talk = true
					cutscene:showNametag("Brandon")
					cutscene:text("* Is...\n* Is that when they met?", "shock", "brandon")
					
					if susie then
						cutscene:showNametag("Susie")
						cutscene:text("[voice:susie]* I...\n* I guess so.", "shock", "susie")
						cutscene:text("[voice:susie]* But...\n* Why would Jamm hate Enzio for that?", "neutral", "susie")
					end
				elseif susie then
					party_talk = true
					cutscene:showNametag("Susie")
					cutscene:text("[voice:susie]* What???\n* It's just how they met???", "shock", "susie")
					cutscene:text("[voice:susie]* Why the hell would you hate someone for that???", "neutral", "susie")
				end
				
				if jamm then
					party_talk = true
					cutscene:showNametag("Jamm")
					cutscene:text("* There's more to the tape.", "shaded_frown", "jamm")
					
					if dess then
						cutscene:showNametag("Dess")
						cutscene:text("* then i'm gonna get popcorn.", "heckyeah", "dess")
						
						if brandon then
							cutscene:showNametag("Brandon")
							cutscene:text("* Now, Dess???\n* For this???", "shock", "brandon")
						end
					end
				else
					if brandon then
						party_talk = true
						cutscene:showNametag("Brandon")
						cutscene:text("* Wait, there's more to this tape...", "neutral", "brandon")
						
						if dess then
							cutscene:showNametag("Dess")
							cutscene:text("* then i'm gonna get popcorn.", "heckyeah", "dess")
							
							if brandon then
								cutscene:showNametag("Brandon")
								cutscene:text("* Now, Dess???\n* For this???", "shock", "brandon")
							end
						end
					end
				end
				cutscene:hideNametag()
				
				cutscene:wait(2)
				
				cutscene:text("* Do you, Luthane Jamm, take Ania to be your wife?")
				cutscene:text("[voice:jamm]* I do.")
				cutscene:text("* Do you, Ania Bishop, take Luthane to be your husband?")
				cutscene:text("[voice:ania]* I do.")
				cutscene:text("* Then, with the power vested in me...")
				cutscene:text("* I pronounce you husband and wife.")
				cutscene:text("* You may kiss the bride.")
				
				cutscene:wait(2)
				
				party_talk = false
				
				if brandon then
					party_talk = true
					cutscene:showNametag("Brandon")
					cutscene:text("* Oh, I remember that day!", "grin", "brandon")
					cutscene:text("* Jamm had invited me to be his best man!", "joy", "brandon")
					cutscene:text("* Wow, time really flies!", "happy", "brandon")
					
					if jamm then
						cutscene:showNametag("Jamm")
						cutscene:text("* I-it really does...", "shaded_frown", "jamm")
					end
				end
				
				if susie then
					party_talk = true
					cutscene:showNametag("Susie")
					cutscene:text("* Y'know, this Ania...", "nervous", "susie")
					cutscene:text("* I could be wrong, but we haven't seen her at all.", "nervous_side", "susie")
					cutscene:text("* Why is that...?", "nervous", "susie")
					
					if brandon then
						cutscene:showNametag("Brandon")
						cutscene:text("* Susie--", "frown_side", "brandon", {auto = true})
					end
					
					if jamm then
						cutscene:showNametag("Jamm")
						cutscene:text("* That will be answered soon.", "shaded_frown", "jamm")
					end
				end
				
				if dess then
					party_talk = true
					cutscene:showNametag("Dess")
					cutscene:text("* i got the popcorn", "heckyeah", "dess")
					
					if brandon then
						cutscene:showNametag("Brandon")
						cutscene:text("* I don't think that's appropriate...", "frown_side", "brandon")
						
						cutscene:showNametag("Dess")
						cutscene:text("* but it's a movie lmao", "heckyeah", "dess")
					end
				end
				cutscene:hideNametag()
				
				if party_talk then
					cutscene:wait(2)
				end
				
				cutscene:text("[voice:jamm]* Isn't she beautiful, Ania?")
				cutscene:text("[voice:ania]* Y-yes, she is...")
				cutscene:text("[voice:jamm]* Do you want to hold her?")
				cutscene:text("[voice:ania]* I would like that...")
				cutscene:text("[voice:jamm]* Here you go, Ania.\n* Just like this.")
				cutscene:text("[voice:ania]* And when did you become the baby-holding expert?")
				cutscene:text("[voice:jamm]* Probably when my sister gave me some pointers with Jaek.")
				cutscene:text("[voice:jamm]* So, have you given some thought to what she'd be named?")
				cutscene:text("[voice:ania]* Yeah... Marcy.")
				cutscene:text("[voice:jamm]* Marcy?\n* Like your grandmother, huh?")
				cutscene:text("[voice:jamm]* I wish I could've seen eye to eye with her before she...")
				cutscene:text("[voice:ania]* Please, for me?\n* I was really close with Nana Marcy...")
				cutscene:text("[voice:jamm]* ...Alright.\n* Just for you, dear.")
				
				cutscene:wait(2)
				
				party_talk = false
				
				if dess then
					party_talk = true
					cutscene:showNametag("Dess")
					cutscene:text("* thank you for skipping the gross part, Jamm.", "neutral", "dess")
					
					if brandon then
						cutscene:showNametag("Brandon")
						cutscene:text("* Yeah, that would've raised the age rating of this mod.", "frown_side", "brandon")
					end
					
					if jamm then
						cutscene:showNametag("Jamm")
						cutscene:text("* This mod isn't particularly for kids, anyways.", "shaded_frown", "jamm")
					end
				end
				
				if brandon and jamm then
					party_talk = true
					
					cutscene:showNametag("Brandon")
					cutscene:text("* You know what, though?", "frown_side", "brandon")
					cutscene:text("* I never got to say this, but I'm proud of you, Jamm.", "frown_side", "brandon")
					cutscene:text("* You raised Marcy to be a great girl up to this point.", "frown_side", "brandon")
					cutscene:text("* I know what's coming up might not be too good, but...", "frown_side", "brandon")
				end
				cutscene:hideNametag()
				
				if party_talk then
					cutscene:wait(2)
				end
				
				cutscene:text("[voice:ania]* You know, I never really got to explore TOMBSITE that much.")
				cutscene:text("[voice:jamm]* Yeah.\n* You've been busy at that job of yours, haven't you?")
				cutscene:text("[voice:ania]* Yeah, and I never got a day off until--", nil, nil, {auto = true})
				cutscene:text("[voice:ania]* Jamm, look out!")
				
				Assets.playSound("stab_death")
				
				cutscene:wait(1)
				
				cutscene:text("[voice:jamm][shake:1]* A-Ania!?")
				cutscene:text("[voice:jamm][shake:1]* Ania, please, speak to me!")
				cutscene:text("[voice:jamm][shake:1]* Don't die on me, Ania!\n* Please, I...")
				cutscene:text("[voice:jamm][shake:1]* There's so much I want to say to you...")
				cutscene:text("[speed:0.5][voice:ania]* L... Luthane, I...")
				cutscene:text("[speed:0.5][voice:ania]* I love you...\n* So much...")
				cutscene:text("[voice:jamm][shake:1]* ...")
				cutscene:text("[voice:jamm][shake:1]* Wait, there's writing on the...")
				cutscene:text("[voice:jamm][shake:1]* ...")
				cutscene:text("[voice:jamm]* ...")
				cutscene:text("[voice:jamm]* ...Enzio...")
				cutscene:text("[voice:jamm]* I will never forgive you.")
				
				cutscene:wait(2)
				
				jamm_in_party = true
				if not jamm then
					jamm = NPC("fake_jamm")
					jamm.x = 480
					jamm.y = 200
					Game.world:spawnObject(jamm)
					cutscene:look(jamm, "right")
					jamm_in_party = false
				end
				
				cutscene:wait(cutscene:fadeIn(1))
				
				if brandon then
					cutscene:showNametag("Brandon")
					cutscene:text("* ...", "shock", "brandon")
				end
				
				if susie then
					cutscene:showNametag("Susie")
					cutscene:text("* ...", "sad", "susie")
				end
				
				cutscene:showNametag("Jamm")
				cutscene:text("* And now, you know why I hate Enzio so much.", "shaded_frown", "jamm")
				
				if brandon then
					cutscene:showNametag("Brandon")
					cutscene:text("* J-Jamm, I...\n* I had no idea...", "sad", "brandon")
					cutscene:text("* That's...\n* That's really how she...", "sad", "brandon")
				end
				
				if susie then
					cutscene:showNametag("Susie")
					cutscene:text("* ...", "shy_down", "susie")
					cutscene:text("* It all makes sense now.", "shy_down", "susie")
				end
				
				cutscene:showNametag("Jamm")
				cutscene:text("* ...", "shaded_frown", "jamm")
				cutscene:text("* In TOMBSITE, there is another place.", "shaded_frown", "jamm")
				cutscene:text("* Left, down, right, up.", "shaded_frown", "jamm")
				cutscene:text("* And you'll need me to get through the door there.", "shaded_frown", "jamm")
				cutscene:text("* Whenever you're ready, okay?", "shaded_frown", "jamm")
				cutscene:hideNametag()
				
				if not jamm_in_party then
					cutscene:wait(cutscene:fadeOut(0.75))
					jamm:remove()
					cutscene:wait(cutscene:fadeIn(0.75))
				end
				
				Kristal.callEvent("createQuest", "Jamm's Closure", "acj2", "Jamm revealed to you the reason why he hates Enzio so much. He says to head back to the TOMBSITE and walk \"left, down, right, up\". What will you find in the new area Jamm told you about?")
			else
				cutscene:text("* You insertn't.")
			end
		end
    end,
}