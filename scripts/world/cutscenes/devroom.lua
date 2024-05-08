return {
    brenda = function(cutscene, event)
        cutscene:showNametag("Brenda")
        if not Game:getFlag("brenda_talkedto") then
            if cutscene:getCharacter("kris") then
                cutscene:text("* Well,[wait:5] if it isn't Kris Deltarune themself.", "happy", "brenda")
                cutscene:showNametag("Susie")
                cutscene:text("* Okay,[wait:5] first of all,[wait:5] that isn't their last name.", "annoyed", "susie")
                cutscene:text("* Second of all,[wait:5] how the hell do you know their name?", "sus_nervous", "susie")
                cutscene:showNametag("Brenda")
                cutscene:text("* Eh,[wait:5] that isn't really important.", "happy", "brenda")
                cutscene:text("* Anyways...", "neutral", "brenda")
            end
            cutscene:text("* It's so cool that you guys showed up here.", "happy", "brenda")
            if cutscene:getCharacter("dess") then
                cutscene:text("* ... Minus one of you...", "miffed", "brenda")
                cutscene:showNametag("Dess")
                cutscene:text("* Gee I wonder who that could be lol", "condescending", "dess")
                cutscene:showNametag("Brenda")
            end
            cutscene:text("* Hey,[wait:5] could I join the party?", "happy", "brenda")
        else
            cutscene:text("* So,[wait:5] did you change your mind?", "happy", "brenda")
        end
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Yes", "No"})
        if opinion == 1 then
            cutscene:showNametag("Brenda")
            cutscene:text("* Nice,[wait:5] thanks!", "happy", "brenda")
            if #Game.party >= Game:getFlag("party_max") then
                cutscene:text("* Hold on,[wait:5] it looks like you've got a full party.", "neutral", "brenda")
                cutscene:text("* Well,[wait:5] I'll still be in your party.", "happy", "brenda")
                cutscene:text("* Just in the \"reserves\",[wait:5] so to speak.", "neutral", "brenda")
                cutscene:text("* If you want me to help in battles,[wait:5] head to the Party Room.", "happy", "brenda")
                event:setFacing("right")
                cutscene:text("* Go straight that way,[wait:5] it should be the first door on your left.", "happy", "brenda")
                event:setFacing("down")
                cutscene:text("* Cya!", "happy", "brenda")
                cutscene:hideNametag()
                cutscene:walkTo(event, -100, event.y + 50, 3, "left")
                cutscene:wait(2)
            else
                cutscene:hideNametag()
                Game:addPartyMember("brenda")
                Game:setFlag("brenda_party", true)
                event:convertToFollower(#Game.party)
                cutscene:attachFollowers()
                cutscene:text("* Brenda joined the party.")
                cutscene:wait(0.5)
            end
            Game:setFlag("brenda_inparty", true)
            Mod:unlockPartyMember("brenda")
        else
            cutscene:showNametag("Brenda")
            cutscene:text("* Ah,[wait:5] okay then.", "frown", "brenda")
            cutscene:text("* Well,[wait:5] I'm always here if you change your mind.", "happy", "brenda")
            Game:setFlag("brenda_talkedto", true)
        end
        cutscene:hideNametag()
    end,
	charshop = function(cutscene, event)
	
		if Game.inventory:hasItem("mistcard") then
			cutscene:showNametag("Char")
			cutscene:text("* Thank you lots.")
		else
		
			if not Game:getFlag("gotCharQuest1") then
				cutscene:showNametag("Char")
				cutscene:text("* Heya there.")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* So uhh...", "neutral_side", "susie")
					cutscene:text("* Who are you?", "neutral", "susie")
				else
					cutscene:hideNametag()
					cutscene:text("* (You ask him who he is.)")
				end
				
				cutscene:showNametag("Char")
				cutscene:text("* Oh, I'm Char.[wait:10]\n* Got kicked out of the main area so now I'm in the party room.")
				
				if cutscene:getCharacter("dess") then
					cutscene:showNametag("Dess")
					cutscene:text("* Oh yo me too", "condescending", "dess")
					cutscene:showNametag("Char")
					cutscene:text("* ...")
				end
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* So why did you get kicked out?", "neutral", "susie")
				else
					cutscene:hideNametag()
					cutscene:text("* (You asked why he got kicked out.)")
				end
				
				cutscene:showNametag("Char")
				cutscene:text("* Oh,[wait:5] I set fire to a table by accident.")
				cutscene:text("* But to be honest...")
				cutscene:text("* I think the decision to outright ban me was due to my part in helping to create Dess.")
				
				if cutscene:getCharacter("dess") then
					cutscene:showNametag("Dess")
					cutscene:text("* Thank ya for that", "heckyeah", "dess")
					cutscene:showNametag("Char")
					cutscene:text("* Yeah,[wait:5] sure,[wait:5] whatever.")
				end
				
				cutscene:text("* Also by the way I'm not technically supposed to be here either.")
				cutscene:text("* Please don't tell them I'm here.")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* Uhh,[wait:5] sure alright.", "nervous", "susie")
					cutscene:showNametag("Char")
				end
				
				
				cutscene:text("* Anyways...")
				
				cutscene:text("* That reminds me.[wait:10]\n* Trouble's afoot.")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* Hm?", "neutral", "susie")
					cutscene:showNametag("Char")
				end
				
				cutscene:text("* So like... there's this big forest right?")
				cutscene:text("* An uh,[wait:5] I was kinda just walking around in it when the fog suddenly got real dense.")
				cutscene:text("* Then the locals started to freak the heck out,[wait:5] so I took off.")
				cutscene:text("* I had a friend over there,[wait:5] and I don't quite like the thought of them being hurt.")
				cutscene:text("* You guys are like,[wait:5] heroes right?[wait:10]\n* Can you go take a look at it?")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* I guess we'll see what we can do??", "neutral_side", "susie")
				else
					cutscene:hideNametag()
					cutscene:text("* (You agreed without thinking about it for some reason.)")
				end
				
				cutscene:showNametag("Char")
				cutscene:text("* Great,[wait:10] you're the best.")
				
				cutscene:text("* Oh yeah, and [color:yellow]the code to get there is [color:blue]UWFOREST[color:reset].")
				
				cutscene:hideNametag()
				Game:setFlag("gotCharQuest1", true)
			else
				cutscene:showNametag("Char")
				cutscene:text("* Any updates yet?")
				
				if not Game:getFlag("finishedCharQuest1") then
					
					if cutscene:getCharacter("susie") then
						cutscene:showNametag("Susie")
						cutscene:text("* Nope.", "neutral", "susie")
					else
						cutscene:hideNametag()
						cutscene:text("* (You explain the current status.")
					end
					
					cutscene:showNametag("Char")
					cutscene:text("* Oh,[wait:10] dang.")
					
				else
					if cutscene:getCharacter("susie") then
						cutscene:showNametag("Susie")
						cutscene:text("* Yeah![wait:10] We fought a big ghost thing!", "surprise_smile", "susie")
					else
						cutscene:hideNametag()
						cutscene:text("* (You explain the current status.")
					end
					
					cutscene:showNametag("Char")
					cutscene:text("* Oh,[wait:5] sick.")
					cutscene:text("* Oh man,[wait:5] that must've been a lot of trouble though.")
					cutscene:text("* Lemmie see if I have anything on me...")
					cutscene:text("* ...[wait:10] oh,[wait:5] I see.")
					cutscene:text("* Here, take this.")
					
					local canTakeCard = Game.inventory:addItem("mistcard")
					
					if canTakeCard then
						cutscene:hideNametag()
						Assets:playSound("item")
						cutscene:text("* (You got the MistCard.)")
						cutscene:showNametag("Char")
						cutscene:text("* Thank you lots.")
					else
						cutscene:text("* ...")
						cutscene:text("* You don't have any more room for key items??")
						cutscene:text("* Man,[wait:5] what the hell even is this mod anymore if you accidentally see this text in-game.")
					end
				end
				
				
			end
		
		end
			
		cutscene:hideNametag()
	end,
    simbel = function(cutscene, event)
        local simbel = cutscene:getCharacter("simbel")
        local leader = Game.world.player
        local susie = cutscene:getCharacter("susie")

        cutscene:showNametag("Sam")
        cutscene:text("* ...", "phone_moment", "sam")
        if not Game:getFlag("interact_once_sam", false) then
            cutscene:text("* .....", "phone_moment", "sam")

            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* Uh...[wait:3] Hello?", "neutral", "susie")
                cutscene:showNametag("Sam")
            else
                cutscene:text("..?", "talk_look_away", "sam")
            end

            local s_facing = "left"
            if leader.facing == "down" then
                s_facing = "up"
            elseif leader.facing == "left" then
                s_facing = "right"
            else
                s_facing = "down"
            end

            simbel:setFacing(s_facing)

            cutscene:text("* A-[wait:2]Ah![wait:3] Hello!", "surprised_blush", "sam")
            cutscene:text("* Sorry,[wait:2] I was daydreaming...[wait:3] kinda?[wait:3] If time even exists here.", "shy_blush", "sam")

            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* Uh..[wait:3] Okay, I guess.", "neutral_side", "susie")
                cutscene:showNametag("Sam")
            end

            cutscene:text("* You guys are like,[wait:2] the legends of the Delta Rune, right?", "talk_look_away", "sam")

            if not cutscene:getCharacter("kris") then
                cutscene:text("* Actually wait,[wait:2] no,[wait:2] you're not Kris.", "dead_inside_b", "sam")
                if not susie then
                    cutscene:text("* Neither are you Susie actually...", "dead_inside", "sam")
                    cutscene:text("* Well that's a complete failure of an introduction...", "dead_inside", "sam")
                    cutscene:text("* ...", "huh_b", "sam")
                else
                    cutscene:showNametag("Susie")
                    if Game:getFlag("brenda_talkedto") then
                        cutscene:text("* Wait,[wait:2] how do you all know Kris's name??", "angry", "susie")
                    else
                        cutscene:text("* How do you know Kris's name?", "nervous_side", "susie")
                    end
                    cutscene:showNametag("Sam")
                    cutscene:text("* That's a long story I don't have the energy to explain.", "huh", "sam")
                end
            else
                if not susie then
                    cutscene:text("* Well uh... Without Susie, actually.")
                    cutscene:text("* H-[wait:2]Hey,[wait:2] don't look at me like that.", "shy_look_away", "sam")
                    cutscene:text("* The reason why I know her name is totally fine I swear!", "shy_look_away", "sam")
                else
                    cutscene:text("* But this your prophecy,[wait:2] uh..[wait:3] turned out fake...", "talk_look_away", "sam")
                    cutscene:text("* Can we still call you guys the heroes of the legend?", "talk_look_away", "sam")
                    cutscene:showNametag("Susie")
                    cutscene:text("* I mean...[wait:3] You've got a point.", "neutral", "susie")
                    cutscene:text("* But even if the prophecy means nothing,[wait:2] we're still the Delta Warriors,[wait:2] you know?", "neutral_side", "susie")
                    cutscene:text("* We're still gonna go on crazy adventures together,[wait:2] no matter what!", "smirk", "susie")
                    cutscene:text("* ...", "smirk", "susie")
                    cutscene:text("* Kris,[wait:1] stop with that little smile of yours!!", "angry_c")
                    cutscene:showNametag("Sam")
                    cutscene:text("* Ha ha![wait:3] Yeah,[wait:2] I guess you guys are fine even without the prophecy.", "eyes_closed_happy", "sam")
                end
            end
            cutscene:text("* So uh...[wait:2] Do you want to talk about something?", "shy_look_away", "sam")
            Game:setFlag("interact_once_sam", true)
        else
            local s_facing = "left"
            if leader.facing == "down" then
                s_facing = "up"
            elseif leader.facing == "left" then
                s_facing = "right"
            elseif leader.facing == "up" then
                s_facing = "down"
            end

            simbel:setFacing(s_facing)
            cutscene:text("* What's up?", "talk_look_away", "sam")
        end
        cutscene:hideNametag()
        local choices = {"Talk", "Party"}
        if Game:getFlag("meet_jeku", false) then
            table.insert(choices, "Jeku")
        elseif Game:getFlag("meet_jeku_empt", false) then
            table.insert(choices, "Empty shop")
        end
        table.insert(choices, "Nope")
        local c = cutscene:choicer(choices)
        cutscene:showNametag("Sam")
        if c == 1 then
            cutscene:text("* This world is pretty cool,[wait:2] honestly.", "talk_happy", "sam")
            cutscene:text("* Sometimes it feels like nothing more than a few ideas coming together.", "talk_happy_look_side", "sam")
            cutscene:text("* And sometimes it feels like a whole universe got linked to this one.", "happy_look_side", "sam")
            cutscene:text("* Imagination is just that powerful,[wait:2] I guess.[wait:3] Wouldn't you agree?", "eyes_closed_happy", "sam")
            if event.interact_count > 1 and not Game:getFlag("started_sphere_quest", false) then
                cutscene:text("* Actually, speaking of powerful...", "dead_inside", "sam")
                cutscene:text("* Can I ask you guys a favor?", "dead_inside_b", "sam")
                cutscene:text("* You see,[wait:2] when I went here,[wait:2] I took a powerful artefact with me.", "unsure", "sam")
                cutscene:text("* But on my way,[wait:2] she kinda slip out of my grasp.", "whoops", "sam")
                if susie then
                    cutscene:text("* I get it.[wait:3] And if it falls in bad hands,[wait:2] the world is doomed,[wait:2] right?", "smile", "susie")
                    cutscene:text("* Honestly,[wait:2] no.[wait:3] I'm not scared about the world.", "shy_look_away", "sam")
                    cutscene:text("* I'm more scared of the person who will try to absorb her power.", "scared_look_away", "sam")
                    cutscene:text("* Because they will go insane??", "sus_nervous", "susie")
                    cutscene:text("* No.[wait:3] Just that very few people can actually withstand her power.", "talk_look_away", "sam")
                    cutscene:text("* Like,[wait:2] even I can't withstand it for too long.", "unsure", "sam")
                    cutscene:text("* So if any random person were to absorb it...", "surprised_scared", "sam")
                    cutscene:text("* They'll be dead,[wait:2] right?", "nervous", "susie")
                    cutscene:text("* Yeah.[wait:3] Their physical form badly damaged and their SOUL destroyed.", "unsure", "sam")
                    cutscene:text("* Alright then,[wait:2] we'll get you that thing of yours back.", "smirk", "susie")
                    cutscene:text("* But uh...[wait:3] Any clues as to where to start?", "nervous", "susie")
                    cutscene:text("* Yeah.[wait:3] The warp bin can bring you to where I think she fell.", "talk_happy_look_side", "sam")
                else
                    cutscene:text("* If someone were to try to absorb her power...", "talk_look_away", "sam")
                    cutscene:text("* That would damage their physical form and their SOUL.", "unsure", "sam")
                    cutscene:text("* And while a crack on the skin is not much...", "shy_look_away", "sam")
                    cutscene:text("* A small crack on your SOUL can reduce your lifespan by a lot.", "shy_look_away", "sam")
                    cutscene:text("* And here, we're not talking about a small crack at all.", "unsure", "sam")
                    cutscene:text("* Hm?[wait:3] You will do it?", "surprised_b", "sam")
                    cutscene:text("* Thanks![wait:3] I have an idea of where she could have fell.", "eyes_closed_happy", "sam")
                    cutscene:text("* You should be able to access it with the warp bin.", "eyes_closed_happy", "sam")
                end
                cutscene:text("* The code is [color:yellow]CASTLERD[color:reset].", "happy_look_side", "sam")
                Kristal.callEvent("createQuest", "Green and Blue..?", "_gb", "Sam lost a powerful artefact of his when coming to the Dev Diner. Because someone might die from trying to use its power, it must be found as fast as possible! You could start by using this \"CASTLERD\" code he gave you?\n[QUEST UNFINISHED: CAN'T BE COMPLETED]")
                Game:setFlag("started_sphere_quest", true)
            end
        elseif c == 2 then
            cutscene:text("* Huh?[wait:3] You want me to join your party?", "surprised_b", "sam")
            cutscene:text("* Yeah no,[wait:2] I'm no good in a fight.", "shy_look_away", "sam")
            cutscene:text("* Well I do have powerful healing and defensive magic...", "whoops", "sam")
            cutscene:text("* But I'm more of the peaceful type of guy,[wait:2] you know?", "unsure", "sam")
            local first_word = "But"
            if Game:getFlag("weird") then
            	cutscene:text("* And you're not really set on a right path,[wait:2] am I wrong?", "neutral", "sam")
            elseif Game:getFlag("library_kills", 0) > 0 and Game:getFlag("library_kills", 0) <= 2 then
                cutscene:text("* And you don't seem to be the type to make peace, aren't you?", "talk_look_away", "sam")
            else
                local love = Mod:getPartyLove()

                if love >= 19 then
                    cutscene:text("* And I really don't like the way you're looking at me.", "scared_look_away", "sam")
                elseif love >= 15 then
                    cutscene:text("* And uh..[wait:3] You look like you could stab me at any moment so...", "shy_look_away", "sam")
                elseif love >= 12 then
                    cutscene:text("* And if the blood and dust on your hand is any indication...", "unsure", "sam")
                elseif love >= 10 then
                    cutscene:text("* And you look too miserable for peace,[wait:2] to be honest...", "phone_moment", "sam")
                elseif love >= 5 then
                    cutscene:text("* And you're, uh...[wait:3] Pretty bad, actually, at peace, to be honest.", "huh", "sam")
                elseif love >= 2 then
                    cutscene:text("* And uh..[wait:3] You don't seem to consider peace as an option, do you?", "shy_look_away", "sam")
                else
                    first_word = "Well"
                    cutscene:text("* Oh wait,[wait:2] you seems to be pretty peaceful too actually.", "shy_look_away", "sam")
                end
            end
            cutscene:text("* "..first_word.." even then,[wait:2] I won't join your party for now.", "neutral", "sam")
            cutscene:text("* You could say it's because of a skill issue.", "dead_inside_b", "sam")
        elseif c == 3 then
            if #choices == 4 then
                if Game:getFlag("meet_jeku") and Game:getFlag("meet_jeku_empt") then
                    if not Game:getFlag("meet_jeku_back") then
                        cutscene:text("* Huh?[wait:3] Jeku's shop is empty?", "talk_look_away", "sam")
                        cutscene:text("* Well he probably left somewhere else.[wait:3] It was bound to happen.", "shy_look_away", "sam")
                        cutscene:text("* At least he left his shop behind,[wait:2] that's thoughtful of him.", "happy_look_side", "sam")
                        cutscene:text("* Though I was expecting him to be replaced by someone else...", "huh", "sam")
                        cutscene:text("* Guess he didn't want you to see his friends until the timing was right.", "talk_look_away", "sam")
                        cutscene:text("* How do you even feel about MI-", "talk_look_away", "sam", {auto=true})
                        cutscene:text("* Wait no,[wait:2] that's a weird question!", "shy_blush", "sam")
                        cutscene:text("* ANYWAY...", "whoops", "sam")
                        if cutscene:choicer({"Where is he?", "Right..."}) == 1 then
                            cutscene:text("* So you want him to come back here?", "neutral", "sam")
                            cutscene:text("* Does he have something you want or something?", "talk_look_away", "sam")
                            cutscene:text("* Well he shouldn't be too far.", "happy_look_side", "sam")
                            cutscene:text("* He can only go in the worlds I made or influenced.", "talk_happy_look_side", "sam")
                            cutscene:showNametag("Simbel")
                            cutscene:text("* Have you installed something I made lately?", "shy_blush", "sam")
                            cutscene:showNametag("Sam")
                            cutscene:text("* If you did,[wait:2] you should search there.", "shy_look_away", "sam")
                            cutscene:text("* If not,[wait:2] then it's probably a bug.", "dead_inside_b", "sam")
                            cutscene:text("* Anyway,[wait:2] you'll probably need to unlock the debug commands first.", "neutral", "sam")
                            cutscene:text("* And then,[wait:2] I dunno...", "neutral", "sam")
                            cutscene:text("* Search inside the [color:yellow]default Kristal mods[color:reset]?", "talk_look_away", "sam")
                            cutscene:text("* But don't worry too much about finding him.", "shy_look_away", "sam")
                            local timeDiff = (7*60*24*24) - (os.time() - Game:getFlag("shop#jeku_shop:jeku_left_time_left"))
                            local days = Utils.round(timeDiff/(60*24*24))
                            if days < 0 then
                                cutscene:text("* He's probably back by now.", "happy_look_side", "sam")
                            elseif days == 0 then
                                cutscene:text("* I'm sure he'll be back soon.", "happy_look_side", "sam")
                            else
                                cutscene:text("* I'm sure he'll be back in like [color:yellow]"..days.." days[color:reset] or something.", "talk_happy_look_side", "sam")
                            end
                        else
                            cutscene:text("* ...", "dead_inside", "sam")
                        end
                    else
                        cutscene:text("* Oh he's back?", "surprised", "sam")
                        cutscene:text("* That's great!", "eyes_closed_happy", "sam")
                        cutscene:text("* I'm still not sure why you wanted him back but oh well.", "happy_look_side", "sam")
                        cutscene:text("* He does bring some entertainement to be honest.", "whoops", "sam")
                        cutscene:text("* So have fun with him I guess.", "shy_look_away", "sam")
                        cutscene:text("* I'm sure he has a lot of fun with you.", "happy_look_side", "sam")
                        Game:setFlag("meet_jeku_empt", false)
                    end
                elseif not Game:getFlag("meet_jeku") and Game:getFlag("meet_jeku_empt") then
                    cutscene:text("* Huh?[wait:3] You found an empty shop...?", "talk_look_away", "sam")
                    cutscene:text("* That's weird but,[wait:2] uh...[wait:3] What does it have to do with me?", "shy_look_away", "sam")
                    cutscene:text("* Maybe the shop owner just left or something...", "shy_look_away", "sam")
                    local timeDiff = (7*60*24*24) - (os.time() - Game:getFlag("shop#jeku_shop:jeku_left_time_left"))
                    local days = Utils.round(timeDiff/(60*24*24))
                    if days < 0 then
                        cutscene:text("* Or maybe you're just messing with me, I dunno.", "talk_look_away", "sam")
                    elseif days == 0 then
                        cutscene:text("* Maybe you should just check back soon?", "talk_happy_look_side", "sam")
                    else
                        cutscene:text("* So I don't know,[wait:2] maybe you should check back in a few days or something?", "talk_happy_look_side", "sam")
                        cutscene:text("* Maybe something like [color:yellow]"..days.." days[color:reset]?", "talk_happy", "sam")
                    end
                    if days >= 0 then
                        cutscene:text("* But uh,[wait:2] if you want to,[wait:2] you could maybe look for that guy?", "whoops", "sam")
                        cutscene:text("* Probably [color:yellow]not in this game[color:reset] though,[wait:2] you would have met him already.", "talk_look_away", "sam")
                        cutscene:showNametag("Simbel")
                        cutscene:text("* Have you installed [color:yellow]another game made on Kristal[color:reset] lately?", "talk_look_away", "sam")
                        cutscene:showNametag("Sam")
                        cutscene:text("* If you did,[wait:2] you should search there.", "happy_look_side", "sam")
                        cutscene:text("* If not,[wait:2] then it's probably a bug.", "dead_inside_b", "sam")
                        cutscene:text("* Anyway,[wait:2] you'll probably need to unlock the debug commands first.", "neutral", "sam")
                        cutscene:text("* And then,[wait:2] I dunno...", "neutral", "sam")
                        cutscene:text("* Search inside the [color:yellow]default Kristal mods[color:reset]?", "talk_look_away", "sam")
                    end
                else
                    cutscene:text("* Oh so you have met Jeku.", "talk_look_away", "sam")
                    cutscene:text("* He's uh...[wait:3] A pretty unstable guy,[wait:2] right?", "whoops", "sam")
                    cutscene:text("* He's kinda out of my control so just don't mess with him too much.", "unsure", "sam")
                    cutscene:text("* I think he's nice but he got powers that can change reality itself.", "talk_look_away", "sam")
                    cutscene:text("* Not the type of person you want to go against,[wait:2]you know?", "unsure", "sam")
                    if Game:getFlag("jekukilled", false) then
                        cutscene:text("* Actually, you uh... Already found out by yourself, didn't you?", "whoops", "sam")
                        cutscene:text("* Yeah, I can see it in the way you look at me.", "surprised_b", "sam")
                        cutscene:text("* That look that screams \"No kidding?\".", "talk_look_away", "sam")
                        cutscene:text("* Not sure what he did to you before, but [color:red]he can probably do worse now[color:reset].", "unsure", "sam")
                        cutscene:text("* So you should let him alone.", "shy_look_away", "sam")
                        Game:setFlag("allow_shop_fight", true)
                    else
                        cutscene:text("* So just stay out of his reach,[wait:2] if it's even possible.", "shy_look_away", "sam")
                    end
                    cutscene:text("* He'll probably just go one day to another one of my projects anyway.", "happy_look_side", "sam")
                    cutscene:text("* Huh?[wait:4] What about his shop?", "surprised_b", "sam")
                    cutscene:text("* Wait,[wait:2] he made a SHOP??[wait:5] Just that??", "surprised", "sam")
                    cutscene:text("* I kinda expected worse of him,[wait:2] to be honest.", "talk_look_away", "sam")
                    cutscene:text("* Well I guess he can still do whatever he wants though...", "huh", "sam")
                    cutscene:text("* Don't take what the game doesn't allow for granted.", "talk_look_away", "sam")
                    cutscene:text("* Jeku can and will attack you in the shop if he wants too.", "talk_look_away", "sam")
                    cutscene:text("* ...[wait:5]Oh yeah,[wait:2] the original question.", "shy_blush", "sam")
                    cutscene:text("* Well I don't know,[wait:2] maybe someone else will replace him?", "shy_look_away", "sam")
                end
            else
                cutscene:text("* Oh,[wait:2] okay.", "huh_b", "sam")
            end
        elseif c == 4 then
            cutscene:text("* Oh,[wait:2] okay.", "huh_b", "sam")
        end
        simbel:setFacing("down")
        cutscene:hideNametag()
    end,
    wardrobe = function(cutscene, event)
        local leader = Game.world.player
        if cutscene:getMarker("wardrobe_unstuck") and event then
        cutscene:walkTo(leader, "wardrobe_unstuck", 0.5, "up", true)
        cutscene:detachFollowers()
        end
        cutscene:text("* (It's a wardrobe.)\n* (What drawer would you like to open?)")

        local menu = cutscene:choicer({ "Party", "Costumes" })

        if menu == 1 then
            cutscene:interpolateFollowers()
            cutscene:attachFollowers()
            cutscene:after(function()
                Game.world:openMenu(DarkPartyMenu())
            end)
        else
            cutscene:interpolateFollowers()
            cutscene:attachFollowers()
            cutscene:after(function()
                Game.world:openMenu(Costumes())
            end)
        end
    end,
	dumbie = function(cutscene, event)
        if not Game:getFlag("dumbie_talkedto") then
            local dumbie = cutscene:getCharacter("dumbie")
            cutscene:showNametag("Dummy?")
            cutscene:text("* heya", "heeey", "dumbie")
			cutscene:showNametag("Susie")
			cutscene:text("* Uh,[wait:5] hey?", "sus_nervous", "susie")
			cutscene:showNametag("Dumbie")
			cutscene:text("* how are you doing on this fine night", "heeey", "dumbie")
			cutscene:text("* Nothing,[wait:5] i guess", "sus_nervous", "susie")
			cutscene:text("* cool", "normal", "dumbie")
			cutscene:hideNametag()
            Game:setFlag("dumbie_talkedto", true)
        elseif Game:getFlag("dumbie_talkedto") then
            local dumbie = cutscene:getCharacter("dumbie")
            cutscene:showNametag("Dumbie")
            cutscene:text("* hey did you see kris deltarune /srs", "suspect", "dumbie")
            cutscene:hideNametag("Dumbie")
	        local opinion = cutscene:choicer({"Yes", "No"})
			if opinion == 1 then
			    cutscene:showNametag("Dumbie")
			    cutscene:text("* show me where they are", "veryhappy", "dumbie")
                if #Game.party >= Game:getFlag("party_max") then
                    cutscene:text("* wait you've a bunch of friends i can only be friend with persons with at most " .. (Game:getFlag("party_max") - 1) .. " friends", "confused", "dumbie")
                    cutscene:text("* well I'll be here if you need me.", "normal", "dumbie")
                    cutscene:hideNametag()
                    Assets.playSound("slidewhist")
                    cutscene:slideTo(event, event.x, -100, 2)
                    cutscene:wait(1)
                else
			        Game:addPartyMember("dumbie")
                    Game:setFlag("dumbie_party", true)
                    event:convertToFollower(#Game.party)
			        cutscene:hideNametag()
			        cutscene:attachFollowers()
			        cutscene:text("* Dumbie joined the party.")
			        cutscene:wait(0.5)
                end
			    Game:setFlag("dumbie_inparty", true)
                Mod:unlockPartyMember("dumbie")
            else
			    cutscene:showNametag("Dumbie")
			    cutscene:text("* fuk u", "happy", "dumbie")
			    cutscene:hideNametag()
            end
		end
    end,
    starbeans = function(cutscene, event)
        cutscene:showNametag("Alexa")
		cutscene:text("[voice:alexa]* Oh,[wait:5] hello![wait:5]\n* Welcome to the Starbeans Cafe!")
		if not Game:getFlag("starbeans_first") then
			Game:setFlag("starbeans_first", true)
			for k,v in pairs(Game.party) do
				if v.id == "YOU" then
					cutscene:hideNametag()
					cutscene:wait(Game.world.music:fade(0, 0.5))
					cutscene:wait(1)
					Assets.playSound("croak")
					cutscene:wait(1)
					cutscene:wait(Game.world.music:fade(1, 0.5))
					cutscene:wait(1)
					cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* Okay...?")
				elseif v.id == "kris" then
				
				elseif v.id == "susie" then
				
				elseif v.id == "noelle" then
				
				elseif v.id == "dess" then
                    cutscene:showNametag("Dess")
                    cutscene:text("* Holy fuck is that Alexa Greene from hit indie game Deoxynn??????", "wtf", "dess")
                    cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* ... What.")
                    cutscene:showNametag("Dess")
                    cutscene:text("* yeah can I get uhhhhhhhhhhhhhhhh", "calm", "dess")
                    cutscene:showNametag("Dess", {top = true, right = false})
                    -- noskip because fuck you >:]
                    cutscene:text("[noskip]* large double double frappechino mocha extra sugar cappichino with frosting and sprinkles with a cherry on top and a boston cream donut with extra frosting and a chocolate chip muffin and a raisin oatmeal cookie", "kind", "dess", {top = true})
                    cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* ... We serve coffee here,[wait:5] ma'am.")
				elseif v.id == "brenda" then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Well this is kinda awkward.", "shock", "brenda")
                    cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* Hm?[wait:10]\n* What do you mean?")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Well I mean I made you kill a bunch of people,[wait:5] remember?", "neutral_side", "brenda")
                    cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* Uh,[wait:5] no????")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Ah so that's not canon in this mod?[wait:10] Cool.", "neutral", "brenda")
                    cutscene:showNametag("Alexa")
                    cutscene:text("[voice:alexa]* What???")
                    cutscene:text("[voice:alexa]* Are you okay ma'am?")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* I have absolutely zero clue myself.", "grin", "brenda")
                    cutscene:showNametag("Alexa")
                    cutscene:text("[voice:alexa]* Oooookay then.")
				elseif v.id == "dumbie" then
				
				elseif v.id == "ostarwalker" then
				
				elseif v.id == "berdly" then
				
				elseif v.id == "bor" then
				
				elseif v.id == "robo_susie" then
				
				elseif v.id == "nonyo" then
				
				elseif v.id == "iphone" then
				
				elseif v.id == "frisk2" then
				
				elseif v.id == "alseri" then
				
				elseif v.id == "jamm" then
					if not Game:getFlag("dungeonkiller") then
						cutscene:showNametag("Jamm")
						cutscene:text("* Wait,[wait:5] Alexa?[wait:5]\n* You work here?", "neutral", "jamm")
						cutscene:showNametag("Alexa")
						cutscene:text("[voice:alexa]* Actually,[wait:5] Director,[wait:5] I own this cafe!")
						cutscene:text("[voice:alexa]* Remember how I've been telling you I need more money for stuff?")
						cutscene:showNametag("Jamm")
						cutscene:text("* Vaguely,[wait:5] if anything.", "nervous_left", "jamm")
						cutscene:showNametag("Alexa")
						cutscene:text("[voice:alexa]* Well,[wait:5] it turns out D$ can be converted to Coins!")
						cutscene:showNametag("Jamm")
						cutscene:text("* Good for you,[wait:5] Alexa!", "happy", "jamm")
						cutscene:text("* But...[wait:5]\n* What about this room?", "neutral", "jamm")
						cutscene:showNametag("Alexa")
						cutscene:text("[voice:alexa]* The shopkeeper outside is letting me run the place.")
						cutscene:text("[voice:alexa]* I don't really get how the current model is sustaining money...")
						cutscene:text("[voice:alexa]* But I'm happy as long as I make money from it!")
					else
						cutscene:showNametag("Alexa")
						cutscene:text("[voice:alexa]* Wait,[wait:5] Director,[wait:5] is that you?")
						cutscene:text("[voice:alexa]* Gosh,[wait:5] you look terrible...[wait:5]\n* What the fleck happened?")
						cutscene:showNametag("Jamm")
						cutscene:text("* ...Just get me a brew please.", "shaded_pissed", "jamm")
						cutscene:showNametag("Alexa")
						cutscene:text("[voice:alexa]* R-right...")
					end
				elseif v.id == "mario" then
                    cutscene:showNametag("Mario")
					cutscene:text("* Do you have any spaghetti here?", "main", "mario")
                    cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* Um,[wait:5] no.[wait:5]\n* We only serve coffee.")
                    cutscene:showNametag("Mario")
					cutscene:text("* Where's my spaghetti!?", "main", "mario")
                    cutscene:showNametag("Alexa")
					cutscene:text("[voice:alexa]* I told you we don't have that stuff here!")
				end
			end
			cutscene:showNametag("Alexa")
		end
		if #Game.party == 1 then
			cutscene:text("[voice:alexa]* So![wait:5] How may I blend up your day?")
		else
			cutscene:text("[voice:alexa]* So![wait:5] How may I blend up your days?")
		end
		cutscene:hideNametag()
		local choice = cutscene:choicer({"Blend", "Nevermind"})
		if choice == 1 then
			cutscene:showNametag("Alexa")
			cutscene:text("[voice:alexa]* Sounds good![wait:5]\n* I'll get your blend ready soon!")
			cutscene:text("[voice:alexa]* Oh,[wait:5] but first,[wait:5] I'm required to ask something.")
			cutscene:text("[voice:alexa]* Want me to tell you about our StarB System?")
			cutscene:hideNametag()
			if cutscene:choicer({"Yes", "No need"}) == 1 then
				cutscene:showNametag("Alexa")
				cutscene:text("[voice:alexa]* Okay, here goes...")
				cutscene:text("[voice:alexa]* At Starbeans Cafe,[wait:5] you don't have to pay a cent for a blend!")
				cutscene:text("[voice:alexa]* Instead,[wait:5] you provide the ingredients for them.")
				cutscene:text("[voice:alexa]* ...Well,[wait:5] it's mostly beans,[wait:5] but...")
				cutscene:text("[voice:alexa]* Dig for beans and bring them here,[wait:5] and I'll blend them.")
				cutscene:text("[voice:alexa]* Simple enough,[wait:5] right?")
			end
			cutscene:showNametag("Alexa")
			cutscene:text("[voice:alexa]* So,[wait:5] what'll be your blend today?")
			cutscene:hideNametag()
			
			cutscene:after(function()
				Game.world:openMenu(BlendMenu())
			end)
		end
		cutscene:hideNametag()
    end,

    ---@param cutscene WorldCutscene
    shadowshop = function(cutscene, event)
        Game.world:shopTransition("shadowsalesman")
    end,
}
