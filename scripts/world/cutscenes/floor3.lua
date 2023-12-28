return {
    forgetmenot = function(cutscene, event)
        local flaurel = cutscene:getCharacter("flaurel")
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")

        Mod:rollFun()

        cutscene:showNametag("???????")
        cutscene:text("* FORGET ME NOT.")
        cutscene:hideNametag()

        flaurel:explode()
        player:explode(0, 0, true)
        if susie then
            susie:setSprite("shock_right")
        end
        cutscene:wait(0.25)

        Assets.stopSound("badexplosion")

        Kristal.hideBorder(0)
        Game.state = "GAMEOVER"
        Game.world:remove()
        Game.gameover = GameOver(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, "what the fuck")
        Game.stage:addChild(Game.gameover)
    end,

    elevator_strange = function(cutscene)
        local leader = Mod:getLeader("chara")
        cutscene:after(function()
            Mod:rollFun()
            Game:setFlag("met_strange_girl", true)
        end)

        cutscene:wait(0.25)
        cutscene:wait(cutscene:walkToSpeed(leader, leader.x, leader.y + 20, Game.world.player.walk_speed/2))
        cutscene:wait(0.5)
        cutscene:wait(cutscene:fadeOut(2))
        cutscene:wait(1.5)
        for i,follower in ipairs(Game.world.followers) do
            follower.visible = false
        end
        local x, y = Game.world.map:getMarker("entry_elevator")
        local twin = Game.world:spawnNPC("s_girl", x, y)
        cutscene:wait(cutscene:fadeIn(2))
        cutscene:wait(1.5)
        twin:setSprite("walk/right_2")
        cutscene:wait(cutscene:slideToSpeed(twin, twin.x+50, twin.y, 1.25))
        twin:setSprite("walk/down_2")
        cutscene:wait(cutscene:slideToSpeed(twin, twin.x, twin.y+120, 1.25))
        twin:resetSprite()
        cutscene:wait(1)
        cutscene:setTextboxTop(true)
        cutscene:text("* You're not the one I'm looking for.", nil, twin)
        twin:setSprite("walk/down_4")
        cutscene:wait(cutscene:slideToSpeed(twin, twin.x, SCREEN_HEIGHT+100, 1.25))
        cutscene:wait(cutscene:fadeOut(2))
        cutscene:wait(1.5)
        for i,follower in ipairs(Game.world.followers) do
            follower.visible = true
        end
        twin:remove()
        cutscene:wait(cutscene:fadeIn(2))
        cutscene:wait(1.5)
    end,

    greenroomplatter = function(cutscene)
        local platter = cutscene:getCharacter("ch3_platter")
        local flag = "chapter3_greenroom_platterinteracts"
        local banana

        if Game:getFlag(flag, 0) == 8 then
            banana = cutscene:spawnNPC("banana", 720, 436)
            banana.layer = platter.layer
            platter.layer = platter.layer + 1
            if platter.x == 720 and platter.y == 440 then
                cutscene:jumpTo(platter, 720, 320, 15, 1.2, "", "")
                if Game:getFlag(flag, 0) == 8 then
                    Game.world.music:pause()
                    cutscene:text("* (Oh)")
                    if not Game.inventory:addItem("banana") then
                        cutscene:text("* (But you did not have enough space.)")
                        if banana then
                            banana:remove()
                        end
                        cutscene:text("* (The banana is gone.)")
                        Game:setFlag(flag, 0)
                    else
                        if banana then
                            banana:remove()
                        end
                        Kristal.callEvent("completeAchievement", "banana")
                        cutscene:text("* (You got the banana.)")
                        Game:setFlag(flag, 9)
                    end
                    cutscene:jumpTo(platter, 720, 440, 15, 1.2, "", "")
                    platter.layer = platter.layer - 1
                    Game.world.music:resume()
                end
            end
        else
            if platter.x == 720 and platter.y == 440 then
                cutscene:jumpTo(platter, 720, 440, 15, 1.2, "", "")
                if Game:getFlag(flag, 0) <= 0 then
                    cutscene:text("* (There is nothing inside of the platter...)")
                    Game:setFlag(flag, 1)
                elseif Game:getFlag(flag, 0) == 1 then
                    cutscene:text("* (There is still nothing inside of the platter.)")
                    Game:setFlag(flag, 2)
                elseif Game:getFlag(flag, 0) == 2 then
                    cutscene:text("* (The platter remains empty.)")
                    Game:setFlag(flag, 3)
                elseif Game:getFlag(flag, 0) == 3 then
                    cutscene:text("* (Nothing can be seen inside of the platter...)")
                    Game:setFlag(flag, 4)
                elseif Game:getFlag(flag, 0) == 4 then
                    cutscene:text("* (Despite your great efforts, there is still nothing in the platter.)")
                    Game:setFlag(flag, 5)
                elseif Game:getFlag(flag, 0) == 5 then
                    cutscene:text("* (No matter how hard you try, the platter will forever stay empty.)")
                    Game:setFlag(flag, 6)
                elseif Game:getFlag(flag, 0) == 6 then
                    cutscene:text("* (And empty it is.)")
                    Game:setFlag(flag, 7)
                elseif Game:getFlag(flag, 0) == 7 then
                    cutscene:text("* (stop it you motherfu[next]")
                    cutscene:text("[instant]* (There is nothing inside of the platter.)")
                    Game:setFlag(flag, 8)
                elseif Game:getFlag(flag, 0) == 9 then
                    cutscene:text("* (There is nothing inside of the platter.)")
                end
            end
        end

    end,

}
