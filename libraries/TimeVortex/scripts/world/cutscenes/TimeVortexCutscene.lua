return {
    
    roombor = function(cutscene)

        local kris = cutscene:getCharacter("YOU")
        local susie = cutscene:getCharacter("susie")

        cutscene:detachCamera()
        cutscene:detachFollowers()

        
        cutscene:wait(0.25)

        kris.visible           = false
        susie.visible          = false

        local kris_x, kris_y   = kris:localToScreenPos(0, 0)
        local susie_x, susie_y = susie:localToScreenPos(0, 0)

        local transition       = TimeVortex(280, { skiprunback = false, lightworld = false, YOU = true })
        transition.layer       = 99999

        transition.kris_x      = kris_x / 2
        transition.kris_y      = kris_y / 2
        transition.susie_x     = susie_x / 2
        transition.susie_y     = susie_y / 2

        Game.world:addChild(transition)

        local waiting = true
        transition.end_callback = function()
            waiting = false
        end

        transition.loading_callback = function()
            cutscene:loadMap("cloudwebs/cloudwebs_entrance")
            Game.world.music:stop()
            Kristal.hideBorder(0)

            Game.world.player.visible = false
            Game.world:getCharacter("susie").visible = false
        end

        local wait_func = function() return not waiting end
        cutscene:wait(wait_func)

        local kx, ky = transition.kris_sprite:localToScreenPos(transition.kris_width / 2, 0)
        -- Hardcoded offsets for now...
        Game.world.player:setScreenPos(kx - 2, transition.final_y - 2)
        Game.world.player.visible = true
        Game.world.player:setFacing("down")

        if not transition.kris_only and Game.world.followers[1] then
            local sx, sy = transition.susie_sprite:localToScreenPos(transition.susie_width / 2, 0)
            Game.world.followers[1]:setScreenPos(sx + 6, transition.final_y - 6)
            Game.world.followers[1].visible = true
            Game.world.followers[1]:interpolateHistory()
            Game.world.followers[1]:setFacing("down")
        end
        
        cutscene:attachCamera()
        cutscene:attachFollowers()

        --Gamestate.switch(Kristal.States["DarkTransition"], "map", {
        --    kris_x  = kris_x/2,
        --    kris_y  = kris_y/2,
        --    susie_x = susie_x/2,
        --    susie_y = susie_y/2
        --})
    end

}
