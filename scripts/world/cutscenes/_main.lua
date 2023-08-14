return {
    ---@param cutscene WorldCutscene
    introcutscene = function(cutscene)
        local text

        local function gonerTextFade(wait)
            local this_text = text
            Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function()
                this_text:remove()
            end)
            if wait ~= false then
                cutscene:wait(1)
            end
        end

        -- FIXME: actually use skippable
        local function gonerText(str, advance, skippable)
            text = DialogueText("[speed:0.5][spacing:6][style:GONER][voice:none]" .. str, 160, 100, 640, 480,
                { auto_size = true })
            text.layer = WORLD_LAYERS["textbox"]
            text.skip_speed = not skippable
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)

            if advance ~= false then
                cutscene:wait(function() return not text:isTyping() end)
                gonerTextFade(true)
            end
        end

        local can_exit = true
        cutscene:during(function()
            if not can_exit then return false end
            if Input.down("menu") and Input.down("d") then
                Assets.playSound("item", 0.1, 1.2)
                Input.clear("d")
                Game:setFlag("skipped_intro", true)
                -- NOTE: when this cutscene gets complex we may need to do
                -- some fallback configurations here
                cutscene:after(function()
                    Game.world:loadMap("room1", nil, "down")
                end)
                cutscene:endCutscene()
            end
        end)

        ---@type Music -- satisfy LLS
        local world_music = Game.world.music
        world_music:play("AUDIO_DRONE", 0.8)

        local cover = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        cover:setColor(COLORS["black"])
        cover:setParallax(0, 0)
        cover:setLayer(WORLD_LAYERS["below_ui"])
        Game.world:addChild(cover)

        local skip_hint = Text("Hold C+D to skip",
            0, SCREEN_HEIGHT/2+50, SCREEN_WIDTH, SCREEN_HEIGHT,
            {
                align = "center",
                font = "plain"
            }
        )
        skip_hint.alpha = 0.05
        skip_hint:setParallax(0, 0)
        skip_hint:setLayer(WORLD_LAYERS["ui"])
        Game.world:addChild(skip_hint)
        cutscene:wait(2)
        skip_hint:remove()
        can_exit = false

        gonerText("ARE YOU[wait:40]\nTHERE?[wait:20]")
        cutscene:wait(0.5)
        gonerText("ARE WE[wait:40]\nCONNECTED?[wait:20]")

        cutscene:wait(0.5)

        local soul = SoulAppearance(SCREEN_WIDTH / 2 - 25, SCREEN_HEIGHT / 2 + 20)
        soul:setParallax(0, 0)
        soul.layer = WORLD_LAYERS["below_textbox"]
        --soul.alpha = 50
        --soul.graphics.fade = 0.01
        --soul.graphics.fade_to = 1
        Game.world:addChild(soul)
        cutscene:during(function()
            soul.y = SCREEN_HEIGHT / 2 + 20 + math.sin(Kristal.getTime() * 2) * 6
        end)
        cutscene:wait(1.75)

        gonerText("EXCELLENT.[wait:20]")
        cutscene:wait(0.5)
        gonerText("TRULY[wait:20]\nEXCELLENT.[wait:20]")
        cutscene:wait(0.5)
        gonerText("NOW.[wait:20]")
        cutscene:wait(0.5)
        gonerText("WE MAY-")

        world_music:stop()
        Assets.playSound("phone")
        cutscene:wait(1)

        gonerText("...HM?[wait:20]")
        cutscene:wait(0.5)
        gonerText("APOLOGIES.[wait:20]")
        cutscene:wait(0.5)
        gonerText("I NEED TO TAKE[wait:20]\nTHIS CALL.[wait:20]")
        cutscene:wait(0.5)
		Assets.playSound("item")
        cutscene:wait(1.25)
        gonerText("HELLO?[wait:20]")

        local wahwah = Music("voiceover/wahwah", 0.8)
        wahwah:play()
        cutscene:wait(1.25)
		
        gonerText("YES...[wait:20]")
        cutscene:wait(0.5)
        gonerText("MM-HM...[wait:20]")
        cutscene:wait(0.5)
        gonerText("EXCELLENT.[wait:20]")
        cutscene:wait(0.5)
        gonerText("I SHALL BE THERE[wait:20]\nSHORTLY.[wait:20]")
        cutscene:wait(0.5)
		wahwah:stop()
		Assets.playSound("item")
        cutscene:wait(1)

        gonerText("SINCEREST[wait:20]\nAPOLOGIES...[wait:20]")
        cutscene:wait(0.5)
        gonerText("IT APPEARS THAT I[wait:20]\nAM NEEDED ELSEWHERE.[wait:20]")
        cutscene:wait(0.5)
        gonerText("IN THE MEANTIME,[wait:20]\nHOWEVER...[wait:20]")
        cutscene:wait(0.5)
        gonerText("HERE'S THE REST[wait:20]\nOF THE OLD-ASS\nCUTSCENE...[wait:20]")
        cutscene:wait(1.25)
		
        world_music:stop()
        soul:hide()
		
        cutscene:wait(1.75)

        local background = GonerBackground(nil, nil, "AUDIO_DONKEY_b", true, world_music)
        background.layer = WORLD_LAYERS["ui"]
        Game.world:addChild(background)

        gonerText("YOU MUST CHOOSE[wait:40]\nA VESSEL.[wait:20]")

        cutscene:wait(1)

        local frisk_sprite = Sprite("frisk", 320, 240, nil, nil, "world/cutscenes/intro")
        frisk_sprite.parallax_x = 0
        frisk_sprite.parallax_y = 0
        frisk_sprite:setOrigin(0.5, 0.5)
        frisk_sprite:setScale(2.5)
        frisk_sprite.layer = WORLD_LAYERS["below_textbox"]
        frisk_sprite.alpha = 0
        Game.world:addChild(frisk_sprite)

        local you_sprite = Sprite("you", 320, 240, nil, nil, "world/cutscenes/intro")
        you_sprite.parallax_x = 0
        you_sprite.parallax_y = 0
        you_sprite:setOrigin(0.5, 0.5)
        you_sprite:setScale(2.5)
        you_sprite.layer = WORLD_LAYERS["below_textbox"]
        you_sprite.alpha = 0
        you_sprite.graphics.fade = 0.01
        you_sprite.graphics.fade_to = 1
        Game.world:addChild(you_sprite)

        local chara_y = { 240 }

        cutscene:during(function()
            if you_sprite then
                you_sprite.y = chara_y[1] + math.sin(Kristal.getTime() * 2) * 6
            end
            --frisk_sprite.y = chara_y[1] + math.sin(Kristal.getTime() * 2) * 6
        end)


        gonerText("THIS SHOULD BE[wait:40]\nGOOD ENOUGH.[wait:20]", false)

        cutscene:wait(4)

        local chosen = nil
        local choicer = GonerChoice(220, 360, {
            { { "YES", 0, 0 }, { "<<" }, { ">>" }, { "NO", 160, 0 } }
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

            Game.world.timer:tween(1, chara_y, { 360 })

            cutscene:wait(0.75)
        else
            gonerText("REALLY?[wait:40]\nBITCH, YOU FR?[wait:20]")
            gonerText("WELL FUCK YOU I\nCHOSE IT ANYWAY[wait:20]")
            --[[
            gonerText("ALRIGHT, I GOT\nANOTHER ONE.[wait:20]")

            Game.stage.timer:tween(1, you_sprite, {alpha = 0})
            Game.stage.timer:tween(1, frisk_sprite, {alpha = 1})

            gonerText("AIGHT. YOU LIKE\nTHIS BODY?.[wait:20]", false)

            gonerText("OK I DON'T\nCARE WE'RE GOING\nWITH IT..[wait:20]", false)

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

        Game:setFlag("vesselChosen", 1)
        cutscene:wait(1)

        background:remove()
        you_sprite:remove()

        Assets.playSound("locker")
        cutscene:wait(1.5)

        cutscene:after(function()
            Game.world:mapTransition("room1", nil, "down")
        end)
    end,
}
