return {
	dessbegin = function(cutscene)
		local dess = cutscene:getCharacter("dess")

		if cutscene:getCharacter("noel") then
			noel_here = 1
		end

		if cutscene:getCharacter("brenda") then
			cutscene:showNametag("Brenda")
			cutscene:text("* (Oh god...[wait:5] it's HER.)", "miffed", "brenda")     
                        if noel_here then
			    noel_here = self.noel_here + 1
			    cutscene:showNametag("Noel")
			    cutscene:text("* (Who?)", "huh", "noel")
			    cutscene:text("* (Why do you seem so [face:oh]darn upset?)", "bruh", "noel")
                        end
		end

		if cutscene:getCharacter("dumbie") then
			cutscene:showNametag("Dumbie")
			cutscene:text("* NO WAY DESS DELTARUNE", "pog", "dumbie")
                        if noel_here then
                            if noel_here == 2 then
			        noel_here = noel_here + 1
			        cutscene:showNametag("Noel")
			        cutscene:text("* Dess?\n[face:...]* Is she one of the baddies?", "bruh", "noel")
                            else
			        noel_here = noel_here + 1
			        cutscene:showNametag("Noel")
			        cutscene:text("* (Deltarune?)", "...", "noel")
                                cutscene:text("* (... interisting.)", "huh", "noel")
                            end
                        end
		end
		
		if cutscene:getCharacter("jamm") then
			cutscene:showNametag("Jamm")
            cutscene:text("* (Did we really have to do this one?)", "nervous", "jamm")
                        if noel_here then
                            if noel_here == 3 then
			        cutscene:text("* OKAY, WHY THE [face:oh]FRICK[face:madloud] IS EVERYONE REACING IN THIS MANNER?!", "madloud", "noel")
                            elseif noel_here == 2 then
			        cutscene:showNametag("Noel")
			        cutscene:text("* Is somthing wrong?", "bruh", "noel")
                            else
			        cutscene:showNametag("Noel")
			        cutscene:text("* (Do what?)", "...", "noel")
                            end
                        end
		end

		cutscene:showNametag("Dess Holiday?")
		cutscene:text("* Yo is that-", "condescending", "dess")
		cutscene:text("* ([func:sound]Low quality burp sound effect like that one time in Rick and Morty like what they do in the show)", "neutral", "dess",
		{
			functions = {
				sound = function ()
					Assets.stopAndPlaySound("lowqualityburp")
				end
			}
		})
		Assets.stopSound("lowqualityburp")
        if cutscene:getCharacter("susie") then
            cutscene:text("* Is that the fuckin' uhh 'Kris where the hell are we' guy??", "condescending", "dess")

            cutscene:showNametag("Susie")
            cutscene:text("* ...", "annoyed", "susie")
            cutscene:text("* Well first of all I'm a girl,[wait:10] and second of all I never said that.", "nervous", "susie")
            cutscene:text("* Wait,[wait:5] how do you even know us??", "nervous_side", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* What do you mean I see you say it all the time on like", "condescending", "dess")
            cutscene:text("* Twitter memes", "condescending", "dess")

            cutscene:showNametag("Susie")
            cutscene:text("* What the hell is Twitter?", "annoyed", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* Man idk anymore", "condescending", "dess")
        else
            cutscene:text("* Sup fuckers, DessHere!", "condescending", "dess")
            cutscene:text("* Now that you're finally here, we can party!", "condescending", "dess")
        end
		if cutscene:getCharacter("brenda") then
			cutscene:text("* Oh hey is that the gal?", "kind", "dess")

			cutscene:showNametag("Brenda")
			cutscene:text("[noskip][speed:0.3]* ...", "miffed", "brenda")

			cutscene:showNametag("Dess")
			cutscene:text("* uhhhh Breloom was it?", "neutral", "dess")

			cutscene:showNametag("Brenda")
			cutscene:text("* ... Brenda.", "miffed", "brenda")

			cutscene:showNametag("Dess")
			cutscene:text("* yeah I knew that", "condescending", "dess")
		end
		if cutscene:getCharacter("jamm") then
			cutscene:text("* Oh hey didn't your wife die?", "kind", "dess")

			cutscene:showNametag("Jamm")
			cutscene:text("* She lasted longer than my patience with you, thank you very much.", "shaded_pissed", "jamm")

			cutscene:showNametag("Dess")
			cutscene:text("* yeah true I figured", "condescending", "dess")
		end
		cutscene:text("* Oh yeah can I join your team btw", "neutral", "dess")

		cutscene:hideNametag()
		cutscene:text("* (Can she join your team btw?)")
		local can_she_join_your_team_btw = cutscene:choicer({"Yes", "No"})

		cutscene:showNametag("Dess")
		if can_she_join_your_team_btw == 1 then
			cutscene:text("* sick", "condescending", "dess")
		else
			cutscene:text("* Uhhh I don't care", "condescending", "dess")
		end
		cutscene:hideNametag()

		cutscene:detachFollowers()
		cutscene:detachCamera()
		cutscene:setAnimation(dess, "battle/attack")
		dess.flip_x = true
		cutscene:wait(0.2)
		local leader = Game.world.player
		leader:explode(0, 0, true)
		cutscene:slideTo(leader, leader.x - 700, leader.y - 50, 1)
		cutscene:wait(1.5)

		if #Game.party >= Game:getFlag("party_max") then
			local prev_leader_pm = Game.party[1]
			Game:setFlag("dessRemovedLeader", prev_leader_pm.id)
			Game:removePartyMember(prev_leader_pm)
			Game:setFlag(prev_leader_pm.id.."_party", false)
		end
		
		Game:addPartyMember("dess", 1)
		Game:setFlag("dess_party", true)
		Game:setFlag("dess_obtained", true)
		Game.world:spawnPlayer(dess.x, dess.y, "dess")
		dess:remove()
		Game.world:removeFollower(leader)
		cutscene:walkTo("dess", dess.x - 30, dess.y + 10, 1, "left")

		cutscene:showNametag("Dess")
		cutscene:text("* Ok lets go", "neutral", "dess")
		cutscene:hideNametag()

        Kristal.callEvent("completeAchievement", "starstruck")

		cutscene:attachFollowers(1)
		cutscene:interpolateFollowers()
		cutscene:attachCamera(0.5)
		cutscene:wait(0.5)

		Game:setFlag("gotDess", true)
		Mod:unlockPartyMember("dess")

		local susie_party = Game:getPartyMember("susie")
        if cutscene:getCharacter("susie") then
            susie_party:addOpinion("dess", -20)
        end
  end,

	dessgetoverhere = function(cutscene, event)
		if Game:getFlag("gotDess") then
			cutscene:showNametag("Dess")
			cutscene:text("* Hey I can do a crazy impression watch this", "condescending", "dess")
			cutscene:text("* Look at meeee I'm FRISK from UNDERTALE lmao", "calm", "dess")

            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "annoyed", "susie")
                cutscene:text("* (We need to get rid of her as fast as possible.)", "annoyed", "susie")
                if cutscene:getCharacter("brenda") then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* (Agreed.)", "miffed", "brenda")
                end
                if cutscene:getCharacter("jamm") then
                    cutscene:showNametag("Jamm")
                    cutscene:text("* (Are we only agreeing on this now?)", "nervous_left", "jamm")
                end
            end
			cutscene:hideNametag()
			Game:setFlag("dessThingy", true)
			event:remove()
		else
			local leader = Game.world.player
			
			cutscene:showNametag("???")
			cutscene:text("* Hey fucker you need to come talk to me first", "neutral", "dess")
			
			if cutscene:getCharacter("jamm") then
				cutscene:showNametag("Jamm")
				cutscene:text("* Well, there goes THAT idea.", "nervous", "jamm")
			end
			cutscene:hideNametag()
            leader.y = leader.y + 12
		end
	end,

	dessboss = function(cutscene)
		local boss = cutscene:getCharacter("ufoofdoom", 1)

		local susie = cutscene:getCharacter("susie")
		local leader = Game.world.player
		local dess = cutscene:getCharacter("dess")
		local brenda = cutscene:getCharacter("brenda")
		local jamm = cutscene:getCharacter("jamm")

		cutscene:detachFollowers()
		cutscene:detachCamera()

        for i,party in ipairs (Game.party) do
            cutscene:walkTo(cutscene:getCharacter(party.id), leader.x, leader.y+16*i, 1, "up")
        end

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Ugh,[wait:10] alright,[wait:5] is this the last one?!", "angry", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* Yep", "neutral", "dess")

            cutscene:showNametag("Susie")
            cutscene:text("* Alright...[wait:10] let's finally get outta here.", "annoyed_down", "susie")
        else
            cutscene:showNametag("Dess")
            cutscene:text("* This area is very well designed i'm so glad i have it all to myself", "condescending", "dess")
        end
		cutscene:hideNametag()

		cutscene:wait(1)
		boss:shake(8, 0)
		cutscene:wait(2)

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Did you just see that??", "surprise_frown", "susie")
            cutscene:text("* Why did it just shake?", "shy_b", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* That's normal, all the other ones shake if you hit them", "neutral", "dess")
        else
            cutscene:showNametag("Dess")
            cutscene:text("* ...", "kind", "dess")
        end

		boss:shake(8, 0)

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* But...[wait:10] we didn't hit it!", "shock_down", "susie")
        else
            cutscene:text("* ...", "neutral", "dess")
        end

		boss:shake(16, 0)

		cutscene:showNametag("Dess")
        if susie then
            cutscene:text("* Yo wait you're right!", "wtf_b", "dess")
        else
            cutscene:text("* Oh shit!", "wtf_b", "dess")
        end
		boss:shake(8, 0)

		cutscene:showNametag("???")
		cutscene:text("* Hee...")
		boss:shake(16, 0)
		cutscene:text("* Uheeheehee!!")
		cutscene:hideNametag()

		boss:fadeTo(0, 0.1, function() boss:fadeTo(1, 0.05) end)
		cutscene:panTo(boss.x, boss.y+256, 2)
		boss:slideTo(boss.x, boss.y+256, 2, "in-out-quint")

		cutscene:wait(0.8)

        for i,party in ipairs (Game.party) do
            cutscene:look(cutscene:getCharacter(party.id), "down")
        end
        cutscene:look(leader, "down")
        
		cutscene:wait(1.2)
		cutscene:showNametag("???")
		cutscene:text("* I'm sorry![wait:10]\n* I simply couldn't contain myself!")
		cutscene:text("* Uheehee!")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Who the hell are you?!", "angry", "susie")
        end

		cutscene:hideNametag()

		boss:fadeTo(0.2, 0.05)
		cutscene:wait(1)
		boss:setActor("susie")
		cutscene:look(boss, "up")
		boss:fadeTo(1, 0.05)
		cutscene:wait(1)
        cutscene:showNametag("???")
        if susie then
            cutscene:text("* YOU![wait:10] Well,[wait:5] just you.[wait:10] Not YOU.")

            cutscene:showNametag("Susie")
            cutscene:text("* Wha-?![wait:10] What the hell??", "surprise_frown", "susie")
        else
            cutscene:text("* LOOK at me![wait:10] I'm the Angry Dino Girl!")
        end

		cutscene:hideNametag()

		boss:fadeTo(0.2, 0.05)
		cutscene:wait(1)
		boss:setActor("YOU")
		cutscene:look(boss, "up")
		boss:fadeTo(1, 0.05)
		cutscene:wait(1)
		cutscene:showNametag("???")
        if susie then
            cutscene:text("* Oh well,[wait:5] NOW I'm YOU!")
        else
            cutscene:text("* AND NOW I'm YOU!")
        end
		cutscene:text("* Uheeheehee!")
		cutscene:hideNametag()

		boss:fadeTo(0.2, 0.05)
		cutscene:wait(1)
		boss:setActor("ufoofdoom")
		boss:fadeTo(1, 0.05)
		cutscene:showNametag("Dess")
		cutscene:text("* Whatever can we fight now", "condescending", "dess")

		cutscene:showNametag("???")
		cutscene:text("* ...OH![wait:10] I see!")
		cutscene:text("* ...Uheehee!")
		cutscene:text("* You're even worse than me! Uhee!")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Uhh,[wait:10] what do they mean by that?", "nervous", "susie")

            cutscene:showNametag("???")
            cutscene:text("* Uheehee![wait:10] You're much better!")
        end
        cutscene:showNametag("???")
		cutscene:text("* It's too easy to be who you want to be!")
		cutscene:text("* I know that is not the real Dess Holiday!")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Huh???", "surprise_frown", "susie")

            cutscene:showNametag("???")
            cutscene:text("* Don't act all surprised!")
            cutscene:text("* I know that you aren't the real Susie either!")

            cutscene:showNametag("Susie")
            cutscene:text("* ...???", "suspicious", "susie")
            cutscene:text("* Uh.", "suspicious", "susie")
            cutscene:text("* Alright,[wait:5] let's smash this guy into a pulp.", "teeth_smile", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* Agreed", "neutral", "dess")
        else
            cutscene:showNametag("Dess")
            cutscene:text("* Whatever,[wait:5]I wanna smash you already", "neutral", "dess")
        end

		if brenda then
			cutscene:showNametag("Brenda")
			cutscene:text("* Let's do this.", "happy", "brenda")
		end
		
		if jamm then
			cutscene:showNametag("Jamm")
            cutscene:text("* Here we go!", "smug", "jamm")
		end

		cutscene:showNametag("???")
		cutscene:text("* Suit yourself![wait:5] Uheehee!")

		cutscene:hideNametag()
		cutscene:attachCamera(1)
		cutscene:startEncounter("mimicboss", true, boss)

		Game:setFlag("mimicBossDone", true)
		Game:setFlag("mimic_defeated", true)
		boss:remove()
		cutscene:attachFollowers(5)
		cutscene:wait(1)

		cutscene:showNametag("Dess")
		cutscene:text("* Wow,[wait:10] we really learned a lot about each-other while on this journey.", "genuine", "dess")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* WH-", "shock", "susie")
            cutscene:text("* NO!!", "angry", "susie")
            cutscene:text("* NO!!!!!", "angry_b", "susie")
            cutscene:text("* You are NOT making this a 'touching' moment!", "angry_c", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* No,[wait:5] I really think we really started to value our friendship there.", "genuine", "dess")
            cutscene:text("* Whaddya say,[wait:5] after this...", "genuine", "dess")
            cutscene:text("* You and I smoke a ciggie outside of a 7/11?", "kind", "dess")
         
            cutscene:showNametag("Susie")
            cutscene:text("* I just want you to know right now...", "suspicious", "susie")
            cutscene:text("* You are the absolute worst person I've ever met.", "suspicious", "susie")

            if brenda then
                cutscene:showNametag("Brenda")
                cutscene:text("* Now you know how I feel.", "miffed", "brenda")
            end

            cutscene:showNametag("Dess")
            cutscene:text("* Alright but can I stay on the team?", "neutral", "dess")

            cutscene:showNametag("Susie")
            cutscene:text("* NO!", "teeth_b", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* ...", "neutral", "dess")
            cutscene:text("* Please?", "condescending", "dess")

            cutscene:showNametag("Susie")
            cutscene:text("* NO!!![wait:20] NO NO NO!", "teeth_b", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* If I do I'll give the other guy's position back as leader", "neutral", "dess")

            cutscene:showNametag("Susie")
            cutscene:text("* ...", "teeth_b", "susie")
            cutscene:text("* ALRIGHT, FINE!", "teeth_b", "susie")
            cutscene:text("* But I am NOT talking to you anymore!", "angry", "susie")

            cutscene:showNametag("Dess")
            cutscene:text("* Yippeee", "condescending", "dess")
        else
            cutscene:text("* I really think we really started to value our friendship there.", "genuine", "dess")
            cutscene:text("* Whaddya say,[wait:5] after this...", "genuine", "dess")
            cutscene:text("* We all smoke a ciggie outside of a 7/11?", "kind", "dess")
        end
        
		if brenda then
			cutscene:showNametag("Brenda")
			cutscene:text("* (God damnit.)", "miffed", "brenda")
		end
		if jamm then
			cutscene:showNametag("Jamm")
			cutscene:text("* (And dreams were broken that day.)", "neutral", "jamm")
		end
		cutscene:hideNametag()

		local susie_party = Game:getPartyMember("susie")
        if susie then
            susie_party:addOpinion("dess", -20)
        end

		cutscene:detachFollowers()
		Game:movePartyMember("dess", 2)
		cutscene:attachFollowers(3)
		if Game:getFlag("library_kills") >= 9 then
			cutscene:wait(3)
			cutscene:showNametag("Dess")
			cutscene:text("* Hey actually wait", "genuine", "dess")
			cutscene:text("* wouldn't it be cool if like...", "kind", "dess")
			cutscene:text("* All of the sensless murder we've been doing like...", "condescending", "dess")
			cutscene:text("* Allowed us to actually kill people normally?", "kind", "dess")
			cutscene:showNametag("Dess", {top = true})
			cutscene:text("* That'd be a cool reference to hit Deltarune fangame made by RynoGG know as Deltatraveler where in the section 2 obliteration route you can actually kill the animals and people if you clear out all the enemies in the first few rooms", "condescending", "dess", {top = true})
			if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "neutral_side", "susie")
                cutscene:text("* Oooookay then...", "neutral", "susie")
            end
			if brenda then
				cutscene:showNametag("Brenda")
				cutscene:text("[speed:0.3]* ...", "frown", "brenda")
			end
			Assets.playSound("ominous")
			Game:setFlag("can_kill", true)
			cutscene:hideNametag()
		end
		if Game:getFlag("dessRemovedLeader") then
			local removed_member_id = Game:getFlag("dessRemovedLeader")
			if type(removed_member_id) == "table" then removed_member_id = removed_member_id.id end
			Game:removePartyMember("dess")
			Game:setFlag("dess_party", false)
			Game:addPartyMember(removed_member_id, 1)
			Game:setFlag(removed_member_id.."_party", true)
			cutscene:showNametag("Dess")
			cutscene:text("* I'll be waiting for you at the diner aight?", "eyebrow", "dess")
			cutscene:hideNametag()
		end
	end,
}
