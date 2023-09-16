return {

	reaction = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local dess = cutscene:getCharacter("dess")
		if susie then
			cutscene:showNametag("Susie")
			cutscene:text("* ...[wait:5] Hey, what's going on here?", "neutral_side", "susie")
			if dess then
				cutscene:showNametag("Dess")
				cutscene:text("* Just some dumb Garry's Mod modder-", "kind", "dess")
				cutscene:text("* Who didn't think of testing their mod first before releasing it.", "kind", "dess")
				cutscene:text("* Lame LMAO", "condescending", "dess")
			end
			cutscene:showNametag("Susie")
			cutscene:text("* Let's just hope it won't kill us.", "sus_nervous", "susie")
			cutscene:hideNametag()
		end
	end,
}
