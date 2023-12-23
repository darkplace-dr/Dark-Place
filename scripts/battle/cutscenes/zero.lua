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
        Game.stage:addFX(ShaderFX(Mod.shaders["wave"], {
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

    killed = function(cutscene, battler, enemy)
        local zero = Game.battle:getEnemyBattler("zero")
        cutscene:wait(4)
        Game.stage:addFX(ShaderFX(Mod.shaders["wave"], {
            ["wave_sine"] = function() return Kristal.getTime() * 1200 end,
            ["wave_mag"] = 20,
            ["wave_height"] = 1,
            ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
        }), "funky_mode")
        Game.stage:addFX(VHSFilter(), "introvhs")
        Game.battle.timer:after(0.585, function ()
            Game.stage:removeFX("funky_mode")
            Game.stage:removeFX("introvhs")
        end)
        Assets.playSound("zero/rewind")
        cutscene:wait(0.479)

        for i,battler in ipairs(Game.battle.party) do
            Game.battle:pushForcedAction(battler, "SKIP")
            battler:setAnimation("battle/idle")
        end
        zero:setAnimation("idle")
        cutscene:wait(0.479)
        Game.stage:removeFX("funky_mode")
        Game.stage:removeFX("introvhs")

        cutscene:wait(2)

        zero.x = zero.x - 40
        zero.flip_x = true
        zero:setAnimation("run")
        Assets.playSound("escaped")
        cutscene:slideTo(zero, 690, 216, 0.5)

        cutscene:wait(2)
        cutscene:after(function ()
        Game.battle:setState("ACTIONSDONE")
        Game.battle.encounter.endfight = true
        end)
    end,

    spared = function(cutscene, battler, enemy)
        local zero = Game.battle:getEnemyBattler("zero")
        local doneyet = false
        Game.battle.timer:every(1/30, function ()
        if doneyet == false then
        Game.battle:setState("CUTSCENE") -- FUCK you, stop going back to my turn in the middle of the cutscene
        end
        end)
        cutscene:wait(1)
        zero:setAnimation("getup")
        cutscene:wait(2)

        zero.x = zero.x - 40
        zero.flip_x = true
        zero:setAnimation("run")
        Assets.playSound("escaped")
        cutscene:slideTo(zero, 690, 216, 0.5)

        cutscene:wait(2)
        cutscene:after(function ()
        doneyet = true
        Game.battle:setState("ACTIONSDONE")
        Game.battle.encounter.endfight = true
        end)
    end


}