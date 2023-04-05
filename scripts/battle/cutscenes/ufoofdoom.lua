return {
    kill = function(cutscene, battler, enemy)
		cutscene:text("* Alright,[wait:10] you fuckin' uhhh ready for this?", "neutral", "dess")
		cutscene:text("* Okay here we go", "calm", "dess")

		cutscene:wait(2)
		enemy:defeat("KILLED", true)
		enemy:explode(0, 0, false)
		cutscene:wait(2)
    end
}