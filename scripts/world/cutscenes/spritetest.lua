return function (cutscene, event)
        local susie = cutscene:getCharacter("susie")
        if susie then
        cutscene:detachFollowers()
        cutscene:text("* Arright,[wait:5] watch this.", "smile", "susie")
        Game.lock_movement = false
        susie:explode(0, 0, true)
        cutscene:wait(0.3)
        susie.actor.path = "party/susie/repainted"
        susie:resetSprite()
        cutscene:attachFollowers()
        cutscene:interpolateFollowers()
        end
    end
