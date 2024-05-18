return function(cutscene, event)
    cutscene:text("* A working jukebox.")
    cutscene:text("* Would you like to play a song?")

    if cutscene:choicer({"Yes", "No"}) == 1 then
        Assets.stopAndPlaySound("ui_select")
        cutscene:after(function()
            Game.world:openMenu(JukeboxMenu())
        end)
    else
        cutscene:text("* You decided to leave the jukebox in its undamaged state.")
    end
end