return {
    omegaspamton_intro = function(cutscene, battler, enemy)
        
		--Game.battle:setState("INTRO")
		cutscene:wait(0.5)
		
		if not Mod:isInRematchMode() then
			cutscene:getCharacter("brandon"):setAnimation("battle/idle")
			cutscene:getCharacter("susie"):setAnimation("battle/idle")
			cutscene:getCharacter("berdly"):setAnimation("battle/idle")
		end
		
		cutscene:wait(1)
		
		cutscene:shakeCamera(4)
		
		cutscene:moveTo(cutscene:getEnemies("omega_spamton")[1], 800, 1000, 2)
		
		cutscene:wait(7)
		
		cutscene:fadeOut(0.2, {color = {255, 255, 255}})
		Assets.playSound("screenshake")
		cutscene:fadeIn(5)
		cutscene:wait(3)
		
		cutscene:after(function() Game.battle:setState("ACTIONSELECT") end, true)
    end,
	omegaspamton_outro = function(cutscene, battler, enemy)
        --WIP
    end,
	omegaspamton_outro_alt = function(cutscene, battler, enemy)
        --WIP
    end,
}