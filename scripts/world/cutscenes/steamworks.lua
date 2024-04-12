return {
    axis_meet = function(cutscene, event)
        local leader = Game.world.player
        local axis = cutscene:getCharacter("axis")
        local ceroba = cutscene:getCharacter("ceroba")
        local dess = cutscene:getCharacter("dess")

        Game.world.music:stop()
        cutscene:detachCamera()
        cutscene:detachFollowers()
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
        Game.world.music:play("enter_axis")
        cutscene:showNametag("Robot")
        cutscene:text("* INTRUDERS SPOTTED.[wait:5]\nSTEAMWORKS: EASTERN BRANCH.", "normal", "axis")
        --if dess and Game:getFlag("dungeonkiller") then
        if dess and Game:getFlag("dungeonkiller") then
            -- WIP
            cutscene:showNametag("Dess")
            cutscene:text("* I'll handle it.", "condescending", "dess")
            cutscene:hideNametag()
            cutscene:wait(cutscene:walkToSpeed(dess, axis.x+50, axis.y - 8, 20))
            cutscene:wait(0.2)
            Game.world.music:stop()
			Assets.playSound("laz_c")
		    dess:setAnimation("battle/attack")
		    dess.flip_x = true
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
            axis:setAnimation("damaged_right")
            cutscene:text("* ...", "damaged", "axis")
        elseif ceroba then
            if Game.party[1].id == "ceroba" then
            else
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
        end
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
        if ceroba then
            cutscene:showNametag("Ceroba")
            cutscene:text("* Oh no.", "surprised", "ceroba")
            cutscene:hideNametag()
        end

        for _,member in ipairs(Game.party) do
            local chara = Game.world:getCharacter(member.id)
            if chara then
                chara.sprite:setFacing("down")
            end
        end
        
        cutscene:wait(0.1)
        if ceroba then
            ceroba:setFacing("right")
        end
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
                if chara.actor.id == "ceroba" then
                else
                    cutscene:slideTo(chara, chara.x, chara.y + 800, 1)
                end
            end
        end
        cutscene:wait(2)
        for _,member in ipairs(Game.party) do
            local chara = Game.world:getCharacter(member.id)
            if chara then
                if chara.actor.id == "ceroba" then
                else
                    cutscene:slideTo(chara, chara.x, chara.y + 800, 1)
                end
            end
        end
        if ceroba then
            Game:removePartyMember("ceroba")
        end
        cutscene:mapTransition("steamworks/13")
        Game:setFlag("axis_met", true)
    end,
}