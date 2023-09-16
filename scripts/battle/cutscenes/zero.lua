return {
    start = function(cutscene, battler, enemy)

        local zero = Game.battle:getEnemyBattler("zero")
        zero:setAnimation("headphones_in")
        cutscene:wait(1)
        Assets.playSound("zero/casettesearch")
        cutscene:wait(1.8)
        zero:setAnimation("headphones_end")
        cutscene:wait(0.3)
        Assets.playSound("zero/tv_thump_full")
        Game.stage:addFX(ShaderFX(Mod.wave_shader, {
            ["wave_sine"] = function() return Kristal.getTime() * 1200 end,
            ["wave_mag"] = 10,
            ["wave_height"] = 1,
            ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
        }), "funky_mode")
        Game.stage:addFX(VHSFilter(), "introvhs")
        Game.battle.timer:after(0.585, function ()
            Game.stage:removeFX("funky_mode")
            Game.stage:removeFX("introvhs")
        end)

    end,
    
    ending = function(cutscene, battler, enemy)
        cutscene:wait(20/30)
    end

}