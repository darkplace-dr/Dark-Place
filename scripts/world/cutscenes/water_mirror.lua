return {
    mirror_interact = function (cutscene, event)

        cutscene:text("* (It's just a crystal wall.[wait:10]\n* Not to be confused with a crystal ball.)")

        --[[
        cutscene:text("* (It's...[wait:15] you?)")
        if Game:getFlag("weird") then
            cutscene:text("* (Suddenly felt uneasy.)")
        else
            cutscene:text("* (A sudden uneasiness washes over you.)")
        end
        --]]


        --[[
        Game.lock_movement = false
        cutscene:wait(function ()
            return Game.world.player.y > 320
        end)
        cutscene:text("* Mirror party running at you goes here")
        Game:encounter("mirrormatch")
        --]]
    end,

    crystal_interact = function (cutscene, event) 
        cutscene:text("* (It's a glowing pink crystal.)\n* (The light faintly shines on your skin.)")
    end
}