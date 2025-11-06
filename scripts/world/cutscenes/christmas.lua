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
    s_elf_door = function(cutscene, event)
		cutscene:text("* It is a door shaped like Self the Skelf.")
		cutscene:text("* It's almost as if it was made for himself.")
	end,
	enter = function(cutscene, event)
		local function scan_cutscene(char_id)
			
		end
		
		if Game:getFlag("whale_party") then
			cutscene:text("* (To access this quest, remove Whale from your party.)")
			cutscene:text("* (...Don't blame me.)")
			return
		end
		
		cutscene:text("* (Before you enter Santa's workshop...)")
		cutscene:text("* (Know you must beat the quest, you can't stop.)")
		cutscene:text("* (Not only that,[wait:5] but the Christmas event isn't complete.)")
		cutscene:text("* (The Christmas quest,[wait:5] you won't be able to beat.)")
		cutscene:text("* Will you begin this quest?")
		if cutscene:choicer({"Yes", "No"}) == 1 then
			cutscene:text("* You decide that this is for the best.")
			cutscene:wait(cutscene:mapTransition("christmas/workshop/entrance", "entry"))
			cutscene:wait(cutscene:walkToSpeed(Game.world.player, "player_walkto", 4, "right"))
			cutscene:detachFollowers()
			for k,v in ipairs(Game.world.followers) do
				cutscene:look(v, "right")
			end
			cutscene:showNametag("self", {font = "sans"})
			cutscene:text("[font:sans]* hold on,[wait:5] kids.[wait:10] before you enter here...", "neutral", "self")
			cutscene:text("[font:sans]* i'm scanning your lists,[wait:5] just so we're clear.", "neutral", "self")
			cutscene:text("[font:sans]* it'll make no real difference,[wait:5] you are who you be...", "neutral", "self")
			cutscene:text("[font:sans]* so with that out of the way,[wait:5] here's what i see.", "neutral", "self")
			cutscene:hideNametag()
			cutscene:wait(cutscene:walkToSpeed(cutscene:getCharacter("self"), "self_walk_1", 4))
			cutscene:wait(cutscene:walkToSpeed(cutscene:getCharacter("self"), "self_walk_2", 4))
			local scanned = 0
			local to_scan = {}
			for k,v in ipairs(Game.party) do
				table.insert(to_scan, v.id)
			end
			
			cutscene:showNametag("self", {font = "sans"})
			local available = {"jamm", "dess", "YOU", "susie", "brenda", "mario", "noel", "ceroba", "berdly", "pauling", "osw"}
			
			-- Scanning
			for k,v in ipairs(to_scan) do
				cutscene:look(cutscene:getCharacter("self"), "up")
				if TableUtils.contains(available, v) then
					scanned = scanned + 1
					if v == "jamm" then
						if Game:getFlag("marcy_joined") then
							cutscene:text("[font:sans]* jamm and marcy,[wait:5] you're both on the nice list.", "neutral", "self")
							cutscene:text("[font:sans]* and also,[wait:5] i heard.[wait:10] ania will be missed.", "neutral", "self")
						else
							cutscene:text("[font:sans]* jamm,[wait:5] it shows me that you're on the nice list...", "neutral", "self")
							if Game:getFlag("dungeonkiller") then
								cutscene:look(cutscene:getCharacter("self"), "left")
								cutscene:text("[font:sans]* however,[wait:5] i can tell that you're still quite pissed.", "neutral", "self")
							else
								cutscene:text("[font:sans]* and also,[wait:5] i heard.[wait:10] ania will be missed.", "neutral", "self")
							end
							
						end
					elseif v == "dess" then
						cutscene:text("[font:sans]* dess,[wait:5] it tells me that you have been naughty...", "neutral", "self")
						cutscene:text("[font:sans]* and that you've never been on the nice list,[wait:5] i see.", "neutral", "self")
					elseif v == "YOU" then
						cutscene:text("[font:sans]* you the frog,[wait:5] it says you've been naughty...", "neutral", "self")
						cutscene:text("[font:sans]* ...and that you still owe some rent money?", "neutral", "self")
					elseif v == "susie" then
						cutscene:text("[font:sans]* susie,[wait:5] i think this may come as a surprise...", "neutral", "self")
						cutscene:look(cutscene:getCharacter("self"), "left")
						cutscene:text("[font:sans]* but your niceness seems to be on the rise.", "neutral", "self")
					elseif v == "brenda" then
						cutscene:text("[font:sans]* brenda, it seems you've been very nice this year.", "neutral", "self")
						cutscene:look(cutscene:getCharacter("self"), "left")
						cutscene:text("[font:sans]* i bet that must be really good to hear.", "neutral", "self")
					elseif v == "mario" then
						cutscene:text("[font:sans]* mario,[wait:5] surprisingly,[wait:5] you're on the nice list this time...", "neutral", "self")
						cutscene:text("[font:sans]* even criminals need a break,[wait:5] i guess,[wait:5] sometimes.", "neutral", "self")
					elseif v == "noel" then
						cutscene:text("[font:sans]* next up,[wait:5] noel,[wait:5] this machine can't place you anywhere...", "neutral", "self")
						cutscene:look(cutscene:getCharacter("self"), "left")
						cutscene:text("[font:sans]* are you sure that you're even on a list here?", "neutral", "self")
					elseif v == "ceroba" then
						cutscene:text("[font:sans]* ceroba,[wait:5] on the nice list is where you have been set.", "neutral", "self")
						cutscene:look(cutscene:getCharacter("self"), "left")
						cutscene:text("[font:sans]* what's with that look?[wait:10]\n* every year,[wait:5] it gets reset.", "neutral", "self")
					elseif v == "berdly" then
						cutscene:text("[font:sans]* unfortunately,[wait:5] berdly,[wait:5] you weren't so lucky this year.", "neutral", "self")
						cutscene:text("[font:sans]* however,[wait:5] there's always next year,[wait:5] so no need to fear.", "neutral", "self")
					elseif v == "pauling" then
						cutscene:text("[font:sans]* pauling,[wait:5] you have been put on the nice list this year...", "neutral", "self")
						cutscene:text("[font:sans]* but it's been a close margin,[wait:5] you made it by a shear.", "neutral", "self")
					elseif v == "osw" then
						cutscene:text("[font:sans]* starwalker,[wait:5] you've been a good star,[wait:5] it seems.", "neutral", "self")
						cutscene:text("[font:sans]* maybe unoriginal,[wait:5] but welcome,[wait:5] for your team.", "neutral", "self")
					end
				end
			end
			
			cutscene:look(cutscene:getCharacter("self"), "left")
			
			-- scanning done
			if scanned < #Game.party then
				cutscene:text("[font:sans]* that's all that showed up,[wait:5] but some are not on the list.", "neutral", "self")
				cutscene:text("[font:sans]* go to the dark place server and mention who i missed.", "neutral", "self")
				cutscene:text("[font:sans]* tell the devs to add those ones to my scan...", "neutral", "self")
				cutscene:text("[font:sans]* because i'm sorry,[wait:5] but i've done all i can.", "neutral", "self")
			end
			cutscene:text("[font:sans]* in any case,[wait:5] my work for today is done...", "neutral", "self")
			cutscene:text("[font:sans]* maybe i can go home and rest a skele-[color:yellow]ton[color:white].", "neutral", "self")
			cutscene:hideNametag()
			cutscene:wait(cutscene:walkToSpeed(cutscene:getCharacter("self"), "self_walk_1", 4))
			cutscene:wait(cutscene:walkToSpeed(cutscene:getCharacter("self"), "self_walk_3", 4))
			cutscene:attachFollowers()
			cutscene:wait(0.5)
			cutscene:wait(cutscene:walkToSpeed(Game.world.player, "player_walkto_2", 4))
		else
			cutscene:text("* You decide you're not ready for the test.")
			cutscene:wait(cutscene:walkTo(Game.world.player, Game.world.player.x, Game.world.player.y+40))
		end
	end,
}
