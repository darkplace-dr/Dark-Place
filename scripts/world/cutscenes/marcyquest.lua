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
}
