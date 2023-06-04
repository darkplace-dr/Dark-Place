return {
	blankie = function(cutscene, event)
        cutscene:text("* You hold the blanket...\n* But for some reason the blankie skittered away from your hand")
        Assets.playSound("slidewhist")
        cutscene:wait(1.5)
        
        cutscene:showNametag("Velvet!Spamton")
        cutscene:text("[voice:spamton]* Wha? Huh? What the [fifty percent-off]?\n* What is this?!")
        cutscene:text("[voice:spamton]* Wait... is this...")
        cutscene:text("[voice:spamton]* My [specil] Blankie [[TM]]!\n* You came [[Back in Stock!]]")
        cutscene:text("[voice:spamton]* Where were you? I was [[FIND THE BEST DEALS]] for you!")
        cutscene:text("[voice:spamton]* Whatever it is, I'm never gonna [U snooze U lose] you again!")

        cutscene:hideNametag() 
        Kristal.callEvent("completeAchievement", "blankiequest")
	end
}
