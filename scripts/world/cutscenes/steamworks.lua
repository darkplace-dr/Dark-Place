return {
    axis_meet = function(cutscene, event)
        local leader = Game.world.player
        local axis = cutscene:getCharacter("axis")
        local ceroba = cutscene:getCharacter("ceroba")
        local jamm = cutscene:getCharacter("jamm")
        local trapdoor = Game.world.map:getEvent("steamworks_trapdoor")

        Game.world.music:stop()
        cutscene:detachFollowers()
        if not ceroba then
            cutscene:endCutscene()
            Game.world:mapTransition("misc/dogcheck")
        end

        cutscene:walkTo(leader, event.x + event.width, event.y + event.height/2, 0.5, "left")
        cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), event.x + event.width + 30, event.y + event.height/2, 0.5, "left")
        if Game.party[3] then
            cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), event.x + event.width + 60, event.y + event.height/2, 0.5, "left")
        end
        if Game.party[4] then
            cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), event.x + event.width + 90, event.y + event.height/2, 0.5, "left")
        end

        cutscene:wait(1)
        cutscene:detachCamera()
        cutscene:panTo(Game.world.camera.x - 150, Game.world.camera.y)
        cutscene:wait(1.5)
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
            trapdoor:setSprite("world/events/steamworks/trapdoor", 1/10)
            cutscene:wait(0.5)
            Assets.playSound("trapdoor_open")
            cutscene:wait(1.1)
            trapdoor:setSprite("world/events/steamworks/trapdoor_16")

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
            Game:setFlag("ceroba_separated", true)
            cutscene:mapTransition("steamworks/13")
        end
        Game:setFlag("axis_met", true)
    end,
    basement_door = function(cutscene, event)
        if Game:getFlag("axis_basement_caught") == 2 then
            cutscene:text("* (The door is locked.)")
        else
            Game.world:mapTransition("steamworks/13b")
        end
    end,
    basement_axis = function(cutscene, event)
        local axis = cutscene:getCharacter("axis")
        cutscene:wait(cutscene:walkTo(axis, axis.x, event.y - 80, 0.5, "down"))

        cutscene:showNametag("Axis")
        if Game:getFlag("axis_basement_caught") ~= 1 then
            cutscene:text("* I CANNOT BELIEVE YOU\nFELL FOR THAT.", "normal", "axis")
            cutscene:text("* I AM SMART, THEREFORE I\nPREDICTED YOUR ESCAPE.", "normal", "axis")
            cutscene:text("* NOW, BACK YOU GO.", "normal", "axis")
            Game:setFlag("axis_basement_caught", 1)
        else
            cutscene:text("* WHAT. WHY.", "normal", "axis")
            cutscene:text("* DID YOU THINK I WOULD\nJUST LEAVE AFTER ONE\nATTEMPT?", "normal", "axis")
            cutscene:text("* ... I WAS ABOUT TO,\nACTUALLY. THAT WAS\nCLOSE.", "normal", "axis")
            cutscene:text("* I WILL LOCK THE DOOR\nFROM NOW ON.", "normal", "axis")
            cutscene:text("* BYE NOW.", "normal", "axis")
            Game:setFlag("axis_basement_caught", 2)
        end
        cutscene:hideNametag()
        
        cutscene:walkTo(axis, axis.x, axis.y + 200, 2, "down")
        Game.world:mapTransition("steamworks/13", "door")
    end,
    vent = function(cutscene, event)
        cutscene:text("* A slightly open vent.")
        local opinion = cutscene:textChoicer("* Go inside?\n", {"Yes", "    No"})
        if opinion == 1 then
            Game.world:mapTransition("steamworks/13", "vent")
        end
    end,
    ceroba_reunion = function(cutscene, event)
        local ceroba = cutscene:getCharacter("ceroba")
        cutscene:wait(1)
        for _,member in ipairs(Game.party) do
            local chara = Game.world:getCharacter(member.id)
            if chara then
                chara.sprite:setFacing("left")
            end
        end
        cutscene:wait(0.5)
        ceroba:setFacing("right")
        cutscene:wait(0.1)
        Assets.playSound("alert")
        ceroba.alert_icon = Sprite("effects/alert_yellow", ceroba.sprite.width/2)
        ceroba.alert_icon:play(1/10, false)
        ceroba.alert_icon:setOrigin(0.5, 1)
        ceroba.alert_icon.layer = 100
        ceroba:addChild(ceroba.alert_icon)
        Game.world.timer:after(0.8, function()
            ceroba.alert_icon:remove()
        end)
        cutscene:wait(1)
        cutscene:showNametag("Ceroba")
        cutscene:text("* Oh! There you are!", "smile", "ceroba")
        cutscene:text("* I knew you'd be smart enough to use the vents.", "snarky", "ceroba")
		if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
            cutscene:showNametag("Jamm")
            cutscene:text("* A little dusty,[wait:5] aren't they...", "look_left", "jamm")
            cutscene:showNametag("Ceroba")
			cutscene:text("* The Steamworks haven't been used in a long time...", "neutral", "ceroba")
			cutscene:text("* But what matters is that you found a way to escape.", "smile_alt", "ceroba")
			if Game:getFlag("marcy_joined") then
				cutscene:showNametag("Jamm")
				cutscene:text("* Warn me next time we have to go through vents, alright?", "look_left", "jamm")
				cutscene:text("* I mean,[wait:5] I have my daughter with me,[wait:5] after all.", "neutral", "jamm")
				cutscene:showNametag("Ceroba")
				cutscene:text("* Right...[react:1]", "sorrowful", "ceroba", {reactions = { 
				    {"Did I strike\na nerve???", 302, 50, "nervous", "jamm"}
			    }})
			end
		end
        cutscene:text("* Let's get going.", "smile", "ceroba")
        Game:addPartyMember("ceroba")
        cutscene:hideNametag()
        ceroba:convertToFollower()
        cutscene:attachFollowers()
        cutscene:wait(1)
        Game:setFlag("ceroba_separated", false)
        Game:setFlag("ceroba_party", true)
    end,
    first_robokill = function(cutscene, event)
        cutscene:showNametag("Ceroba")
        cutscene:text("* What are you thinking!?", "angry", "ceroba")
        cutscene:text("* I know they started the fight but we don't know the situation!", "irked", "ceroba")
        cutscene:text("* What if it was a glitch in their programming?", "irked", "ceroba")
        cutscene:text("* ...", "dissapproving", "ceroba")
        cutscene:text("* These bots are antiques.", "closed_eyes", "ceroba")
        cutscene:text("* We have no right to destroy them, got that?", "neutral", "ceroba")
        cutscene:text("* ...Sigh.", "closed_eyes", "ceroba")
        cutscene:text("* Just... don't do anything stupid.", "irked", "ceroba")
        cutscene:hideNametag()
    end,
    grandfather_clock = function(cutscene, event)
        if not Game:getFlag("grandfather_clock_talk") then
            cutscene:showNametag("Clock")
            cutscene:text("* Tick-tock - tick-tock -\ntick-tock...", nil, event)
            cutscene:text("* The current time is 6:26,\nMonday morning!", nil, event)
            cutscene:text("* You may have noticed the\napple trees outside the\nSteamworks are blooming.", nil, event)
            cutscene:text("* That means Spring is upon us!", nil, event)
            cutscene:text("* This time of year, my creator\nrecommends a picnic by the\nriver just south of here!", nil, event)
            cutscene:hideNametag()
            Game:setFlag("grandfather_clock_talk", 1)
        elseif Game:getFlag("grandfather_clock_talk") == 1 then
            cutscene:showNametag("Clock")
            cutscene:text("* Why the puzzled look? Have we\nnot met before?", nil, event)
            cutscene:showNametag("Grandfather Clock")
            cutscene:text("* I am the Grandfather Clock of\nthe Underground!", nil, event)
            cutscene:text("* It is my responsibility to\nkeep the standard time for all\nmonsters.", nil, event)
            cutscene:text("* However, I cannot help but\nfeel there is a miscalculation\nin my tick-tocking.", nil, event)
            cutscene:text("* It is simply driving me mad!", nil, event)
            cutscene:hideNametag()
            Game:setFlag("grandfather_clock_talk", 2)
        elseif Game:getFlag("grandfather_clock_talk") == 2 then
            cutscene:showNametag("Grandfather Clock")
            cutscene:text("* I do not sense the gears\nturning within these walls.", nil, event)
            cutscene:text("* Hm, yes, I believe the main\nclock face outside has stalled!", nil, event)
            cutscene:text("* An engineer should arrive to\nfix it soon.", nil, event)
            cutscene:text("* Do not worry, I will continue\nto keep the time!", nil, event)
            cutscene:hideNametag()
            Game:setFlag("grandfather_clock_talk", 3)
        elseif Game:getFlag("grandfather_clock_talk") == 3 then
            cutscene:showNametag("Grandfather Clock")
            cutscene:text("* Tick-tock - tick-tock -\ntick-tock...", nil, event)
            cutscene:hideNametag()
        end
    end,
    ceroba_kanako_talk = function(cutscene, event)
        local ceroba = cutscene:getCharacter("ceroba")
        cutscene:detachFollowers()

        cutscene:showNametag("Ceroba")
        cutscene:text("* Hey. How about we make a little stop here?", "neutral", "ceroba")
        cutscene:hideNametag()

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
    end,
}