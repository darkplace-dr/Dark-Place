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
			Game:setFlag("marcy_father", true)
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
	
		cutscene:showNametag("Marcy")
        cutscene:text("[voice:marcy]* H-hey, papa doesn't like Marcy reading his notes...", "frown", "marcy")
		
		if susie then
			cutscene:showNametag("Susie")
            cutscene:text("[voice:susie]* What!? You serious!?", "shock", "susie")
            cutscene:text("[voice:susie]* You're really gonna let your father stop you when he's gone?", "smile", "susie")
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
    end
}