return {
    axis_meet = function(cutscene, event)
        local leader = Game.world.player
        local axis = cutscene:getCharacter("axis")
        local ceroba = cutscene:getCharacter("ceroba")
        local jamm = cutscene:getCharacter("jamm")

        Game.world.music:stop()
        cutscene:detachCamera()
        cutscene:detachFollowers()
        if not ceroba then
            cutscene:endCutscene()
            Game.world:mapTransition("misc/dogcheck")
        end
        cutscene:wait(1)
        Game.world.camera:setPosition(Game.world.camera.x - 150, Game.world.camera.y)
        cutscene:wait(1)
        local layer = Game.world.map:getTileLayer("closed_door")
		layer.visible = false
		Assets.playSound("metal_door_opens")
        Game.world:shakeCamera(5, 5, 0.8)
        cutscene:wait(0.5)

        cutscene:wait(1)
        cutscene:wait(cutscene:slideTo(axis, axis.x, leader.y, 0.2))
        cutscene:wait(0.1)
        cutscene:setAnimation(axis, "right")
        cutscene:wait(cutscene:slideTo(axis, axis.x + 100, leader.y, 0.2))
        Game.world.music:play("undertale_yellow/enter_axis")
        cutscene:showNametag("Robot")
        cutscene:text("* INTRUDERS SPOTTED.[wait:5]\nSTEAMWORKS: EASTERN BRANCH.", "normal", "axis")
        if jamm and Game:getFlag("dungeonkiller") then
            -- WIP
            cutscene:showNametag("Jamm")
            cutscene:text("* ...", "shaded_neutral", "jamm")
            cutscene:hideNametag()
            --cutscene:wait(cutscene:walkToSpeed(jamm, axis.x+50, axis.y - 8, 20))
            Assets.playSound("sling")
            cutscene:wait(0.2)
            Assets.playSound("damage")
            Game.world.music:stop()
		    jamm:setAnimation("battle/attack")
		    jamm.flip_x = true
            cutscene:wait(0.1)
            --axis:explode(0, 0, true)
            Assets.playSound("impact")
            axis:setSprite("redeyes/flyback")
            cutscene:wait(cutscene:slideTo(axis, axis.x - 294, leader.y, 0.4))
            axis:setAnimation("redeyes_shot_slam")
            Assets.playSound("impact")
            cutscene:wait(4)
            cutscene:text("* AH.. .", "damaged", "axis")
            axis:setAnimation("redeyes_shot_end")
            cutscene:wait(1)
            jamm.flip_x = false
            jamm:resetSprite()
            axis:setAnimation("damaged_right")
            cutscene:text("* ...", "damaged", "axis")

            axis:remove()
            cutscene:attachCamera()
            cutscene:attachFollowers()
            Game:setFlag("axis_damaged", true)
        else
            if Game.party[1].id ~= "ceroba" then
                cutscene:hideNametag()
                cutscene:wait(cutscene:walkTo(ceroba, leader.x - 80, axis.y, 0.6, "left"))
            end
            cutscene:showNametag("Ceroba")
            cutscene:text("* Wait,[wait:5] Axis,[wait:5] it's me,[wait:5] Ceroba!", "nervous", "ceroba")
            cutscene:text("* Don't you remember me?", "nervous_smile", "ceroba")
            cutscene:showNametag("Axis")
            cutscene:text("* I DO.[wait:5] AND TO YOUR KNOWLEDGE:[wait:5] I WAS NOT TALKING ABOUT YOU.", "normal", "axis")
            cutscene:showNametag("Ceroba")
            cutscene:text("* Oh,[wait:5] you're about them?", "neutral", "ceroba")
            cutscene:text("* They are with me,[wait:5] now can we pass?", "closed_eyes", "ceroba")
            cutscene:showNametag("Axis")
            cutscene:text("* NO.", "normal", "axis")
            cutscene:text("* PROTOCOL IS PROTOCOL,[wait:5] AND IT IS CLEAR:", "normal", "axis")
            cutscene:text("* I MUST CAPTURE ANY TRESPASSERS.", "normal", "axis")
            cutscene:hideNametag()
        
            Game.world.music:stop()
            local trapdoor = Sprite("world/cutscenes/steamworks/steamworks_trapdoor")
            trapdoor:setOrigin(0.5, 0.5)
            trapdoor:play(1/15, false)
            --leader:addChild(trapdoor)
            trapdoor:setPosition(leader:getRelativePos(leader.width/2, leader.height/2)) -- why tf it doesn't appear
            trapdoor.layer = leader.layer - 1
            cutscene:wait(0.2)
            Assets.playSound("trapdoor_open")

            cutscene:wait(1)
            cutscene:showNametag("Ceroba")
            cutscene:text("* Oh no.", "surprised", "ceroba")
            cutscene:hideNametag()

            for _,member in ipairs(Game.party) do
                local chara = Game.world:getCharacter(member.id)
                if chara then
                    chara.sprite:setFacing("down")
                end
            end
        
            cutscene:wait(0.1)
            ceroba:setFacing("right")
            cutscene:attachCamera()
            cutscene:wait(1)
            Assets.playSound("fall_trapdoor")

            if cutscene:getCharacter("susie") then
                cutscene:getCharacter("susie"):setSprite("fall")
                Assets.playSound("sussurprise")
            end

            for _,member in ipairs(Game.party) do
                local chara = Game.world:getCharacter(member.id)
                if chara then
                    if chara.actor.id ~= "ceroba" then
                        cutscene:slideTo(chara, chara.x, chara.y + 800, 1)
                    end
                end
            end
            cutscene:wait(2)
            for _,member in ipairs(Game.party) do
                local chara = Game.world:getCharacter(member.id)
                if chara then
                    if chara.actor.id ~= "ceroba" then
                        cutscene:slideTo(chara, chara.x, chara.y + 800, 1)
                    end
                end
            end
            Game:removePartyMember("ceroba")
            cutscene:mapTransition("steamworks/13")
        end
        Game:setFlag("axis_met", true)
    end,
    first_robokill = function(cutscene, event)
        cutscene:text("* What are you thinking!?", "angry", "ceroba")
        cutscene:text("* I know they started the fight but we don't know the situation!", "irked", "ceroba")
        cutscene:text("* What if it was a glitch in their programming?", "irked", "ceroba")
        cutscene:text("* ...", "dissapproving", "ceroba")
        cutscene:text("* These bots are antiques.", "closed_eyes", "ceroba")
        cutscene:text("* We have no right to destroy them, got that?", "neutral", "ceroba")
        cutscene:text("* ...Sigh.", "closed_eyes", "ceroba")
        cutscene:text("* Just... don't do anything stupid.", "irked", "ceroba")
    end,
    ceroba_kanako_talk = function(cutscene, event)
        local ceroba = cutscene:getCharacter("ceroba")
        cutscene:detachFollowers()

        cutscene:text("* Hey. How about we make a little stop here?", "neutral", "ceroba")

        if Game.party[1].id == "ceroba" then
            cutscene:walkTo(ceroba, "ceroba_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), "party1_1")
            if Game.party[3] then
                cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), "party2_1")
            end
            if Game.party[4] then
                cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), "party3_1")
            end
        elseif Game.party[2].id == "ceroba" then
            cutscene:walkTo(ceroba, "ceroba_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[1].id), "party1_1")
            if Game.party[3] then
                cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), "party2_1")
            end
            if Game.party[4] then
                cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), "party3_1")
            end
        elseif Game.party[3].id == "ceroba" then
            cutscene:walkTo(ceroba, "ceroba_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[1].id), "party1_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), "party2_1")
            if Game.party[4] then
                cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), "party3_1")
            end
        elseif Game.party[4].id == "ceroba" then
            cutscene:walkTo(ceroba, "ceroba_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[1].id), "party1_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), "party2_1")
            cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), "party3_1")
        end

        cutscene:wait(2)
        cutscene:attachFollowers()
    end
}