return {
    bb = function(cutscene, event)
        local bb_sound = math.random(1, 3)
        if bb_sound <= 1 then
		    Assets.playSound("bb_hi")
        elseif bb_sound == 2 then
            Assets.playSound("bb_hello")
		else
            Assets.playSound("bb_laugh")
        end
        cutscene:text("[voice:nil]* HELLO FRIEND[wait:5]\n* WOULD YOU LIKE TO BUY SOME WARES", "90sbb/default")
		
        choice = cutscene:choicer({"Yes", "HELL NO"}, options)
		
        if choice == 1 then
        else
            Assets.playSound("bb_laugh")
            cutscene:text("[voice:nil]* FUCK YOU", "90sbb/default")
        end
    end,
}