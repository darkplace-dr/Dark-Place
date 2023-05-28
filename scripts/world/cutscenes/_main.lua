return {

    introcutscene = function(cutscene)
        local text

        local function gonerTextFade(wait)
            local this_text = text
            Game.world.timer:tween(1, this_text, {alpha = 0}, "linear", function()
                this_text:remove()
            end)
            if wait ~= false then
                cutscene:wait(1)
            end
        end

        local function gonerText(str, advance)
            text = DialogueText("[speed:0.5][spacing:6][style:GONER][voice:none]" .. str, 160, 100, 640, 480, {auto_size = true})
            text.layer = WORLD_LAYERS["top"] + 100
            text.skip_speed = true
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)

            if advance ~= false then
                cutscene:wait(function() return not text:isTyping() end)
                gonerTextFade(true)
            end
        end

        --cutscene:fadeOut(0.5, {music = true})
        cutscene:fadeOut(0, {music = true})
        cutscene:wait(2)
        gonerText("ARE YOU[wait:40]\nTHERE?[wait:20]")
        cutscene:wait(0.5)
        gonerText("ARE WE[wait:40]\nCONNECTED?[wait:20]")

        cutscene:wait(0.5)

        local soul = SoulAppearance(SCREEN_WIDTH/2 - 25, SCREEN_HEIGHT/2 + 20)
        soul.layer = WORLD_LAYERS["top"] + 100
        --soul.alpha = 50
        --soul.graphics.fade = 0.01
        --soul.graphics.fade_to = 1
        Game.world:addChild(soul)
        cutscene:during(function()
            soul.y = SCREEN_HEIGHT/2 + 20 + math.sin(Kristal.getTime() * 2) * 6
        end)
        cutscene:wait(1.5)

        gonerText("AIGHT, BET.[wait:20]")
        cutscene:wait(0.1)
        gonerText("NOW.[wait:20]")
        cutscene:wait(0.5)
        gonerText("WE MAY...[wait:40]\"PROCEED\".[wait:20]\n(GET IT? LOL!!)[wait:20]")
        cutscene:wait(0.5)

        soul:hide()

        cutscene:wait(1.5)
        
        --local background = GonerBackground(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, "AUDIO_DONKEY")
        local background = GonerBackground(0, 0, "AUDIO_DONKEY") -- Yes this is drawn like this on purpose. idk i like it 
        background.layer = WORLD_LAYERS["top"]
        Game.world:addChild(background)

        gonerText("YOU MUST CHOOSE[wait:40]\nA VESSEL.[wait:20]")
        
        cutscene:wait(1)

        local frisk_sprite = Sprite("frisk")
        frisk_sprite.x = 320
        frisk_sprite.y = 240
        frisk_sprite.parallax_x = 0
        frisk_sprite.parallax_y = 0
        frisk_sprite:setOrigin(0.5, 0.5)
        frisk_sprite:setScale(2.5)
        frisk_sprite.layer = WORLD_LAYERS["top"] + 100
        frisk_sprite.alpha = 0
        Game.world:addChild(frisk_sprite)

        local you_sprite = Sprite("you")
        you_sprite.x = 320
        you_sprite.y = 240
        you_sprite.parallax_x = 0
        you_sprite.parallax_y = 0
        you_sprite:setOrigin(0.5, 0.5)
        you_sprite:setScale(2.5)
        you_sprite.layer = WORLD_LAYERS["top"] + 100
        you_sprite.alpha = 0
        you_sprite.graphics.fade = 0.01
        you_sprite.graphics.fade_to = 1
        Game.world:addChild(you_sprite)

        local chara_y = {240}

        cutscene:during(function()
            you_sprite.y = chara_y[1] + math.sin(Kristal.getTime() * 2) * 6
            --frisk_sprite.y = chara_y[1] + math.sin(Kristal.getTime() * 2) * 6
        end)
        

        gonerText("THIS SHOULD BE[wait:40]\nGOOD ENOUGH.[wait:20]", false)

        cutscene:wait(4)

        local chosen = nil
        local choicer = GonerChoice(220, 360, {
            {{"YES",0,0},{"<<"},{">>"},{"NO",160,0}}
        }, function(choice)
            chosen = choice
        end)
        choicer:setSelectedOption(2, 1)
        choicer:setSoulPosition(80, 0)
        Game.stage:addChild(choicer)

        cutscene:wait(function() return chosen ~= nil end)

        gonerTextFade()

        if chosen == "YES" then
            gonerText("EXCELLENT.[wait:20]")
            gonerText("TRULY[wait:40]\nEXCELLENT.[wait:20]")
            text.x = 136
            text.y = 40
            
            Game.world.timer:tween(1, chara_y, {360})

            cutscene:wait(0.75)




        else
            gonerText("REALLY?[wait:40]\nBITCH, YOU FR?[wait:20]")
            gonerText("WELL FUCK YOU I\nCHOSE IT ANYWAY[wait:20]")
            --[[
            gonerText("ALRIGHT, I GOT\nANOTHER ONE.[wait:20]")

            Game.stage.timer:tween(1, you_sprite, {alpha = 0})
            Game.stage.timer:tween(1, frisk_sprite, {alpha = 1})
            ]]

            --gonerText("AIGHT. YOU LIKE\nTHIS BODY?.[wait:20]", false)

            --gonerText("OK I DON'T\nCARE WE'RE GOING\nWITH IT..[wait:20]", false)
            
            --[[
            cutscene:wait(50)

            Assets.playSound("locker")
            background:remove()
            you_sprite.alpha = 0
            Game:setFlag("vesselChosen", 1)
            ]]


        end

        Game.world.timer:tween(1, chara_y, { 340 })

        local chara_name
            local namer = GonerKeyboard(-1, "default", function(name)
                chara_name = name
            end, function(key, x, y, namer)
                if namer.text == "GASTE" and key == "R" then
                    Assets.playSound("vineboom", 5)
                    gonerText("[speed:99][color:red]BITCH!!.")
                    cutscene:wait(0.02)
                    Game.stage.timescale = 0
                    Game.stage.active = false
                    Kristal.Stage.timer:after(0.1, function()
                        Kristal.returnToMenu()
                    end)
                end
            end)
            Game.stage:addChild(namer)

            cutscene:wait(function() return chara_name ~= nil end)

            gonerTextFade()

            Game.world.timer:tween(1, chara_y, { 240 })

            if chara_name ~= "YOU" then
                gonerText("WRONG.[wait:40]\nYOU ARE SO[wait:40] STUPID.[wait:20]")
                gonerText(chara_name .. "?[wait:20]")
                gonerText("UNFORTUNATELY, YOU\nHAVE NOT PASSED\nTHE IQ TEST.[wait:20]")
                gonerText("BUT, I GUESS\nWE CAN... MAKE\nSOME EXCEPTIONS.[wait:20]")
            else
                gonerText("CORRECT-A-MUNDO![wait:20]\nITS NAME IS YOU.[wait:20]")
                gonerText("ALRIGHT KIDDO,\nSENDING YA OFF\nNOW![wait:20] BYE-BYE![wait:20]")
                
            end

            cutscene:wait(1)

            cutscene:after(function()
                if Game:hasPartyMember("YOU") then
                    Game.world:startCutscene("room1", "react_to_YOU")
                end
            end)

            background.music:stop()
            Assets.playSound("locker")
            background:remove()
            you_sprite.alpha = 0
            Game:setFlag("vesselChosen", 1)

            cutscene:wait(1)

            Game.world:loadMap("room1", "spawn", "down")

            cutscene:fadeIn(0.5)

    end,

}