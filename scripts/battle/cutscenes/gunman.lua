return {
    you_Heal = function(cutscene, battler, enemy)
        cutscene:text("* YOU healed the dummy!")
        cutscene:wait(2)
        Assets.playSound("error")
        cutscene:wait(2)
        cutscene:text("* ... Nevermind")
    end
}