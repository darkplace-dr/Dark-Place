return {
    blackdoor = function(cutscene, event)
        cutscene:text("[voice:omori][style:none][font:OMORI]A black door casts a heavy shadow...")
        cutscene:text("[voice:omori][style:none][font:OMORI]Will you enter it?")

        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 2 then
            cutscene:text("[voice:omori][style:none][font:OMORI]You doorn't.")
            return
        end

        cutscene:text("[voice:omori][style:none][font:OMORI]You opened the door...")
        cutscene:fadeOut(2, {color = {0, 0, 0}, music = true})
        cutscene:wait(2)
        Game.fader.fade_color = {0, 0, 0} -- overwrite default for mapTransition
        if Game.world.map.id == "room3" then
            cutscene:mapTransition("BlackSpace/blackspace_hub", "entry")
        elseif Game.world.map.id == "BlackSpace/blackspace_hub" then
            cutscene:mapTransition("room3", "exit_whitespace")
        end
        cutscene:look("down")
        cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}}))
    end
}
