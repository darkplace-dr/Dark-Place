return {

	dessbegin = function(cutscene)
		local dess = cutscene:getCharacter("dess")

		local YOU = cutscene:getCharacter("YOU")
		local kris = cutscene:getCharacter("kris")
		
		cutscene:showNametag("Dess Holiday?")
		cutscene:text("* Yo is that-", "condescending", "dess")
		Assets.playSound("lowqualityburp")
		cutscene:text("* (Low quality burp sound effect like that one time in Rick and Morty like what they do in the show)", "neutral", "dess")
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
		cutscene:text("* Oh yeah can I join your team btw", "neutral", "dess")
		
		cutscene:hideNametag()
		cutscene:text("* (Can she join your team btw?)")
		cutscene:choicer({"Yes", "No"})
		
		cutscene:showNametag("Dess")
		if cutscene.choice == 1 then
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
		local dessWalkPos = {0, 0}
		if YOU then
		
			dessWalkPos = {YOU.x, YOU.y}
			YOU:explode(0, 0, true)
			cutscene:slideTo(YOU, YOU.x - 700, YOU.y - 50, 1)
		
		elseif kris then
		
			dessWalkPos = {kris.x, kris.y}
			kris:explode(0, 0, true)
			cutscene:slideTo(kris, kris.x - 700, kris.y - 50, 1)
		
		end
		cutscene:wait(1.5)
		Game:addPartyMember("dess", 1)
		Game.world:spawnPlayer(dess.x, dess.y, "dess")
		dess:remove()
		
		if YOU then
			Game.world:removeFollower(YOU)
		elseif kris then
			Game.world:removeFollower(kris)
		end
		
		cutscene:walkTo("dess", dessWalkPos[1], dessWalkPos[2], 1, "left")
		cutscene:text("* Ok lets go", "neutral", "dess")
		
		
		cutscene:attachFollowers(1)
		cutscene:interpolateFollowers()
		cutscene:attachCamera(0.5)
		cutscene:wait(0.5)
		
		
		Game:setFlag("gotDess", true)
	
	
	
	end,
	
	
	dessgetoverhere = function(cutscene, origin)
		
		if Game:getFlag("gotDess") then

			
			cutscene:showNametag("Dess")
			cutscene:text("* Hey I can do a crazy impression watch this", "condescending", "dess")
			cutscene:text("* Look at meeee I'm FRISK from UNDERTALE lmao", "calm", "dess")
			
			cutscene:showNametag("Susie")
			cutscene:text("* ...", "annoyed", "susie")
			cutscene:text("* (We need to get rid of her as fast as possible.)", "annoyed", "susie")
			Game:setFlag("dessThingy", true)
			
			origin:remove()
			
		else
			
			local YOU = cutscene:getCharacter("YOU")
			local kris = cutscene:getCharacter("kris")
			
			if YOU then
				YOU.y = YOU.y + 4
			elseif kris then
				kris.y = kris.y + 4
			end
			
			cutscene:showNametag("???")
			cutscene:text("* Hey fucker you need to come talk to me first", "neutral", "dess")
		end
		
		cutscene:hideNametag()
	
	end,
	
	
	dessboss = function(cutscene)
	
		local boss = cutscene:getCharacter("ufoofdoom", 1)
	
		cutscene:showNametag("Susie")
		cutscene:text("* Ugh,[wait:10] alright,[wait:5] is this the last one?!", "angry", "susie")
		
		cutscene:showNametag("Dess")
		cutscene:text("* Yep", "neutral", "dess")
		
		cutscene:showNametag("Susie")
		cutscene:text("* Alright...[wait:10] let's finally get outta here.", "annoyed_down", "susie")
		
		boss:shake(8, 0)
		cutscene:wait(0.7)
		
		cutscene:text("* Did you just see that??", "surprise_frown", "susie")
		cutscene:text("* Why did it just shake?", "shy_down", "susie")
		
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
		
		boss:fadeTo(0.2, 0.05, function() boss:fadeTo(1, 0.05, callback) end)
		boss:slideTo(boss.x, boss.y+64, 1, "in-out-quint")
		
		cutscene:wait(0.8)
		
		cutscene:text("* I'm sorry![wait:10]\n* I simply couldn't contain myself!")
		cutscene:text("* Uheehee!")
		
		cutscene:showNametag("Susie")
		cutscene:text("* Who the hell are you?!", "angry", "susie")
		
		boss:fadeTo(0.2, 0.05)
		boss:setSprite("party/susie/dark/walk/up", keep_anim)
		cutscene:showNametag("???")
		
		
		
		cutscene:hideNametag()
		
	end,
	
}