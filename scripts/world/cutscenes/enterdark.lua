return function(cutscene)

    local third if Game.party[3] then third = Game.party[3].id else third = "no" end
    --this is just in case there is no party member in this slot

    local kris = cutscene:getCharacter(Game.party[1].actor.id)
    local susie if Game.party[2] then susie = cutscene:getCharacter(Game.party[2].actor.id) end
    local noelle if Game.party[3] then noelle = cutscene:getCharacter(Game.party[3].actor.id) end

    cutscene:detachCamera()
    cutscene:detachFollowers()

    cutscene:slideTo(kris,  620 - 30, 280, 0.25)
    if Game.party[2] then
        cutscene:slideTo(susie, 620 + 30, 280, 0.25)
    end
    if Game.party[3] then
        cutscene:slideTo(noelle,  620, 280, 0.25)
    end
    cutscene:panTo(620, 245, 0.25)
    cutscene:wait(0.25)

    kris.visible = false
    if Game.party[2] then
        susie.visible = false
    end
    if Game.party[3] then
        noelle.visible = false
    end

    local kris_x,  kris_y  = kris :localToScreenPos(0, 0)

    local susie_x, susie_y if Game.party[2] then susie_x, susie_y = susie:localToScreenPos(0, 0) end

    local noelle_x, noelle_y if Game.party[3] then noelle_x, noelle_y = noelle:localToScreenPos(0, 0) end


    local transition = DarkTransitionTrio(280, {skiprunback = false, thirdName = ""..third..""})
    transition.layer = 99999

    transition.kris_x = kris_x / 2
    transition.kris_y = kris_y / 2
    if Game.party[2] then
        transition.susie_x = susie_x / 2
        transition.susie_y = susie_y / 2
    end
    if Game.party[3] then
        transition.third_x = noelle_x / 2
        transition.third_y = noelle_y / 2
    end

    Game.world:addChild(transition)

    local waiting = true
    transition.end_callback = function()
        waiting = false
    end

    local wait_func = function() return not waiting end
    cutscene:wait(wait_func)

    local kx, ky = transition.kris_sprite:localToScreenPos(transition.kris_width / 2, 0)
    -- Hardcoded offsets for now...
    Game.world.player:setScreenPos(kx - 2, transition.final_y - 2)
    Game.world.player.visible = true
    Game.world.player:setFacing("down")

    if Game.party[2] then
        local sx, sy = transition.susie_sprite:localToScreenPos(transition.susie_width / 2, 0)
        if Game.party[3] then
            --local nx, ny = transition.noelle_sprite:localToScreenPos(transition.susie_width / 2, 0)
            --this is for later
            noelle.visible = true
            noelle:interpolateHistory()
            noelle:setFacing("down")
        end
        Game.world.followers[1]:setScreenPos(sx - 2, transition.final_y - 2)
        Game.world.followers[1].visible = true
        Game.world.followers[1]:interpolateHistory()
        Game.world.followers[1]:setFacing("down")
    end
    cutscene:attachCamera()
    cutscene:attachFollowers()
    if Game.party[2] then
        Game.world.followers[1]:setFacing("down")
    end

    --Gamestate.switch(Kristal.States["DarkTransition"], "map", {
    --    kris_x  = kris_x/2,
    --    kris_y  = kris_y/2,
    --    susie_x = susie_x/2,
    --    susie_y = susie_y/2
    --})
end