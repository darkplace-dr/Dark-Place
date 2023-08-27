return {
    talk = function(cutscene, battler, enemy)
		local enemy = cutscene:getCharacter("fake_jamm")
		if Game.battle.turn_count == 3 then
			cutscene:battlerText(enemy, "Alright, enough playing around.", {})
		else
			cutscene:battlerText(enemy, "...", {})
		end
    end,
}