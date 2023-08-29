return {
    left_dresser = function(cutscene, event)
        cutscene:text("* The dresser is full with clothes.")
        cutscene:text("* Clothes for a man and clothes for a woman...")
        cutscene:text("* The dresser is pretty cramped.")
    end,
	
    right_dresser = function(cutscene, event)
        cutscene:text("* The dresser is full of teenage girls' clothing.")
        cutscene:text("* That being said,[wait:5] the dresser isn't actually very full.")
    end,
	
    marcy_bed = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
	
		cutscene:showNametag("Marcy")
        cutscene:text("[voice:marcy]* Um.[wait:5].[wait:5].[wait:5] Excuse Marcy.[wait:5].[wait:5].", "neutral", "marcy")
        cutscene:text("[voice:marcy]* But what are you doing with Marcy's bed?", "neutral", "marcy")
		
		if susie then
			cutscene:showNametag("Susie")
            cutscene:text("[voice:susie]* We're raiding it for crumbs.", "smile", "susie")
			
			cutscene:showNametag("Marcy")
			cutscene:text("[voice:marcy]* Wh-what!?", "surprised", "marcy")
		end
        cutscene:hideNametag()
    end,
	
    jamm_bed = function(cutscene, event)
		cutscene:text("* Feeling the bed,[wait:5] it seems to be used a lot.")
		cutscene:text("* ...Moreso on the left.")
    end,
	
    cuck_chair = function(cutscene, event)
		cutscene:text("* Of course,[wait:5] it wouldn't be a hotel without a cuck chair.")
    end,
	
    cage = function(cutscene, event)
		cutscene:text("* A simple birdcage sits empty upon a pole.")
		cutscene:text("* If something goes in,[wait:5] it doesn't escape.")
    end,
	
    marcy = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local brandon = cutscene:getCharacter("brandon")
		local dess = cutscene:getCharacter("dess")
	
		cutscene:showNametag("Marcy")
        cutscene:text("[voice:marcy]* H-hello!", "happy", "marcy")
        cutscene:text("[voice:marcy]* Marcy is happy that you decided to visit!", "smile", "marcy")
        cutscene:text("[voice:marcy]* Papa is very busy, but he says Marcy can have friends over.", "smile", "marcy")
		
		local choice = cutscene:choicer({"You", "Father", "Locket", "Nothing"})
		
		if choice == 1 then
			cutscene:showNametag("Marcy")
			cutscene:text("[voice:marcy]* You want to know more about Marcy?", "confused", "marcy")
			cutscene:text("[voice:marcy]* Well,[wait:5] Marcy doesn't have a lot to her.", "neutral", "marcy")
			cutscene:text("[voice:marcy]* Marcy is still a simple child,[wait:5] as you can see.", "neutral", "marcy")
			cutscene:text("[voice:marcy]* But.[wait:5].[wait:5]. Marcy has been to the light,[wait:5] but hasn't seen much of it.", "frown", "marcy")
			
			if brandon then
				cutscene:showNametag("Brandon")
				cutscene:text("* Huh?[wait:5]\nBut I thought you were a lightner?", "shock", "brandon")
			elseif susie then
				cutscene:showNametag("Susie")
				cutscene:text("[voice:susie]* You don't look like a darkner.", "nervous", "susie")
			end
			
			if brandon or susie then
				cutscene:showNametag("Marcy")
				cutscene:text("[voice:marcy]* Papa and mama are both lightners,[wait:5] but...", "frown", "marcy")
				cutscene:text("[voice:marcy]* But Marcy gets really sick in the light world.", "frown", "marcy")
				cutscene:text("[voice:marcy]* Marcy doesn't know why. She just wants to see it.", "frown_open", "marcy")
				
				if susie then
					cutscene:showNametag("Susie")
					cutscene:text("[voice:susie]* ...", "shy_down", "susie")
					cutscene:text("[voice:susie]* .[wait:5].[wait:5].[wait:5]Hey.", "neutral", "susie")
					cutscene:text("[voice:susie]* I know that you'll see the light world someday.", "nervous_side", "susie")
					cutscene:text("[voice:susie]* We all have things we want to achieve,[wait:5] and...", "sincere", "susie")
					cutscene:text("[voice:susie]* Well,[wait:5] you just have to keep trying.", "sincere_smile", "susie")
					
					if brandon then
						cutscene:showNametag("Brandon")
						cutscene:text("* Susie is right,[wait:5] Marcy.", "happy", "brandon")
						cutscene:text("* Nothing good is worth waiting for.[wait:5] You have to make it happen.", "happy_b", "brandon")
					end
					
					cutscene:showNametag("Marcy")
					cutscene:text("[voice:marcy]* Y-you really think Marcy can see the light world someday?", "surprised", "marcy")
					
					if dess then
						cutscene:showNametag("Dess")
						cutscene:text("* lol no you fucking suck", "condescending", "dess")
						
						cutscene:showNametag("Susie")
						cutscene:text("[voice:susie]* DESS!", "angry", "susie")
						
						cutscene:showNametag("Dess")
						cutscene:text("* i'm not wrong lmao", "condescending", "dess")
					else
						cutscene:hideNametag()
						cutscene:text("* You don't say it,[wait:5] but Marcy seems pretty weak.")
					
						cutscene:showNametag("Marcy")
						cutscene:text("[voice:marcy]* Oh,[wait:5] I'm stronger than I actually seem.", "disappointed", "marcy")
						
						cutscene:showNametag("Susie")
						cutscene:text("[voice:susie]* (Who's she talking to?)", "nervous_side", "susie")
						
						if brandon then
							cutscene:showNametag("Brandon")
							cutscene:text("* (I have no idea.)", "shock", "brandon")
						end
					end
				end
			end
		elseif choice == 2 then
			if Game:getFlag("acj_marcy", false) then
				if brandon then
					cutscene:showNametag("Brandon")
					cutscene:text("* So where is Acoustic,[wait:5] by the way?", "neutral", "brandon")
				else
					cutscene:showNametag("Marcy")
					cutscene:text("[voice:marcy]* Huh?[wait:5]\n* Where is papa?", "confused", "marcy")
				end
				
				cutscene:showNametag("Marcy")
				cutscene:text("[voice:marcy]* Marcy doesn't know where papa is.", "confused", "marcy")
				cutscene:text("[voice:marcy]* Marcy thinks papa is busy at work or something.", "confused", "marcy")
				cutscene:text("[voice:marcy]* Although.[wait:5].[wait:5].[wait:5] Marcy did hear him say[wait:5] \"[color:b8b8b8]TOMBSITE[color:white]\",[wait:5] or something like that.", "neutral", "marcy")
				cutscene:text("[voice:marcy]* Marcy doesn't know what it means.", "confused", "marcy")
				if Game:getFlag("marcy_father", false) == false then
					Kristal.callEvent("createQuest", "AcousticFamily", "acj", "AcousticJamm's daughter, Marcy, states that her father mentioned a \"TOMBSITE\" when leaving the room. Where could he have gone, and what does the TOMBSITE mean?")
					Game:setFlag("marcy_father", true)
				end
			else
				cutscene:showNametag("Marcy")
				cutscene:text("[voice:marcy]* Yay! You found papa!", "smile", "marcy")
			end
		elseif choice == 3 then
			cutscene:showNametag("Marcy")
			cutscene:text("[voice:marcy]* Oh,[wait:5] this locket?", "confused", "marcy")
			cutscene:text("[voice:marcy]* Mama gave Marcy this locket a while back.", "neutral", "marcy")
			cutscene:text("[voice:marcy]* It's been a while since Marcy saw her,[wait:5] so.[wait:5].[wait:5].", "frown", "marcy")
			cutscene:text("[voice:marcy]* So Marcy sometimes looks inside and sees mama's face.", "smile", "marcy")
			cutscene:text("[voice:marcy]* Marcy wishes mama would come back.", "sad", "marcy")
		end
        cutscene:hideNametag()
    end,
	
    note = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
	
		if Game:getFlag("fake_jamm") then
			if Game.party[1].id ~= "jamm" then
				cutscene:showNametag("Jamm")
				cutscene:text("* Hey, do you think you could respect my privacy, maybe?", "neutral", "jamm")
			end
		else
			cutscene:showNametag("Marcy")
			cutscene:text("[voice:marcy]* H-hey, papa doesn't like Marcy reading his notes...", "frown", "marcy")
			
			if susie then
				cutscene:showNametag("Susie")
				cutscene:text("[voice:susie]* What!? You serious!?", "shock", "susie")
				cutscene:text("[voice:susie]* You're really gonna let your father stop you when he's gone?", "smile", "susie")
			end
		end
        cutscene:hideNametag()
		
		if cutscene:choicer({"Read", "Don't"}) == 1 then
			cutscene:text("* The notes seem to be the plot for Deoxynn Act 2.")
			cutscene:text("* ...")
			cutscene:text("* You did not expect that.")
		else
			cutscene:text("* Despite your curiosity, you decide not to read the notes.")
		end
    end,
	
    marcy_pre = function(cutscene, event)
		cutscene:showNametag("Marcy")
		if Game:getFlag("acj_marcy", false) then
			cutscene:text("[voice:marcy]* Marcy is going to have a lot of fun!", "smile", "marcy")
		else
			cutscene:text("[voice:marcy]* O-oh, hello!", "neutral", "marcy")
			cutscene:text("[voice:marcy]* Are you the friends papa said would visit Marcy?", "neutral", "marcy")
			cutscene:hideNametag()
			
			if cutscene:choicer({"Yes", "No"}) == 1 then
				cutscene:showNametag("Marcy")
				cutscene:text("[voice:marcy]* Y-yay!", "happy", "marcy")
				cutscene:text("[voice:marcy]* Papa's hotel room is room 003!", "smile", "marcy")
				cutscene:text("[voice:marcy]* Just knock and Marcy will let you in!", "smile", "marcy")
				Game:setFlag("acj_marcy", true)
			else
				cutscene:showNametag("Marcy")
				cutscene:text("[voice:marcy]* O-oh...", "sad", "marcy")
			end
		end
        cutscene:hideNametag()
    end,

    transition = function(cutscene, event)
        Game.world:mapTransition("devhotel1", "door_003")
    end,
	
    jamm = function(cutscene, event)
		local function jammPartyOpinion(id)
            cutscene:showNametag("Jamm")
            if id == "YOU" then
				cutscene:text("* Oh, you must be YOU.", "neutral", "jamm")
				cutscene:text("* I'll be honest, I never played your mod.", "look_left", "jamm")
				cutscene:text("* Sorry about that.", "nervous", "jamm")
				cutscene:text("* From what I hear, though, you've had quite the adventure.", "side_smile", "jamm")
				cutscene:text("* Keep that main character energy going!", "smug", "jamm")
            elseif id == "susie" then
				cutscene:text("* Well, if it isn't the brute herself.", "smirk", "jamm")
				cutscene:text("* You've had quite the character arc in chapter 1.", "smirk", "jamm")
				cutscene:text("* Honestly, I would've preferred if you didn't change.", "neutral", "jamm")
				cutscene:text("* I mean, I like the new you, but...", "nervous", "jamm")
				cutscene:text("* Fact is, I just prefer the gameplay.", "snile", "jamm")
				cutscene:text("* I like the idea of trying to protect the enemies.", "happy", "jamm")
				cutscene:text("* It's... kinda why I made Deoxynn.", "smile", "jamm")
				cutscene:text("* (Toggle Susie's autofight?)")
				if cutscene:choicer({"Enable", "Disable"}) == 1 then
					Game:getPartyMember("susie"):setFlag("auto_attack", true)
				else
					Game:getPartyMember("susie"):setFlag("auto_attack", false)
				end
            elseif id == "dess" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "dumbie" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "kris" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "noelle" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "ralsei" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "brandon" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "jamm" then
				cutscene:text("[speed:0.3]* ...", "stern", "jamm")
				cutscene:text("* Okay, why?", "stern", "jamm")
				cutscene:text("* Did you think you'd find a secret here?", "determined", "jamm")
				cutscene:text("* Get a special achievement, maybe?", "determined", "jamm")
				cutscene:text("* No, just for this, I'm deleting your save file.", "determined", "jamm")
				cutscene:text("* You want to deal with files? We'll deal with files.", "smug", "jamm")
				cutscene:text("* Say goodbye to this save file.", "smug", "jamm")
				cutscene:text("* Better hope you have a back-up.", "smug", "jamm")
				cutscene:hideNametag()
				
				cutscene:wait(3)
				
				cutscene:showNametag("Jamm")
				cutscene:text("* ...You thought I was being serious, didn't you?", "troll", "jamm")
				cutscene:text("* You should've seen the look on your face, I bet it was priceless!", "happy", "jamm")
				cutscene:text("* I bet you learned a valuable lesson today.", "smile", "jamm")
				cutscene:text("* Not all developers like it when you cheat for impossible stuff.", "stern", "jamm")
            end
        end
        local function checkMember(number, id)
            id = Game.party[number].id
            jammPartyOpinion(id)
        end
		local susie = cutscene:getCharacter("susie")
		local brandon = cutscene:getCharacter("brandon")
		local dess = cutscene:getCharacter("dess")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Oh, hey, guys! Nice seeing you again!", "smile", "jamm")
		cutscene:text("* I've just been keeping my daughter company, is all.", "smile", "jamm")
		cutscene:text("* Did you want to talk about something?", "smile", "jamm")
		cutscene:hideNametag()
		
		local choice = cutscene:choicer({"Wife", "Marcy", "Enzio", "Party"})
		if choice == 1 then
			cutscene:showNametag("Jamm")
			cutscene:text("* You want to know about my wife?", "neutral", "jamm")
			cutscene:text("* Ania was an amazing woman, that's for sure.", "peace", "jamm")
			cutscene:text("* She was smart, helpful, caring...", "peace", "jamm")
			cutscene:text("* And honestly, we knew each other since we were children.", "peace", "jamm")
			cutscene:text("* Ania... was perfect.", "eyes_closed_neutral", "jamm")
			cutscene:text("* I told Marcy about her death, and she knows it well.", "eyes_closed_neutral", "jamm")
			cutscene:text("* She's just... still in denial. After all this time.", "eyes_closed_frown", "jamm")
		elseif choice == 2 then
			cutscene:showNametag("Jamm")
			cutscene:text("* Marcy is a great child. I couldn't ask for better.", "smile", "jamm")
			cutscene:text("* She's always been a curious child, and I love that.", "side_smile", "jamm")
			cutscene:text("* Unfortunately, she can be a little slow...", "look_left", "jamm")
			cutscene:text("* But that gives me all the more time to help, right?", "smile", "jamm")
			cutscene:text("* Marcy also always wanted to see the light, but...", "smile", "jamm")
			cutscene:text("* She has a condition that makes her ill when she's there.", "nervous", "jamm")
			cutscene:text("* I... guess it doesn't help that she was born in the dark.", "nervous_left", "jamm")
			cutscene:text("* Marcy hasn't given up hope, though, and I'm with her all the way!", "smug", "jamm")
		elseif choice == 3 then
			cutscene:showNametag("Jamm")
			cutscene:text("* Enzio, right...", "shaded_frown", "jamm")
			cutscene:text("* He's kinda the whole reason I'm in this condition.", "shaded_frown", "jamm")
			cutscene:text("* Let's just say... I have nothing but resentment for him.", "shaded_pisses", "jamm")
			if not Game:getFlag("video_jamm") then
				cutscene:text("* This should give you all the answers you need.", "shaded_frown", "jamm")
				cutscene:hideNametag()
				cutscene:text("* (You got Jamm's video tape!)")
				Game.inventory:addItem("videotape_jamm")
				Game:setFlag("video_jamm", true)
			end
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Alright, let's see what I have to say about your party.", "side_smile", "jamm")
			cutscene:text("* And who knows? Maybe your attitude will change from this.", "smile", "jamm")
			cutscene:text("* ...That is, if you want it to.", "neutral", "jamm")
			cutscene:text("* Anyone in specific you want to discuss?", "smile", "jamm")
            local partyOptions = {}
            for _, party in ipairs(Game.party) do
                table.insert(partyOptions, party.name)
            end
            cutscene:hideNametag()
            local number = cutscene:choicer(partyOptions)
            checkMember(number)
		end
		cutscene:hideNametag()
    end,
}
