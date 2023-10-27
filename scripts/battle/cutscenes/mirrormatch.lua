return {
    no_escape = function(cutscene, battler, enemy)
        Game.battle.encounter.timer:pause()

        for i in ipairs(Game.battle.party) do
            Game.battle.party[i].active = false
        end

        for i in ipairs(Game.battle.enemies) do
            Game.battle.enemies[i].active = false
        end



        Game.battle.encounter.bg:removeFX("funky_mode")
        local stutter_point = Game.battle.music:tell()
        Game.battle.timer:everyInstant(1/30, function ()
            Game.battle.music:seek(stutter_point)
        end, 30)
        cutscene:wait(1)
        Game.battle.encounter.timer:unpause()

        for i in ipairs(Game.battle.party) do
            Game.battle.party[i].active = true
        end

        for i in ipairs(Game.battle.enemies) do
            Game.battle.enemies[i].active = true
        end

        Game.battle.encounter.bg:addFX(Game.battle.encounter.bg_wave, "funky_mode")
        cutscene:after(function ()
            Game.battle:setState("DIALOGUEEND")
        end)
    end,

	end_battle = function(cutscene)
		Game.battle:returnToWorld() -- don't do this pls it crashes
	end
}