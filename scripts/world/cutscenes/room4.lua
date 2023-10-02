return {
    sam = function(cutscene, morshu)
		local susie = cutscene:getCharacter("susie")
		local sam = cutscene:getCharacter("sam")
		
		sam:setFlag("dont_load", true)
		
		cutscene:showNametag("Sam", {font = "sans"})
        cutscene:text("[font:sans]* heya", nil, "sans")
        cutscene:text("[font:sans]* i'm sam", nil, "sans")
		
		if susie then
			cutscene:showNametag("Susie")
            cutscene:text("* Don't you mean \"Sans\"?", "sus_nervous", "susie")
			
			cutscene:showNametag("Sam", {font = "sans"})
			cutscene:text("[font:sans]* no", nil, "sans")
		end
		cutscene:hideNametag()
		
		local encounter = cutscene:startEncounter("sam", true, {{"sam", sam}})

		Game:setFlag("sam_defeated", true)
		
		if susie then
			cutscene:showNametag("Susie")
            cutscene:text("* The hell was that about?", "sus_nervous", "susie")
			
			if cutscene:getCharacter("jamm") then
				cutscene:showNametag("Jamm")
				cutscene:text("* I know even less than you, Susie.", "nervous", "jamm")
			end
		end
		cutscene:hideNametag()
    end,
}