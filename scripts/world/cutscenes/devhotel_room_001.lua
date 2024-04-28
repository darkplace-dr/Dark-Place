return {

    dresser = function(cutscene, event)
        cutscene:text("* It looks like a dresser,[wait:5] will you peek inside?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            if Game.party[1].id ~= "brenda" then
                cutscene:text("[noskip]* You open the dr", nil, nil, {auto = true})
                cutscene:showNametag("Brenda")
                cutscene:text("* Hey,[wait:5] no!", "miffed", "brenda")
                cutscene:text("* Don't look at my stuff without my permission,[wait:5] okay?", "frown", "brenda")
                cutscene:hideNametag()
                cutscene:text("* Brenda closed the dresser.")
            else
                cutscene:text("* Brenda opened the dresser.")
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
            cutscene:showNametag("Brenda")
            cutscene:text("* Ah crap,[wait:5] I gotta get more Pikpik carrots.", "shock", "brenda")
            cutscene:text("* Breadulous can eat other things,[wait:5] but...", "neutral_side", "brenda")
            cutscene:text("* He really,[wait:5] really likes Pikpik carrots!", "happy_b", "brenda")
            cutscene:text("* I don't blame him either,[wait:5] I like 'em too.", "happy", "brenda")
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* Where the hell do you get those?", "nervous_side", "susie")
                cutscene:showNametag("Brenda")
            else
                cutscene:text("* Hm?[wait:5] Where do I get them from?", "neutral_side", "brenda")
            end
            cutscene:text("* Well,[wait:5] they're normally pretty expensive.", "neutral", "brenda")
            cutscene:text("* Interstellar shipping is NOT cheap.", "dissapointed", "brenda")
            cutscene:text("* But,[wait:5] I know of a place where they naturally grow.", "grin", "brenda")
            cutscene:text("* The downside is,[wait:5] that place is SUPER dangerous.", "frown_side", "brenda")
            cutscene:text("* That is,[wait:5] if you're going alone.", "happy", "brenda")
            cutscene:text("* What do I mean by that?", "neutral_side", "brenda")
            cutscene:text("* Well,[wait:5] you'll see eventually.", "happy", "brenda")
            cutscene:text("* I actually know the Warp Bin code to that place.", "happy_side", "brenda")
            cutscene:text("* It's \"PIKNF404\".", "happy", "brenda")
            cutscene:text("* Man,[wait:5] hopefully Breadulous doesn't get mad at me...", "suspicious", "brenda")
            cutscene:hideNametag()
            Game:setFlag("pikpik_quest", true)
            Kristal.callEvent("createQuest", "Pikpik Dandori", "pikpik", "Brenda is out of Pikpik carrots to feed Breadulous with. Buying them outright is too expensive, so you're going to have to find naturally grown carrots instead. Brenda said the code to where they grow is \"PIKNF404\", but be warned, the place is dangerous even with a full party!")
        else
            cutscene:showNametag("Brenda")
            cutscene:text("* Good luck getting those carrots.", "happy_b", "brenda")
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
            cutscene:showNametag("Brenda")
            cutscene:text("* Actually...[wait:10] It's getting pretty late,[wait:5] isn't it?", "happy_side", "brenda")
            cutscene:text("* You guys can spend the night here if you'd like!", "happy_b", "brenda")
            cutscene:hideNametag()
            if cutscene:choicer({"Yes", "No"}) == 1 then
                cutscene:showNametag("Brenda")
                cutscene:text("* Great!", "happy_b", "brenda")
                cutscene:text("* You guys can sleep in the living room.", "happy", "brenda")
                cutscene:text("* I'd let one of you guys sleep with me,[wait:5] but...", "neutral", "brenda")
                cutscene:text("* That just feels a bit weird,[wait:5] since well...", "neutral_side", "brenda")
                cutscene:text("* None of you guys are really super close with me.", "frown_side", "brenda")
                cutscene:text("* But uh anyways...", "neutral", "brenda")
                cutscene:text("* Goodnight guys,[wait:5] sweet dreams!", "joy", "brenda")
                cutscene:hideNametag()
                cutscene:wait(cutscene:fadeOut(2, {color = {0, 0, 0}, music = true}))
				--[[
                if Game:hasPartyMember("YOU") and Game:hasPartyMember("susie") and Game:hasPartyMember("dess") then
					Game:removePartyMember("brenda")
                	local x,y = 300,260
                	Game.world:mapTransition("devhotel/rooms/room_001/entrance", "sleepover")
                    cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}, music = true}))
					
                end]]
                cutscene:text("* Everyone had a good night's rest.")
                cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}, music = true}))
            else
                cutscene:showNametag("Brenda")
                cutscene:text("* Alright then,[wait:5] suit yourselves.", "neutral_side", "brenda")
                cutscene:hideNametag()
            end
        else
            cutscene:text("* A sleepover would be nice if there were at least 4 people.")
        end
    end,

    tv = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local brenda = cutscene:getCharacter("brenda")
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
				
				if brenda then
					cutscene:showNametag("Brenda")
					cutscene:text("* Huh?\n* I thought the TV wasn't working?", "shock", "brenda")
					
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
				
				if brenda then
					party_talk = true
					cutscene:showNametag("Brenda")
					cutscene:text("* Is...\n* Is that when they met?", "shock", "brenda")
					
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
						
						if brenda then
							cutscene:showNametag("Brenda")
							cutscene:text("* Now, Dess???\n* For this???", "shock", "brenda")
						end
					end
				else
					if brenda then
						party_talk = true
						cutscene:showNametag("Brenda")
						cutscene:text("* Wait, there's more to this tape...", "neutral", "brenda")
						
						if dess then
							cutscene:showNametag("Dess")
							cutscene:text("* then i'm gonna get popcorn.", "heckyeah", "dess")
							
							if brenda then
								cutscene:showNametag("Brenda")
								cutscene:text("* Now, Dess???\n* For this???", "shock", "brenda")
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
				
				if brenda then
					party_talk = true
					cutscene:showNametag("Brenda")
					cutscene:text("* Oh, I remember that day!", "grin", "brenda")
					cutscene:text("* Jamm had invited me to be his best man!", "joy", "brenda")
					cutscene:text("* Wow, time really flies!", "happy", "brenda")
					
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
					
					if brenda then
						cutscene:showNametag("Brenda")
						cutscene:text("* Susie--", "frown_side", "brenda", {auto = true})
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
					
					if brenda then
						cutscene:showNametag("Brenda")
						cutscene:text("* I don't think that's appropriate...", "frown_side", "brenda")
						
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
					
					if brenda then
						cutscene:showNametag("Brenda")
						cutscene:text("* Yeah, that would've raised the age rating of this mod.", "frown_side", "brenda")
					end
					
					if jamm then
						cutscene:showNametag("Jamm")
						cutscene:text("* This mod isn't particularly for kids, anyways.", "shaded_frown", "jamm")
					end
				end
				
				if brenda and jamm then
					party_talk = true
					
					cutscene:showNametag("Brenda")
					cutscene:text("* You know what, though?", "frown_side", "brenda")
					cutscene:text("* I never got to say this, but I'm proud of you, Jamm.", "frown_side", "brenda")
					cutscene:text("* You raised Marcy to be a great girl up to this point.", "frown_side", "brenda")
					cutscene:text("* I know what's coming up might not be too good, but...", "frown_side", "brenda")
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
				
				local jamm_in_party = true
				if not jamm then
					jamm = NPC("fake_jamm")
					jamm.x = 480
					jamm.y = 200
					Game.world:spawnObject(jamm)
					cutscene:look(jamm, "right")
					jamm_in_party = false
				end
				
				cutscene:wait(cutscene:fadeIn(1))
				
				if brenda then
					cutscene:showNametag("Brenda")
					cutscene:text("* ...", "shock", "brenda")
				end
				
				if susie then
					cutscene:showNametag("Susie")
					cutscene:text("* ...", "sad", "susie")
				end
				
				cutscene:showNametag("Jamm")
				cutscene:text("* And now, you know why I hate Enzio so much.", "shaded_frown", "jamm")
				
				if brenda then
					cutscene:showNametag("Brenda")
					cutscene:text("* J-Jamm, I...\n* I had no idea...", "sad", "brenda")
					cutscene:text("* That's...\n* That's really how she...", "sad", "brenda")
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

	window = function(cutscene, event)
		if Game:getFlag("jamm_closure") and Game:hasPartyMember("susie") and Game:hasPartyMember("dess") and Game:hasPartyMember("jamm") and Game:getFlag("berdly_inparty") then
			cutscene:text("* Something feels off about this window.")
			cutscene:text("* Will you go inside?")
			cutscene:text("* WARNING:[wait:10] The following area is meant to only be available after defeating Spamgolor NEO.")
			cutscene:text("* As such,[wait:5] some things that occur may not make sense without context.")
			cutscene:text("* Also,[wait:5] [color:red]THIS MAY PERMANENTLY RUIN YOUR SAVEFILE[color:white].")
			cutscene:text("* I have no idea what'll happen if you do this area before fighting Spamgolor NEO.")
			cutscene:text("* It is recomended that you make a backup of your savefile just in case.")
			cutscene:text("* Also right now it's unfinished,[wait:5] so don't expect much.")
			cutscene:text("* You have been warned.")
			cutscene:text("* So,[wait:5] I will ask you again.")
			cutscene:text("* Will you go inside?")
			local opinion = cutscene:choicer({"Yes", "No"})
			if opinion == 1 then
				if Game:getFlag("b_fight") then
					Game.world:mapTransition("devhotel/rooms/room_001/thoughts/entrance", "spawn")
				else
					cutscene:wait(cutscene:fadeOut(0.75))
					for k,chara in ipairs(Game.party) do
						Game:setFlag(chara.id .. "_party", false)
					end
					Game.party = {}
					Game:addPartyMember("susie")
					Game:addPartyMember("dess")
					Game:addPartyMember("jamm")
					Game:setFlag("susie_party", true)
					Game:setFlag("dess_party", true)
					Game:setFlag("jamm_party", true)
					cutscene:loadMap("devhotel/rooms/room_001/thoughts/entrance", "spawn")
					local susie = cutscene:getCharacter("susie")
					local dess = cutscene:getCharacter("dess")
					local jamm = cutscene:getCharacter("jamm")
					susie:setSprite("fell")
					dess:setSprite("battle/defeat_1")
					jamm:setSprite("landed_2")
					dess.x = 309
					dess.y = 447
					jamm.x = 490
					jamm.y = 447
					cutscene:wait(cutscene:fadeIn(0.75))
					cutscene:wait(1)
					cutscene:showNametag("Susie")
					cutscene:text("* Urghh...", "", "susie")
					cutscene:hideNametag()
					Assets.stopAndPlaySound("wing")
					susie:shake(5)
					cutscene:wait(1)
					cutscene:showNametag("Susie")
					cutscene:text("* Where...", "", "susie")
					cutscene:hideNametag()
					susie:setSprite("landed_2")
					Assets.stopAndPlaySound("wing")
					susie:shake(5)
					cutscene:wait(1)
					susie:setFacing("up")
					susie:resetSprite()
					Assets.stopAndPlaySound("wing")
					susie:shake(5)
					cutscene:wait(1)
					cutscene:showNametag("Susie")
					cutscene:text("* Where the hell AM I...?", "sus_nervous", "susie")
					cutscene:hideNametag()
					Assets.stopAndPlaySound("wing")
					dess:shake(5)
					cutscene:wait(1)
					dess:setFacing("down")
					dess:resetSprite()
					Assets.stopAndPlaySound("wing")
					dess:shake(5)
					cutscene:wait(1)
					cutscene:showNametag("Dess")
					cutscene:text("* Good morning USA", "heckyeah", "dess")
					cutscene:showNametag("Susie")
					cutscene:text("* ...", "suspicious", "susie")
					cutscene:hideNametag()
					Assets.stopAndPlaySound("wing")
					jamm:shake(5)
					cutscene:wait(1)
					dess:setFacing("right")
					jamm:setFacing("down")
					jamm:resetSprite()
					Assets.stopAndPlaySound("wing")
					jamm:shake(5)
					cutscene:wait(1)
                    if Game:getFlag("dungeonkiller") then
    					cutscene:showNametag("Dess")
    					cutscene:text("* where we droppin',[wait:5] boys?", "wink", "dess")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Beats me.", "nervous_side", "susie")
    					cutscene:text("* I feel like I'm dreaming,[wait:5] but...", "nervous", "susie")
    					cutscene:text("* This feels so real...", "nervous_side", "susie")
    					dess:setFacing("right")
    					cutscene:showNametag("Dess")
    					cutscene:text("* we should try to find a way out", "heckyeah", "dess")
    					cutscene:text("* i'll lead the way and--", "heckyeah", "dess", {auto=true})
    					jamm:setFacing("left")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* Not on your life.", "shaded_pissed", "jamm")
    					cutscene:showNametag("Dess")
    					cutscene:text("* ", "wtf", "dess")
    					cutscene:showNametag("Susie")
    					cutscene:text("* ", "shock", "susie")
					    jamm:setFacing("down")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* You lead, Susie.", "shaded_neutral", "jamm")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Uh, okay???", "shock", "susie")
                    else
    					cutscene:showNametag("Jamm")
    					cutscene:text("* The heck IS this place?", "worried", "jamm")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Beats me.", "nervous_side", "susie")
    					cutscene:text("* I feel like I'm dreaming,[wait:5] but...", "nervous", "susie")
    					cutscene:text("* This feels so real...", "nervous_side", "susie")
    					dess:setFacing("down")
    					cutscene:text("* And uh,[wait:5] SHE's here too.", "suspicious", "susie")
    					cutscene:showNametag("Dess")
    					cutscene:text("* 'tis a pleasure to be here", "condescending", "dess")
    					cutscene:showNametag("Susie")
    					cutscene:text("* ... Of course...", "suspicious", "susie")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* Well,[wait:5] we might as well try and find where we are.", "neutral", "jamm")
    					cutscene:text("* Follow me,[wait:5] guys.", "smug", "jamm")
    					dess:setFacing("right")
    					cutscene:showNametag("Dess")
    					cutscene:text("* hey you were the leader last time", "angry", "dess")
    					cutscene:text("* it's my turn to be the cool and swag party leader", "challenging", "dess")
    					jamm:setFacing("left")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* Hell no![wait:10] You had your chance already,[wait:5] Dess!", "determined", "jamm")
    					cutscene:text("* And frankly,[wait:5] you were a terrible leader.", "stern", "jamm")
    					cutscene:showNametag("Dess")
    					cutscene:text("* aw c'mon that was my first time cut me some slack", "neutral", "dess")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* Well I am NOT following you.", "determined", "jamm")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Uhh...", "sus_nervous", "susie")
    					cutscene:showNametag("Dess")
    					cutscene:text("* well I'm not following you either", "angry", "dess")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Guys...", "sus_nervous", "susie")
    					jamm:setFacing("down")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* I'm sure Susie would agree I'd be the better leader,[wait:5] right?", "smirk", "jamm")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Well I mean,[wait:5] I wasn't there when-", "nervous", "susie")
    					dess:setFacing("down")
    					cutscene:showNametag("Dess")
    					cutscene:text("* nuh uh,[wait:5] Susie would think I'M the better leader", "neutral_c", "dess")
    					cutscene:text("* I even offered her to smoke a ciggie with me", "condescending", "dess")
    					cutscene:showNametag("Susie")
    					cutscene:text("* I-", "shock", "susie")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* Oh please,[wait:5] she hates you just as much as I do.", "stern", "jamm")
    					jamm:setFacing("left")
    					cutscene:text("[noskip]* Now kindly stop nagging about being the leader or else I'll-", "determined", "jamm", {auto = true})
    					jamm:setFacing("down")
    					cutscene:showNametag("Susie")
    					cutscene:text("* WILL THE BOTH OF YOU JUST SHUT UP ALREADY?!", "teeth_b", "susie")
    					cutscene:showNametag("Dess")
    					cutscene:text("* ", "wtf_b", "dess")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* ", "nervous", "jamm")
    					cutscene:showNametag("Susie")
    					cutscene:text("* Thank you.", "teeth", "susie")
    					cutscene:text("* Here,[wait:5] how about this.", "smirk", "susie")
    					cutscene:text("* Since neither of you can agree on a leader,[wait:5] I'LL lead the way.", "teeth_smile", "susie")
    					cutscene:text("* I have experience with that too.", "small_smile", "susie")
    					cutscene:showNametag("Jamm")
    					cutscene:text("* I mean,[wait:5] sounds like a good compromise to me.", "side_smile", "jamm")
    					cutscene:showNametag("Dess")
    					cutscene:text("* ...", "neutral_b", "dess")
    					cutscene:text("* fine", "neutral", "dess")
                    end
    				cutscene:hideNametag()
					cutscene:wait(cutscene:attachFollowers())
					local susie_party = Game:getPartyMember("susie")
        			susie_party.has_act = true
        			Game:setFlag("susie_canact", true)
        			cutscene:text("* Susie can now use ACTs![wait:20]\n\n* ... Again!")
					Game:setFlag("thoughts_kills", Game:getFlag("library_kills"))
				end
			else
				cutscene:text("* You decide not to.")
			end
		else
			cutscene:text("* This area is currently locked.")
			cutscene:text("* You still need to do the following:")
			if not Game:getFlag("jamm_closure") then
				cutscene:text("* Complete the quest \"Jamm's Closure\".")
			end
			if not Game:hasPartyMember("susie") or not Game:hasPartyMember("dess") or not Game:hasPartyMember("jamm") then
				cutscene:text("* Have Susie,[wait:5] Dess,[wait:5] and Jamm in your party.")
			end
			if not Game:getFlag("berdly_inparty") then
				cutscene:text("* Rescue Berdly.")
			end
			cutscene:text("* Come back when have done that.")
			cutscene:text("* Oh uh and technically you also need to defeat Spamgolor NEO.")
			cutscene:text("* But he's not finished yet so you don't have to worry about that.")
		end
	end,
}
