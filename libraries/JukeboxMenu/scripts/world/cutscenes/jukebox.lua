return {
	normal = function(cutscene, event)
	cutscene:text("* A working jukebox.")
	cutscene:text("* Would you like to play a song?")
	local choice
    if Game.chapter == 2 then
        choice = cutscene:choicer({"Yes", "No"})
    end
		
    if choice == 1 then
		Assets.playSound("ui_select")
        cutscene:after(function()
            Game.world:openMenu(JukeboxMenu())
        end)
    else
        cutscene:text("* You decided to leave the jukebox in its undamaged\nstate.")
    end
end,
	simple = function(cutscene, event)
	cutscene:text("* A simplified jukebox.")
	cutscene:text("* Would you like to play a song?")
	local choice
    if Game.chapter == 2 then
        choice = cutscene:choicer({"Yes", "No"})
    end
		
    if choice == 1 then
		Assets.playSound("ui_select")
        cutscene:after(function()
            Game.world:openMenu(SimpleJukeboxMenu())
        end)
    else
        cutscene:text("* You decided to leave the jukebox in its undamaged\nstate.")
    end
end,
}