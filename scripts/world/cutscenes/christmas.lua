return {
	door = function(cutscene, event)
		cutscene:text("* The door is frosted shut.")
		
		if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
			cutscene:showNametag("Jamm", {right = false})
			cutscene:text("* Too bad my fire magic is on the fritz...", "nervous", "jamm")
			cutscene:text("* I'd actually be able to get us in here.", "nervous", "jamm")
			cutscene:hideNametag()
		end
	end,
    s_elf_1 = function(cutscene, event)
		cutscene:showNametag("self", {font = "sans", right = false})
		if not Game:getFlag("self_1") then
			Game:setFlag("self_1", true)
			cutscene:text("[font:sans]* heya.", "neutral", "self")
			
			if cutscene:getCharacter("susie") then
				cutscene:showNametag("Susie", {right = false})
				cutscene:text("* You??", "teeth_b", "susie")
				if cutscene:getCharacter("YOU") then
					cutscene:text("* No,[wait:2] not you, YOU..[wait:5]\n[face:teeth_b]* THAT guy!!", "sus_nervous", "susie")
				end
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* huh?[wait:5]\n* you talking to me?", "neutral", "self")
				
				cutscene:showNametag("Susie", {right = false})
				cutscene:text("* You're that guy from the convenience store!", "teeth_b", "susie")
				
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* hmm...[wait:5]\n* i would remember working at a convenience store.", "neutral", "self")
				cutscene:text("[font:sans]* you must have me confused with someone else.", "neutral", "self")
			end
			
			cutscene:text("[font:sans]* the name's self.[wait:5]\n* self the skelf.", "neutral", "self")
			cutscene:text("[font:sans]* i run this hotdog stand on the outskirts of santa's workshop.", "neutral", "self")
			
			if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
				cutscene:showNametag("Jamm", {right = false})
				cutscene:text("* Hot dogs?[wait:5]\n* So how do you keep them warm?", "nervous", "jamm")
				cutscene:text("* It's f-freezing out here!", "ouch", "jamm")
			
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* really?[wait:5]\n* i don't feel cold.", "neutral", "self")
				cutscene:text("[font:sans]* you must be imagining things.", "neutral", "self")
			end
			
			if cutscene:getCharacter("brenda") then
				cutscene:showNametag("Brenda", {right = false})
				cutscene:text("* Wait,[wait:5] uh,[wait:5] Self...", "neutral", "brenda")
				cutscene:text("* Are these hot dogs...[wait:5]\n* Legal?", "neutral", "brenda")
			
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* will you buy them if i said they weren't?", "neutral", "self")
				
				cutscene:showNametag("Brenda", {right = false})
				cutscene:text("* I don't think so???", "shock", "brenda")
			
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* well that's good,[wait:5] because they are legal.", "neutral", "self")
			end
			cutscene:showShop()
			cutscene:text("[font:sans]* how about it?[wait:5]\n* only 200 D$.", "neutral", "self")
		else
			cutscene:showShop()
			cutscene:text("[font:sans]* want a hot dog?[wait:5]\n* only 200 D$.", "neutral", "self")
		end
		cutscene:hideNametag()
		
		if cutscene:choicer({"Yes", "No"}) == 1 then
			if Game.money >= 200 then
				if Game.inventory:isFull("items", false) then
					cutscene:showNametag("self", {font = "sans", right = false})
					cutscene:text("[font:sans]* sorry,[wait:5] kid.[wait:5]\n* your [color:yellow]ITEMs[color:white] pocket is full.", "neutral", "self")
					cutscene:text("[font:sans]* try emptying it a bit and come back.", "neutral", "self")
					cutscene:hideShop()
					if not Game.inventory:isFull("storage", false) then
						if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
							cutscene:showNametag("Jamm", {right = false})
							cutscene:text("* What!?[wait:5]\n* But our [color:yellow]STORAGE[color:white] isn't full!", "determined", "jamm")
							cutscene:text("* Just put it in there!", "determined", "jamm")
							
							cutscene:showNametag("self", {font = "sans", right = false})
							cutscene:text("[font:sans]* sorry,[wait:5] kid.[wait:5]\n* i don't make the rules.", "neutral", "self")
							cutscene:text("[font:sans]* my boss makes the rules.", "neutral", "self")
							
							if cutscene:getCharacter("susie") then
								cutscene:showNametag("Jamm", {right = false})
								cutscene:text("* But aren't you--", "determined", "jamm", {auto = true})
								
								cutscene:showNametag("Susie", {right = false})
								cutscene:text("* We are NOT doing this again!", "teeth_b", "susie")
							end
						end
					end
				else
					Game.money = Game.money - 200
					Game.inventory:addItem("hotdog")
					cutscene:showNametag("self", {font = "sans", right = false})
					cutscene:text("[font:sans]* here you go.", "neutral", "self")
					cutscene:hideShop()
				end
			else
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* sorry,[wait:5] kid.[wait:5]\n* i don't offer credit.", "neutral", "self")
				cutscene:text("[font:sans]* try again when you're a little...", "neutral", "self")
				cutscene:text("[font:sans]* wait.[wait:5]\n* don't we have this character already?", "neutral", "self")
				cutscene:hideShop()
			end
		else
			cutscene:showNametag("self", {font = "sans", right = false})
			cutscene:text("[font:sans]* you're missing out.", "neutral", "self")
			cutscene:hideShop()
		end
		cutscene:hideNametag()
	end,
    s_elf_2 = function(cutscene, event)
		cutscene:showNametag("self", {font = "sans"})
		cutscene:text("[font:sans]* wow,[wait:5] you solved that puzzle quickly.", "neutral", "self")
		cutscene:text("[font:sans]* it's almost as if you saw xo puzzles before.", "neutral", "self")
		cutscene:text("[font:sans]* which is weird,[wait:5] since they're exclusive to here.", "neutral", "self")
		cutscene:hideNametag()
	end,
    s_elf_3 = function(cutscene, event)
		cutscene:showNametag("self", {font = "sans"})
		cutscene:text("[font:sans]* did you see the puzzle about 2 rooms ago?", "neutral", "self")
		cutscene:text("[font:sans]* yeah, my brother asked santa for that one year.", "neutral", "self")
		cutscene:text("[font:sans]* it almost looks a little like him, i think.", "neutral", "self")
		cutscene:text("[font:sans]* my brother's busy around this time of year, but he's cool.", "neutral", "self")
		cutscene:text("[font:sans]* anyways, i decided i wanted a puzzle for myself.", "neutral", "self")
		cutscene:text("[font:sans]* i'm no artist, but i think it looks good.", "neutral", "self")
		cutscene:hideNametag()
	end,
}
