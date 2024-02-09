return {
    menu = function(cutscene, event, party)
        cutscene:detachCamera()
        cutscene:detachFollowers()



        party = party or Game.party
        cutscene:text("* This is the multiplayer mode toggle.")
        cutscene:text("UP = I, LEFT = J,\nDOWN = K, RIGHT = L,\nCONFIRM = U, CANCEL = O")
        if Game.world.player2 then 
            cutscene:text("* Stop playing multiplayer?")
            local opinion = cutscene:choicer({"YES", "NO"})
            local party2 = Game.world:getCharacter(Game.party[2].actor.id)
            if opinion == 1 then
                party2:convertToFollower(1)
                Game:setFlag("2_player", false)
            else

            end
        elseif Game.party[2] then
            cutscene:text("* Please select the amount of players.")
            if Game.party[2] then
                local opinion = cutscene:choicer({"TWO", "CANCEL"})
                if opinion == 1 then
                    local party2 = Game.world:getCharacter(Game.party[2].actor.id)
                    party2:convertToPlayer2()
                    Game:setFlag("2_player", true)
                    cutscene:walkTo(Game.world.player, 760, 359, 0.75)
                    cutscene:walkTo(Game.world.player2, 880, 359, 0.75)
                    cutscene:wait(0.80)
                    cutscene:walkTo(Game.world.player, 760, 360, 0.1)
                    cutscene:walkTo(Game.world.player2, 880, 360, 0.1)
                    --if Game.world.player3 then
                    --else
                    --    Game.world:spawnPlayer3(x, y, Game.party[1]:getActor())
                    --end
                else
        
                end
            else
                local opinion = cutscene:choicer({"CANCEL"})
            end
        else
            cutscene:text("* You need at least TWO party members to use it.")
        end
        -- If we have Susie, play a cutscene
        local susie = cutscene:getCharacter("null/empty")
        if susie then
            -- Detach camera and followers (since characters will be moved)


            -- All text from now is spoken by Susie
            cutscene:setSpeaker(susie)
            cutscene:text("* Hey,[wait:5] think I can break\nthis wall?", "smile")

            -- Get the bottom-center of the broken wall
            local x = event.x + event.width/2
            local y = event.y + event.height/2

            -- Move Susie up to the wall over 0.75 seconds
            cutscene:walkTo(susie, x, y + 40, 0.75, "up")
            -- Move other party members behind Susie
            cutscene:walkTo(Game.world.player, x, y + 100, 0.75, "up")
            if cutscene:getCharacter("ralsei") then
                cutscene:walkTo("ralsei", x + 60, y + 100, 0.75, "up")
            end
            if cutscene:getCharacter("noelle") then
                cutscene:walkTo("noelle", x - 60, y + 100, 0.75, "up")
            end

            -- Wait 1.5 seconds
            cutscene:wait(1.5)

            -- Walk back,
            cutscene:wait(cutscene:walkTo(susie, x, y + 60, 0.5, "up", true))
            -- and run forward!
            cutscene:wait(cutscene:walkTo(susie, x, y + 20, 0.2))

            -- Slam!!
            Assets.playSound("impact")
            susie:shake(4)
            susie:setSprite("shock_up")

            -- Slide back a bit
            cutscene:slideTo(susie, x, y + 40, 0.1)
            cutscene:wait(1.5)

            -- owie
            susie:setAnimation({"away_scratch", 0.25, true})
            susie:shake(4)
            Assets.playSound("wing")

            cutscene:wait(1)
            cutscene:text("* Guess not.", "nervous")

            -- Reset Susie's sprite
            susie:resetSprite()

            -- Reattach the camera
            cutscene:attachCamera()

            -- Align the follower positions behind Kris's current position
            cutscene:alignFollowers()
            -- And reattach them, making them return to their target positions
            cutscene:attachFollowers()
            Game:setFlag("wall_hit", true)
        end
    -- Reattach the camera
    cutscene:attachCamera()
    -- Align the follower positions behind Kris's current position
    cutscene:alignFollowers()
    -- And reattach them, making them return to their target positions
    cutscene:attachFollowers()
    end
}
