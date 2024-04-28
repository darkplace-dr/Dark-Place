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
		local brenda = cutscene:getCharacter("brenda")
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
			
			if brenda then
				cutscene:showNametag("Brenda")
				cutscene:text("* Huh?[wait:5]\nBut I thought you were a lightner?", "shock", "brenda")
			elseif susie then
				cutscene:showNametag("Susie")
				cutscene:text("[voice:susie]* You don't look like a darkner.", "nervous", "susie")
			end
			
			if brenda or susie then
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
					
					if brenda then
						cutscene:showNametag("Brenda")
						cutscene:text("* Susie is right,[wait:5] Marcy.", "happy", "brenda")
						cutscene:text("* Nothing good is worth waiting for.[wait:5] You have to make it happen.", "happy_b", "brenda")
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
						
						if brenda then
							cutscene:showNametag("Brenda")
							cutscene:text("* (I have no idea.)", "shock", "brenda")
						end
					end
				end
			end
		elseif choice == 2 then
			if not Game:getFlag("fake_jamm", false) then
				if brenda then
					cutscene:showNametag("Brenda")
					cutscene:text("* So where is Acoustic,[wait:5] by the way?", "neutral", "brenda")
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
				if Game:getFlag("dungeonkiller") then
					cutscene:text("[voice:marcy]* But...\n* Marcy sees papa is concerned...", "sad", "marcy")
					cutscene:text("[voice:marcy]* Marcy is worried...\n* Did something happen to papa?", "sad", "marcy")
				end
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
		
		if Game:getFlag("dungeonkiller") then
			cutscene:showNametag("Jamm")
			cutscene:text("* Respect my privacy, please.", "neutral", "jamm")
			cutscene:hideNametag()
			return
		end
	
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
				cutscene:text("* Oh,[wait:5] you must be YOU.", "neutral", "jamm")
				cutscene:text("* I'll be honest,[wait:5] I never played your mod.", "look_left", "jamm")
				cutscene:text("* Sorry about that.", "nervous", "jamm")
				cutscene:text("* From what I hear,[wait:5] though,[wait:5] you've had quite the adventure.", "side_smile", "jamm")
				cutscene:text("* Keep that main character energy going!", "smug", "jamm")
            elseif id == "susie" then
				cutscene:text("* Well,[wait:5] if it isn't the brute herself.", "smirk", "jamm")
				cutscene:text("* You've had quite the character arc in chapter 1.", "smirk", "jamm")
				cutscene:text("* Honestly,[wait:5] I would've preferred if you didn't change.", "neutral", "jamm")
				cutscene:text("* I mean,[wait:5] I like the new you,[wait:5] but...", "nervous", "jamm")
				cutscene:text("* Fact is,[wait:5] I just prefer the gameplay.", "smile", "jamm")
				cutscene:text("* I like the idea of trying to protect the enemies.", "happy", "jamm")
				cutscene:text("* It's...[wait:5] kinda why I made Deoxynn.", "smile", "jamm")
				cutscene:hideNametag()
				cutscene:text("* (Toggle Susie's autofight?)")
				if cutscene:choicer({"Enable", "Disable"}) == 1 then
					Game:getPartyMember("susie"):setFlag("auto_attack", true)
				else
					Game:getPartyMember("susie"):setFlag("auto_attack", false)
				end
            elseif id == "dess" then
				if Game:getFlag("dungeonkiller") then
					cutscene:text("* Yeah,[wait:5] no,[wait:5] we shouldn't take any chances.", "stern", "jamm")
					cutscene:text("* Let's make you more peaceful with your spells.", "stern", "jamm")
				else
					cutscene:text("* Ah,[wait:5] Dess.[wait:5]\n* How's the most hated party member?", "smirk", "jamm")
					cutscene:text("* Y'know,[wait:5] I had a talk with your creator recently...", "smirk", "jamm")
					cutscene:text("* Char had told me you had some interesting mechanics.", "wink", "jamm")
					cutscene:text("* Something about [color:yellow]pacifist-oriented spells[color:white], right?", "side_smile", "jamm")
					cutscene:text("* I feel like these spells will make you slightly less annoying.", "smile", "jamm")
					cutscene:text("* ...Slightly.", "nervous_left", "jamm")
				end
				cutscene:hideNametag()
				cutscene:text("* (Toggle Dess's pacifist spells?)")
				if cutscene:choicer({"Enable", "Disable"}) == 1 then
					if not Game:getFlag("acj_dess_pacifist") then
						Game:setFlag("acj_dess_pacifist", true)
						Game:getPartyMember("dess"):removeSpell("starshot")
						Game:getPartyMember("dess"):addSpell("peace")
						if Game:getPartyMember("dess"):hasSpell("starstorm") then
							Game:getPartyMember("dess"):removeSpell("starstorm")
							Game:getPartyMember("dess"):addSpell("peacelove")
						end
					end
				else
					if Game:getFlag("acj_dess_pacifist") then
						Game:setFlag("acj_dess_pacifist", false)
						Game:getPartyMember("dess"):addSpell("starshot")
						Game:getPartyMember("dess"):removeSpell("peace")
						if Game:getPartyMember("dess"):hasSpell("peacelove") then
							Game:getPartyMember("dess"):removeSpell("peacelove")
							Game:getPartyMember("dess"):addSpell("starstorm")
						end
					end
				end
            elseif id == "dumbie" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "kris" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "noelle" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "ralsei" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "brenda" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "berdly" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "pauling" then
				cutscene:text("* (WIP, check back in a future update)", "neutral", "jamm")
            elseif id == "ceroba" then
				cutscene:text("* Ah.[wait:5]\n* Ceroba.", "worried", "jamm")
				cutscene:text("* The last one left in her family,[wait:5] perhaps bloodline.", "worried", "jamm")
				cutscene:text("* Now that I think about it,[wait:5] we're pretty similar.", "worried", "jamm")
				cutscene:text("* Losing the ones we love,[wait:5] finding secrets from them...", "worried", "jamm")
				cutscene:text("* With the obvious exception that Marcy is alive.", "worried", "jamm")
				cutscene:text("* What are you trying to say?", "neutral", "ceroba")
				cutscene:text("* What,[wait:5] you actually thought I meant something by that?", "nervous", "jamm")
				cutscene:text("* All I'm saying is I understand you.", "neutral", "jamm")
				cutscene:text("* I understand what you did and why you did it.", "neutral", "jamm")
				cutscene:text("* Now,[wait:5] normally,[wait:5] I'd have some big gameplay twist ready.", "smile", "jamm")
				cutscene:text("* I can't really think of any twists for you at the moment...", "neutral", "jamm")
				cutscene:text("* But keep in contact,[wait:5] because I might think of something.", "side_smile", "jamm")
            elseif id == "jamm" then
				cutscene:text("[speed:0.3]* ...", "stern", "jamm")
				cutscene:text("* Okay,[wait:5] why?", "stern", "jamm")
				cutscene:text("* Did you think you'd find a secret here?", "determined", "jamm")
				cutscene:text("* Get a special achievement,[wait:5] maybe?", "determined", "jamm")
				cutscene:text("* No,[wait:5] just for this,[wait:5] I'm deleting your save file.", "determined", "jamm")
				cutscene:text("* You want to deal with files?[wait:5] We'll deal with files.", "smug", "jamm")
				cutscene:text("* Say goodbye to this save file.", "smug", "jamm")
				cutscene:text("* Better hope you have a back-up.", "smug", "jamm")
				cutscene:hideNametag()
				
				cutscene:wait(3)
				
				cutscene:showNametag("Jamm")
				cutscene:text("* ...You thought I was being serious,[wait:5] didn't you?", "troll", "jamm")
				cutscene:text("* You should've seen the look on your face,[wait:5] I bet it was priceless!", "happy", "jamm")
				cutscene:text("* I bet you learned a valuable lesson today.", "smile", "jamm")
				cutscene:text("* Not all developers like it when you cheat for impossible stuff.", "stern", "jamm")
            elseif id == "mario" then
				cutscene:text("* Well,[wait:5] well,[wait:5] well.[wait:5]\n* Never thought I'd see you here.", "troll", "jamm")
				cutscene:text("* Mario from SMG4.[wait:5]\n* I still watch that guy.", "troll", "jamm")
				cutscene:text("* I get it.[wait:5]\n* Jumpman can't jump here,[wait:5] right?", "troll", "jamm")
				cutscene:text("* Well,[wait:5] what if we took your hammer away?", "troll", "jamm")
				cutscene:text("* Let's see what you can do without it.", "troll", "jamm")
				cutscene:hideNametag()
				cutscene:text("* (Toggle Mario's fight button?)")
				if cutscene:choicer({"Enable", "Disable"}) == 1 then
					Game:setFlag("acj_mario_fightless", false)
				else
					Game:setFlag("acj_mario_fightless", true)
				end
            end
        end
        local function checkMember(number, id)
            id = Game.party[number].id
            jammPartyOpinion(id)
        end
		local susie = cutscene:getCharacter("susie")
		local brenda = cutscene:getCharacter("brenda")
		local dess = cutscene:getCharacter("dess")
		
		cutscene:showNametag("Jamm")
		if Game:getFlag("dungeonkiller") then
			cutscene:text("* Oh,[wait:5] hey.", "neutral", "jamm")
		else
			cutscene:text("* Oh,[wait:5] hey,[wait:5] guys![wait:5] Nice seeing you again!", "smile", "jamm")
			cutscene:text("* I've just been keeping my daughter company, is all.", "smile", "jamm")
			cutscene:text("* Did you want to talk about something?", "smile", "jamm")
		end
		cutscene:hideNametag()
		
		local list = {"Wife", "Marcy", "Enzio", "Party"}
		local colors = {{1,1,1},{1,1,1},{1,1,1},{1,1,1}}
		if Game:getFlag("jaruHasTalkedAboutAlexa") and not Game:getFlag("jammHasTalkedAboutAlexa") then
			list = {"Wife", "Marcy", "Enzio", "Alexa"}
			colors = {{1,1,1},{1,1,1},{1,1,1},{1,1,0}}
		end
		
		local choice = cutscene:choicer(list, {color=colors})
		if choice == 1 then
			cutscene:showNametag("Jamm")
			cutscene:text("* You want to know about my wife?", "neutral", "jamm")
			cutscene:text("* Ania was an amazing woman,[wait:5] that's for sure.", "smile", "jamm")
			cutscene:text("* She was smart,[wait:5] helpful,[wait:5] caring...", "smile", "jamm")
			cutscene:text("* And honestly, we knew each other since we were children.", "smile", "jamm")
			cutscene:text("* Ania...[wait:5] was perfect.", "neutral", "jamm")
			cutscene:text("* I told Marcy about her death,[wait:5] and she knows it well.", "shaded_neutral", "jamm")
			cutscene:text("* She's just...[wait:5] still in denial.[wait:5] After all this time.", "shaded_neutral", "jamm")
		elseif choice == 2 then
			cutscene:showNametag("Jamm")
			cutscene:text("* Marcy is a great child.[wait:5] I couldn't ask for better.", "smile", "jamm")
			cutscene:text("* She's always been a curious child,[wait:5] and I love that.", "side_smile", "jamm")
			cutscene:text("* Unfortunately,[wait:5] she can be a little slow...", "look_left", "jamm")
			cutscene:text("* But that gives me all the more time to help,[wait:5] right?", "smile", "jamm")
			cutscene:text("* Marcy also always wanted to see the light,[wait:5] but...", "smile", "jamm")
			cutscene:text("* She has a condition that makes her ill when she's there.", "nervous", "jamm")
			cutscene:text("* I...[wait:5] guess it doesn't help that she was born in the dark.", "nervous_left", "jamm")
			cutscene:text("* Marcy hasn't given up hope,[wait:5] though,[wait:5] and I'm with her all the way!", "smug", "jamm")
		elseif choice == 3 then
			cutscene:showNametag("Jamm")
			cutscene:text("* Enzio,[wait:5] right...", "shaded_frown", "jamm")
			cutscene:text("* He's kinda the whole reason I'm in this condition.", "shaded_frown", "jamm")
			cutscene:text("* Let's just say...[wait:5] I have nothing but resentment for him.", "shaded_pissed", "jamm")
			if not Game:getFlag("video_jamm") then
				cutscene:text("* This should give you all the answers you need.", "shaded_frown", "jamm")
				cutscene:hideNametag()
				cutscene:text("* (You got Jamm's video tape!)")
				Game.inventory:addItem("videotape_jamm")
				Game:setFlag("video_jamm", true)
			end
		else
			if list[4] == "Alexa" then
				cutscene:showNametag("Jamm")
				cutscene:text("* Huh?[wait:5]\n* You want to know more about Alexa?", "neutral", "jamm")
				cutscene:text("* Where she came from?[wait:5]\n* Yeah, I can tell you.", "neutral", "jamm")
				cutscene:text("* It all started when I found this [color:yellow]time machine[color:white]...", "neutral", "jamm")
				cutscene:text("* Actually,[wait:5] it was more like a time-and-place machine.", "neutral", "jamm")
				cutscene:text("* I noticed there was already a destination set,[wait:5] so I pressed it.", "neutral", "jamm")
				cutscene:text("* Yes,[wait:5] I know![wait:5] It was irresponsible!", "nervous", "jamm")
				cutscene:text("* However,[wait:5] keep in mind this was before I married Ania,[wait:5] okay?", "nervous_left", "jamm")
				cutscene:text("* A-anyways,[wait:5] I ended up on this world called \"Europa\".", "look_left", "jamm")
				cutscene:text("* In this town called Frivatown,[wait:5] actually.", "neutral", "jamm")
				cutscene:text("* Alexa was one of the first people I met while I was there.", "look_left", "jamm")
				cutscene:text("* I stayed on Europa for a few days,[wait:5] trading stories and such...", "side_smile", "jamm")
				cutscene:text("* I even went to the 158th Frivatown festival.", "smile", "jamm")
				cutscene:text("* Alexa and a few of her friends became curious about the Dark...", "neutral", "jamm")
				cutscene:text("* So,[wait:5] I brought them back. Let them do what they wanted to.", "side_smile", "jamm")
				cutscene:showNametag("J.A.R.U.")
				cutscene:text("* And so I gave Alexa that job,[wait:5] right?", "default", "shadowsalesman")
				cutscene:showNametag("Jamm")
				cutscene:text("* Well,[wait:5] yeah,[wait:5] it was right about that time.", "neutral", "jamm")
				cutscene:text("* Let me guess;[wait:5] we butt dialed you?", "stern", "jamm")
				cutscene:showNametag("J.A.R.U.")
				cutscene:text("* Yeah,[wait:5] but your story does put things into perspective.", "eye_closed", "shadowsalesman")
				cutscene:text("* However, let me ask;[wait:5] why are they still here?", "default", "shadowsalesman")
				cutscene:text("* Why didn't you bring them back using your time machine?", "default", "shadowsalesman")
				cutscene:showNametag("Jamm")
				cutscene:text("* I intended to,[wait:5] J.A.R.U.", "nervous", "jamm")
				cutscene:text("* However,[wait:5] the time machine broke when I used it the second time,[wait:5] so...", "neutral", "jamm")
				cutscene:text("* They became stuck,[wait:5] you know?", "worried", "jamm")
				cutscene:showNametag("J.A.R.U.")
				cutscene:text("* Right,[wait:5] that makes sense.", "oh", "shadowsalesman")
				cutscene:hideNametag()
				cutscene:text("* (Click.)")
				Game:setFlag("jammHasTalkedAboutAlexa", true)
			else
				cutscene:showNametag("Jamm")
				cutscene:text("* Alright,[wait:5] let's see what I have to say about your party.", "side_smile", "jamm")
				cutscene:text("* And who knows?[wait:5] Maybe your attitude will change from this.", "smile", "jamm")
				cutscene:text("* ...That is,[wait:5] if you want it to.", "neutral", "jamm")
				cutscene:text("* Anyone in specific you want to discuss?", "smile", "jamm")
				local partyOptions = {}
				for _, party in ipairs(Game.party) do
					table.insert(partyOptions, party.name)
				end
				cutscene:hideNametag()
				local number = cutscene:choicer(partyOptions)
				checkMember(number)
			end
		end
		cutscene:hideNametag()
    end,
}
