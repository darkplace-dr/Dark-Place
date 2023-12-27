return {
    door = function(cutscene, event)
        cutscene:text("* It's a cracked wall.")
        if cutscene:getCharacter("susie") and cutscene:getCharacter("brandon") then

        elseif cutscene:getCharacter("susie") and not cutscene:getCharacter("brandon") then
            cutscene:showNametag("Susie")
            cutscene:text("... A dead end?", "", "susie")
        elseif cutscene:getCharacter("brandon") and not cutscene:getCharacter("susie") then

        else

        end
    end
}