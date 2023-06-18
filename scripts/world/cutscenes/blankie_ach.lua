return {
    blankie = function(cutscene, event)
        cutscene:text("* You hold the blanket...\n* But for some reason the blankie skittered away from your hand")
        Assets.playSound("slidewhist")
        cutscene:wait(1.5)

        cutscene:showNametag("Velvet!Spamton")
        cutscene:setSpeaker("velvetspam")
        cutscene:text("* Wha? Huh? What the [fifty percent-off]?\n* What is this?!")
        cutscene:text("* Wait... is this...")
        cutscene:text("* My [specil] Blankie [[TM]]!\n* You came [[Back in Stock!]]")
        cutscene:text("* Where were you? I was [[FIND THE BEST DEALS]] for you!")
        cutscene:text("* Whatever it is, I'm never gonna [U snooze U lose] you again!")
        cutscene:hideNametag()

        Game.inventory:removeItem("blankie")

        Kristal.callEvent("completeAchievement", "blankiequest")
        Game:setFlag("blankie_returned", true)
    end
}
