return {
    captain_room = function(cutscene, event)
		if Game.world.player.y > 300 then
			Game.world.timer:tween(1, Game.world.map:getImageLayer("upper_half"), {alpha = 1})
			Game.world.timer:tween(1, Game.world.map:getImageLayer("lower_half"), {alpha = 0})
			cutscene:wait(cutscene:walkTo(Game.world.player, 320, 252, 1, "up"))
		else
			Game.world.timer:tween(1, Game.world.map:getImageLayer("upper_half"), {alpha = 0})
			Game.world.timer:tween(1, Game.world.map:getImageLayer("lower_half"), {alpha = 1})
			cutscene:wait(cutscene:walkTo(Game.world.player, 320, 348, 1, "down"))
		end
    end,
	
    journal = function(cutscene, event)
		cutscene:text("* (On the desk lies the captain's log, closed.)")
		cutscene:text("* (Will you read it?)")
		
		if cutscene:choicer({"Yes", "No"}) == 1 then
			
		else
			cutscene:text("* (You decide to leave it closed.)")
		end
    end,
	
    map = function(cutscene, event)
		cutscene:text("* It is a sea charter in a detachable frame.")
		cutscene:text("* On the sea charter is a path to the island you're headed to.")
		cutscene:text("* There is also a drawing of a ship labeled \"Do Not Approach\".")
		cutscene:text("* It seems that Captain Darkbeard planned out the whole trip.")
    end,
	
    deckdoor = function(cutscene, event)
		if not Game:getFlag("marcyquest_talk_to_captain_1") then
			cutscene:showNametag("Marcy")
			cutscene:text("* Marcy should talk to the captain first.", "neutral", "marcy")
			cutscene:hideNametag()
			cutscene:wait(cutscene:walkTo(Game.world.player, Game.world.player.x - 20, Game.world.player.y, 0.5))
		else
			cutscene:mapTransition("marcyquest/ship/captain", "deck", "right")
		end
    end,
	
    party_1 = function(cutscene, event, chara)
		local id = Game.party[event.partyslot].id
		if id == "dess" then
			cutscene:showNametag("Dess")
			cutscene:text("* yoooo sup Mini Jamm", "heckyeah", "dess")
			cutscene:showNametag("Marcy")
			cutscene:text("* Could you pl--", "happy", "marcy", {auto=true})
			cutscene:showNametag("Dess")
			cutscene:text("* Bro,[wait:5] this ship is sick", "heckyeah", "dess")
			cutscene:text("* I wonder how much Mug:tm: rootbeer I can smuggle into this thing", "wink", "dess")
			cutscene:text("* Also,[wait:5] where we going?[wait:10]\n* Are we going to find the One Piece?", "heckyeah", "dess")
		elseif id == "brenda" then
			cutscene:showNametag("Brenda")
			cutscene:text("* Oh,[wait:5] hey,[wait:5] Marcy![wait:10]\n* Are you ready for an adventure?", "happy", "brenda")
			cutscene:showNametag("Marcy")
			cutscene:text("* Marcy is ready!", "happy", "marcy")
			cutscene:showNametag("Brenda")
			cutscene:text("* That's great to hear!", "joy", "brenda")
			cutscene:text("* You know,[wait:5] the last time I was on a ship was...", "happy", "brenda")
			cutscene:text("* Hmm...", "neutral_side", "brenda")
			cutscene:showNametag("Marcy")
			cutscene:text("* Is something wrong,[wait:5] Aunt Brenda?", "confused", "marcy")
			cutscene:showNametag("Brenda")
			cutscene:text("* I just can't remember if I was on a boat before...", "frown_side", "brenda")
			cutscene:text("* Oh,[wait:5] well.[wait:10]\n* I'm sure it'll come back to me.", "happy", "brenda")
		elseif id == "mario" then
			cutscene:showNametag("Mario")
			cutscene:text("* Oh![wait:10]\n* Hello there!", "main", "mario")
			cutscene:text("* Are you ready to Mariocise?", "main", "mario")
			cutscene:showNametag("Marcy")
			cutscene:text("* Maybe another time...", "sad", "marcy")
			cutscene:showNametag("Mario")
			cutscene:text("* Okie dokie!", "main", "mario")
		elseif id == "berdly" then
			cutscene:showNametag("Berdly")
			cutscene:text("* Such a large craft this is...", "neutral", "berdly")
			cutscene:text("* However,[wait:5] I have played over 200 hours of Sea of Smugglers!", "laugh", "berdly")
			cutscene:text("* Piloting a craft such as this is a simple task for me!", "glorious", "berdly")
			cutscene:showNametag("Marcy")
			cutscene:text("* If you say so...", "disappointed", "marcy")
		elseif id == "susie" then
			cutscene:showNametag("Susie")
			cutscene:text("* Uh,[wait:5] we're not going far,[wait:5] are we?", "nervous", "susie")
			cutscene:text("* Between you and me,[wait:5] I get seasick easily...", "nervous_side", "susie")
			cutscene:showNametag("Marcy")
			cutscene:text("* What is \"seasick?\"", "disappointed", "marcy")
			cutscene:showNametag("Susie")
			cutscene:text("* It's when you can't handle being on a boat for lengths of time...", "nervous", "susie")
			cutscene:text("* So you end up getting dizzy and throwing up.", "sus_nervous", "susie")
			cutscene:text("* It's really cool.[wait:10]\n* You should try it sometime.", "smile", "susie")
		elseif id == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* Judging by the look on your face,[wait:5] you seem ready for this.", "neutral", "ceroba")
			cutscene:text("* You remind me of someone I knew,[wait:5] you know?", "smile", "ceroba")
			cutscene:text("* I've never been sailing,[wait:5] so this is new to me.", "notsure", "ceroba")
			cutscene:showNametag("Marcy")
			cutscene:text("* It's new to Marcy,[wait:5] too.", "smile", "marcy")
			cutscene:showNametag("Ceroba")
			cutscene:text("* Good to know I'm not alone,[wait:5] then.", "smile", "ceroba")
		elseif id == "YOU" then
			cutscene:hideNametag()
			cutscene:wait(Game.world.music:fade(0, 0.5))
			cutscene:wait(1)
			Assets.playSound("croak")
			cutscene:wait(1)
			cutscene:wait(Game.world.music:fade(1, 0.5))
			cutscene:wait(1)
		elseif id == "pauling" then
			cutscene:text("* She seems to be writing some sort of contract...")
		else
			cutscene:text("* This character's cutscene text has not been written.")
			cutscene:text("* Please contact " .. Game.party[event.partyslot].name .. "'s dev and tell them to write for marcyquest.party_1.")
		end
		cutscene:hideNametag()
    end,
}
