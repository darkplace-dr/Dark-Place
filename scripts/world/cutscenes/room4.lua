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
		
		if susie then
			cutscene:showNametag("Susie")
            cutscene:text("* The hell was that about?", "sus_nervous", "susie")
		end
		cutscene:hideNametag()
    end,
}