return {
    unstun = function(cutscene, battler, enemy)
		local dess = cutscene:getCharacter("dess")
		local jamm = cutscene:getCharacter("jamm")
		cutscene:battlerText(dess, "took you long\nenough lol", {x=dess.x + 40, y=dess.y - 50, right=true})
		cutscene:battlerText(dess, "guess i can say\ni almost died", {x=dess.x + 40, y=dess.y - 50, right=true})
		if Game:getFlag("dungeonkiller") then
			cutscene:battlerText(jamm, "...", {x=jamm.x + 40, y=jamm.y - 50, right=true})
			cutscene:battlerText(dess, "Jamm, I...", {x=dess.x + 40, y=dess.y - 50, right=true})
		else
			cutscene:battlerText(jamm, "That thing is\nnot my wife.", {x=jamm.x + 40, y=jamm.y - 50, right=true})
			cutscene:battlerText(jamm, "To think I could\nmistake this\nbeing for my\ndarling.", {x=jamm.x + 40, y=jamm.y - 50, right=true})
			cutscene:battlerText(dess, "Jamm...", {x=dess.x + 40, y=dess.y - 50, right=true})
		end
		cutscene:text("* (Barrier has been registered to Jamm's ACTs.)")
		Game.battle:setState("ACTIONSELECT")
    end,
}