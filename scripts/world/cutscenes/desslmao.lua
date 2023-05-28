return {
	dessbegin = function(cutscene)
		local dess = cutscene:getCharacter("dess")

		if cutscene:getCharacter("brandon") then
			cutscene:showNametag("Brandon")
			cutscene:text("* (Oh god...[wait:5] it's HER.)", "miffed", "brandon")
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
		if cutscene:getCharacter("brandon") then
			cutscene:text("* Oh hey is that the dude?", "kind", "dess")

			cutscene:showNametag("Brandon")
			cutscene:text("[noskip][speed:0.3]* ...", "miffed", "brandon")

			cutscene:showNametag("Dess")
			cutscene:text("* uhhhh Brandish was it?", "neutral", "dess")

			cutscene:showNametag("Brandon")
			cutscene:text("* ... Brandon.[wait:10]\n* Or Brenda if you prefer.", "miffed", "brandon")

			cutscene:showNametag("Dess")
			cutscene:text("* yeah I knew that", "condescending", "dess")
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
		local leader_x_backup = leader.x
		local leader_y_backup = leader.y
		leader:explode(0, 0, true)
		cutscene:slideTo(leader, leader.x - 700, leader.y - 50, 1)
		cutscene:wait(1.5)

		if #Game.party >= 4 then
			Game:setFlag("dessRemovedLeader", Game.party[1])
			Game:removePartyMember(Game.party[1])
		end
		
		Game:addPartyMember("dess", 1)
		Game.world:spawnPlayer(dess.x, dess.y, "dess")
		dess:remove()
		Game.world:removeFollower(leader)
		cutscene:walkTo("dess", leader_x_backup, leader_y_backup, 1, "left")

		cutscene:showNametag("Dess")
		cutscene:text("* Ok lets go", "neutral", "dess")
		if not Kristal.libCall("achievements", "hasAch", "starstruck") then
        Kristal.callEvent("completeAchievement", "starstruck")
    end
		cutscene:hideNametag()

		cutscene:attachFollowers(1)
		cutscene:interpolateFollowers()
		cutscene:attachCamera(0.5)
		cutscene:wait(0.5)

		Game:setFlag("gotDess", true)
		table.insert(Game:getFlag("party"), "dess")
  end,

	dessgetoverhere = function(cutscene, event)
		if Game:getFlag("gotDess") then
			cutscene:showNametag("Dess")
			cutscene:text("* Hey I can do a crazy impression watch this", "condescending", "dess")
			cutscene:text("* Look at meeee I'm FRISK from UNDERTALE lmao", "calm", "dess")

			cutscene:showNametag("Susie")
			cutscene:text("* ...", "annoyed", "susie")
			cutscene:text("* (We need to get rid of her as fast as possible.)", "annoyed", "susie")
			if cutscene:getCharacter("brandon") then
				cutscene:showNametag("Brandon")
				cutscene:text("* (Agreed.)", "miffed", "brandon")
			end
			cutscene:hideNametag()

			Game:setFlag("dessThingy", true)
			event:remove()
		else
			local leader = Game.world.player
			leader.y = leader.y + 4

			cutscene:showNametag("???")
			cutscene:text("* Hey fucker you need to come talk to me first", "neutral", "dess")
			cutscene:hideNametag()
		end
	end,

	dessboss = function(cutscene)
		local boss = cutscene:getCharacter("ufoofdoom", 1)

		local susie = cutscene:getCharacter("susie")
		local leader = Game.world.player
		local dess = cutscene:getCharacter("dess")
		local brandon = cutscene:getCharacter("brandon")

		cutscene:detachFollowers()
		cutscene:detachCamera()

		cutscene:walkTo(leader, dess.x, dess.y+16, 1, "up")
		cutscene:walkTo(susie, dess.x, dess.y+32, 1, "up")
		if brandon then
			cutscene:walkTo(brandon, dess.x, dess.y+48, 1, "up")
		end

		cutscene:showNametag("Susie")
		cutscene:text("* Ugh,[wait:10] alright,[wait:5] is this the last one?!", "angry", "susie")

		cutscene:showNametag("Dess")
		cutscene:text("* Yep", "neutral", "dess")

		cutscene:showNametag("Susie")
		cutscene:text("* Alright...[wait:10] let's finally get outta here.", "annoyed_down", "susie")
		cutscene:hideNametag()

		cutscene:wait(1)
		boss:shake(8, 0)
		cutscene:wait(2)

		cutscene:showNametag("Susie")
		cutscene:text("* Did you just see that??", "surprise_frown", "susie")
		cutscene:text("* Why did it just shake?", "shy_b", "susie")

		cutscene:showNametag("Dess")
		cutscene:text("* That's normal, all the other ones shake if you hit them", "neutral", "dess")

		boss:shake(8, 0)

		cutscene:showNametag("Susie")
		cutscene:text("* But...[wait:10] we didn't hit it!", "shock_down", "susie")

		boss:shake(16, 0)

		cutscene:showNametag("Dess")
		cutscene:text("* Yo wait you're right!", "wtf_b", "dess")

		boss:shake(8, 0)

		cutscene:showNametag("???")
		cutscene:text("* Hee...")
		boss:shake(16, 0)
		cutscene:text("* Uheeheehee!!")

		boss:fadeTo(0, 0.1, function() boss:fadeTo(1, 0.05) end)
		cutscene:panTo(boss.x, boss.y+256, 2)
		boss:slideTo(boss.x, boss.y+256, 2, "in-out-quint")

		cutscene:wait(0.8)

		cutscene:look(susie, "down")
		cutscene:look(dess, "down")
		cutscene:look(leader, "down")
		if brandon then
			cutscene:look(brandon, "down")
		end

		cutscene:wait(1.2)
		cutscene:text("* I'm sorry![wait:10]\n* I simply couldn't contain myself!")
		cutscene:text("* Uheehee!")

		cutscene:showNametag("Susie")
		cutscene:text("* Who the hell are you?!", "angry", "susie")

		cutscene:hideNametag()

		boss:fadeTo(0.2, 0.05)
		cutscene:wait(1)
		boss:setActor("susie")
		cutscene:look(boss, "up")
		boss:fadeTo(1, 0.05)
		cutscene:wait(1)
		cutscene:showNametag("???")
		cutscene:text("* YOU![wait:10] Well,[wait:5] just you.[wait:10] Not YOU.")

		cutscene:showNametag("Susie")
		cutscene:text("* Wha-?![wait:10] What the hell??", "surprise_frown", "susie")

		cutscene:hideNametag()

		boss:fadeTo(0.2, 0.05)
		cutscene:wait(1)
		boss:setActor("YOU")
		cutscene:look(boss, "up")
		boss:fadeTo(1, 0.05)
		cutscene:wait(1)
		cutscene:showNametag("???")
		cutscene:text("* Oh well,[wait:5] NOW I'm YOU!")
		cutscene:text("* Or Kris![wait:10] You couldn't tell from here![wait:10] Uheeheehee!")
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

		cutscene:showNametag("Susie")
		cutscene:text("* Uhh,[wait:10] what do they mean by that?", "nervous", "susie")

		cutscene:showNametag("???")
		cutscene:text("* Uheehee![wait:10] You're much better!")
		cutscene:text("* It's too easy to be who you want to be!")
		cutscene:text("* I know that is not the real Dess Holiday!")

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

		if brandon then
			cutscene:showNametag("Brandon")
			cutscene:text("* Let's do this.", "happy", "brandon")
		end

		cutscene:showNametag("???")
		cutscene:text("* Suit yourself![wait:5] Uheehee!")

		cutscene:hideNametag()
		cutscene:attachCamera(1)
		cutscene:startEncounter("mimicboss", true, boss)

		Game:setFlag("mimicBossDone", true)
		boss:remove()
		cutscene:attachFollowers(5)
		cutscene:wait(1)

		cutscene:showNametag("Dess")
		cutscene:text("* Wow,[wait:10] we really learned a lot about each-other while on this journey.", "genuine", "dess")

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

		if brandon then
			cutscene:showNametag("Brandon")
			cutscene:text("* Now you know how I feel.", "miffed", "brandon")
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
		if brandon then
			cutscene:showNametag("Brandon")
			cutscene:text("* (God damnit.)", "miffed", "brandon")
		end
		cutscene:hideNametag()

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
			cutscene:showNametag("Susie")
			cutscene:text("* ...", "neutral_side", "susie")
			cutscene:text("* Oooookay then...", "neutral", "susie")
			if brandon then
				cutscene:showNametag("Brandon")
				cutscene:text("[speed:0.3]* ...", "frown", "brandon")
			end
			Assets.playSound("ominous")
			Game:setFlag("can_kill", true)
			cutscene:hideNametag()
		end
		if Game:getFlag("dessRemovedLeader") then
			Game:removePartyMember("dess")
			Game:addPartyMember(Game:getFlag("dessRemovedLeader").id, 1)
			cutscene:showNametag("Dess")
			cutscene:text("* I'll be waiting for you at the diner aight?", "eyebrow", "dess")
			cutscene:hideNametag()
		end
	end,
}