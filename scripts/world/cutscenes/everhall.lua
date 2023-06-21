return {
	entry = function(cutscene, event)
		cutscene:wait(cutscene:fadeOut(0.25))
		if (Game:getFlag("hallways", 0) >= 5) then
			cutscene:text("* You walk all the way back to where you were...")
		end
		cutscene:loadMap("everhall", "leftmark")
		cutscene:wait(cutscene:fadeIn(0.25))
	end,
	exits = function(cutscene, event)
		cutscene:wait(cutscene:fadeOut(0.25))
		if (Game:getFlag("hallways", 0) >= 5) then
			cutscene:text("* You made it to room " .. Game:getFlag("hallways", 0) .. ".")
		end
		cutscene:loadMap("everhall_entry", "hall_exit")
		cutscene:wait(cutscene:fadeIn(0.25))
	end,
	progress = function(cutscene, event)
		cutscene:wait(cutscene:fadeOut(0.25))
		Game:addFlag("hallways", 1)
		if (Game:getFlag("hallways", 0) < 100) then
			cutscene:loadMap("everhall", "leftmark")
		else
			cutscene:loadMap("everhall_end", "entry")
		end
		cutscene:wait(cutscene:fadeIn(0.25))
	end,
}