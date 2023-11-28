return {
    start = function(cutscene, event)
        Game.world.map.sliding = true
    end,
    ending = function(cutscene, event)
        Game.world.map.sliding = false
		if Game.world.map.slide_time < Game:getFlag("slide_hs", 999) then
			Game:setFlag(Game.world.map.slide_time, Game.world.map.slide_time)
		end
    end,
}
