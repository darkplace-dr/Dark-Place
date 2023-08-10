return {
    darkposter = function(cutscene)
        cutscene:text("* (A poster with the words \"THE DARK\" written on it.)")
        cutscene:text("* (.[wait:5].[wait:5].[wait:5]very inviting.)")
	end,
    ponman_intro = function(cutscene)
        local susie = cutscene:getCharacter("susie")
        --local ponman = cutscene:spawnNPC("ponman_mobdt")
		
        cutscene:text("* pee pee town", nil, "susie") --placeholder text lmaoooooo
    end,
    ponman_poster = function(cutscene)
        cutscene:text("* (You seriously doubt that this whole experience was \"fuckin' fun\" to begin with.)")
    end,
}