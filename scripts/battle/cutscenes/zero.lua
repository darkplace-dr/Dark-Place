return {
    start = function(cutscene, battler, enemy)
        
        Game.battle.music:play("zero_boss")
        cutscene:wait(2)
        local zero = Game.battle:getEnemyBattler("zero")
        cutscene:wait(2)
        zero:setAnimation("idle")
        --cutscene:after(function() Game.battle:setState("INTRO") end, true)

    end,
    
    ending = function(cutscene, battler, enemy)
        cutscene:wait(20/30)
    end

}