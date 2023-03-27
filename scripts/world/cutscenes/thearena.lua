return {
	bossfight = function(cutscene, event)
        cutscene:text("* Would you like to refight a boss?")
        local opinion = cutscene:choicer({"Yes", "No"}, options)
        if opinion == 1 then
            cutscene:after(function()
                Game.world:openMenu(BossRematchMenu())
            end)
        end
	end
}
