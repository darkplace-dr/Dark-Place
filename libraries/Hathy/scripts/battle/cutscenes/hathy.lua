return {
    x_flatter = function(cutscene, battler, enemy)
        for _, enemy in ipairs(Game.battle.enemies) do
            enemy:addMercy(100)
        end

        cutscene:text("* You ordered Ralsei to flatter all the enemies!")

        local dlg = love.math.random(1, 3)
        if dlg == 1 then
            cutscene:text("* Out of anyone,[wait:5] I'm glad we randomly encountered all of you.", "smile", "ralsei")
        elseif dlg == 2 then
            cutscene:text("* I'm making tea later...[wait:10]\n* Umm,[wait:5] would you like any?", "smile", "ralsei")
        else
            cutscene:text("* We don't need EXP.[wait:10]\n* Just encountering your smile is reward enough.", "smile", "ralsei")
        end
    end,

    s_flatter = function(cutscene, battler, enemy)
        for _, enemy in ipairs(Game.battle.enemies) do
            enemy:addMercy(100)
        end

        cutscene:text("* You ordered Susie to flatter all the enemies!")

        local dlg = love.math.random(1, 3)
        cutscene:text("* Can't believe my bozo teammates...", "neutral", "susie")
        if dlg == 1 then
            cutscene:text("* ... came back here just to see YOU guys.", "smile", "susie")
        elseif dlg == 2 then
            cutscene:text("* ... wanted to fight someone like YOU so much.", "smile", "susie")
        else
            cutscene:text("* ... have a THING for weaklings like you.", "smile", "susie")
        end
    end
}