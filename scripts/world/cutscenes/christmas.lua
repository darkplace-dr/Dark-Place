return {
	door = function(cutscene, event)
		cutscene:text("* The door is frosted shut.")
		
		if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
			cutscene:showNametag("Jamm", {right = false})
			cutscene:text("* If my fire magic weren't on the fritz...", "nervous", "jamm")
			cutscene:text("* Then maybe this stubborn door I could blitz.", "nervous", "jamm")
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
					cutscene:text("* No,[wait:2] not you, YOU.[wait:5]\n[face:teeth_b]* That guy there!", "sus_nervous", "susie")
				end
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* huh?[wait:5]\n* you talking to me?[wait:5] should i be scared?", "neutral", "self")
				
				cutscene:showNametag("Susie", {right = false})
				cutscene:text("* You're that guy from the convenience store!", "teeth_b", "susie")
				
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* hmm...[wait:5]\n* i would remember working at a convenience store.", "neutral", "self")
				cutscene:text("[font:sans]* mistaken identity,[wait:5] that's for sure.", "neutral", "self")
			end
			
			cutscene:text("[font:sans]* the name's self,[wait:5] a cheerful skelf,[wait:5] that's me.", "neutral", "self")
			cutscene:text("[font:sans]* this hotdog stand's my haunt,[wait:5] by santa's workshop,[wait:5] you see.", "neutral", "self")
			
			if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
				cutscene:showNametag("Jamm", {right = false})
				cutscene:text("* Hot dogs,[wait:5] huh?[wait:10]\n* That's what's for lunch?", "nervous", "jamm")
				cutscene:text("* But this cold's enough to make your b-buns bunch!", "ouch", "jamm")
			
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* really,[wait:5] now?[wait:10] i don't feel any sense of cold.", "neutral", "self")
				cutscene:text("[font:sans]* you must be imagining things,[wait:5] if i may be so bold.", "neutral", "self")
			end
			
			if cutscene:getCharacter("brenda") then
				cutscene:showNametag("Brenda", {right = false})
				cutscene:text("* Hold on a sec,[wait:5] Self,[wait:5] I gotta know...", "neutral", "brenda")
				cutscene:text("* That meat...[wait:5] is it some you're allowed to show?", "neutral", "brenda")
			
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* would these taste worse if the answer went south?", "neutral", "self")
				
				cutscene:showNametag("Brenda", {right = false})
				cutscene:text("* I don't think so???", "shock", "brenda")
			
				cutscene:showNametag("self", {font = "sans", right = false})
				cutscene:text("[font:sans]* relax,[wait:5] these 'dogs are all aboveboard,[wait:5] no doubt.", "neutral", "self")
			end
			cutscene:showShop()
			cutscene:text("[font:sans]* how about it?[wait:5]\n* only 200 D$.", "neutral", "self")
			cutscene:text("[font:sans]* all you have'ta do is share me a hollar.", "neutral", "self")
		else
			cutscene:showShop()
			cutscene:text("[font:sans]* want a hot dog?[wait:5]\n* only 200 D$.", "neutral", "self")
			cutscene:text("[font:sans]* all you have'ta do is share me a hollar.", "neutral", "self")
		end
		cutscene:hideNametag()
		
		if cutscene:choicer({"Yes", "No"}) == 1 then
			if Game.money >= 200 then
				if Game.inventory:isFull("items", false) then
					cutscene:showNametag("self", {font = "sans", right = false})
					cutscene:text("[font:sans]* that [color:yellow]ITEMs[color:white] pocket's full,[wait:5] it seems like a crime...", "neutral", "self")
					cutscene:text("[font:sans]* but clear some space,[wait:5] and come back anytime.", "neutral", "self")
					cutscene:hideShop()
					if not Game.inventory:isFull("storage", false) then
						if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
							cutscene:showNametag("Jamm", {right = false})
							cutscene:text("* But our STORAGE ain't overflowin',[wait:5] that's a fact!", "determined", "jamm")
							cutscene:text("* Just shove it in there,[wait:5] this whole thing's a whack!", "determined", "jamm")
							
							cutscene:showNametag("self", {font = "sans", right = false})
							cutscene:text("[font:sans]* sorry,[wait:5] kid.[wait:5]\n* i don't make the rules.", "neutral", "self")
							cutscene:text("[font:sans]* my boss is the one with the tools.", "neutral", "self")
							
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
				cutscene:text("[font:sans]* no credit here,[wait:5] that must be a bummer...", "neutral", "self")
				cutscene:text("[font:sans]* but with more jingle,[wait:5] your belly's a rumbler.", "neutral", "self")
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
		cutscene:text("[font:sans]* that puzzle solved fast,[wait:5] a right nifty trick...", "neutral", "self")
		cutscene:text("[font:sans]* have you,[wait:5] by chance,[wait:5] encountered xo's slick picks?", "neutral", "self")
		cutscene:text("[font:sans]* but hold on,[wait:5] that can't be right...", "neutral", "self")
		cutscene:text("[font:sans]* xo puzzles are exclusive to here,[wait:5] in plain sight.", "neutral", "self")
		cutscene:hideNametag()
	end,
    s_elf_3 = function(cutscene, event)
		cutscene:showNametag("self", {font = "sans"})
		cutscene:text("[font:sans]* did that puzzle look oddly familiar and quaint?", "neutral", "self")
		cutscene:text("[font:sans]* my brother begged santa for it,[wait:5] a real brain-teaser,[wait:5] no saint!", "neutral", "self")
		cutscene:text("[font:sans]* the likeness is spooky,[wait:5] a right festive flair.", "neutral", "self")
		cutscene:text("[font:sans]* my brother's quite busy,[wait:5] but jolly and rare.", "neutral", "self")
		cutscene:text("[font:sans]* enough spooky talk,[wait:5] this puzzle's my prize.", "neutral", "self")
		cutscene:text("[font:sans]* no picassos here,[wait:5] but it shines in my eyes.", "neutral", "self")
		cutscene:hideNametag()
	end,
}
