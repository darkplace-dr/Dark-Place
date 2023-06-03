return {
    brandon = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: BRANDONK7200\"")
        if not cutscene:getCharacter("brandon") then
            cutscene:text("* It appears to be locked.")
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Hold on guys,[wait:5] I got this.", "happy_side", "brandon")
            cutscene:hideNametag()
            cutscene:text("* Brandon took a key out from his pocket and unlocked the door.")
            cutscene:text("* Will you go inside?")
            local opinion = cutscene:choicer({"Yes", "No"})
            if opinion == 1 then
                Assets.playSound("dooropen")
                cutscene:text("* You open the door.")
            else
                cutscene:showNametag("Brandon")
                cutscene:text("* Uh,[wait:5] okay then?", "suspicious", "brandon")
                cutscene:hideNametag()
                cutscene:text("* Brandon relocked the door.")
            end
        end
    end,
}