return {
    kill = function(cutscene, battler, enemy)
		
		cutscene:text("* Alright,[wait:10] you fuckin' uhhh ready for this?", "neutral", "dess")
		cutscene:text("* Okay here we go", "calm", "dess")
			
		cutscene:wait(2)
<<<<<<< Updated upstream
		enemy:defeat("KILL", true)
=======
		Game.battle.killed = true
		Game:addFlag("library_kills", 1)
		enemy:defeat("KILLED", true)
>>>>>>> Stashed changes
		enemy:explode(0, 0, false)
		cutscene:wait(2)
			
			
    end
}