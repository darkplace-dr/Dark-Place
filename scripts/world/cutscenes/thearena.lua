return {
	bossfight = function(cutscene, event)
        cutscene:text("* Would you like to refight a boss?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            cutscene:after(function()
                Game.world:openMenu(BossRematchMenu())
            end)
        end
	end,
	bossrush = function(cutscene, event)
        cutscene:text("* Would you like to attempt a boss rush?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            cutscene:after(function()
                Game.world:openMenu(BossRushMenu())
            end)
        end
	end
}
