local function updatePostSidebData()
    Game:setFlag("POST_SNOWGRAVE", true)
    Game:getPartyMember("kris").title = "Leader\nCommands."
    local noelle = Game:getPartyMember("noelle")
    noelle:addSpell("snowgrave")
    noelle.health = 170
    noelle.stats = {
        health = 170,
        attack = 8,
        defense = 1,
        magic = 16
    }
    noelle:setWeapon("thornring")
    noelle.flags = {
        ["iceshocks_used"] = 20,
        ["boldness"] = 100,
        ["weird"] = true
    }
end

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

        ---@type Music -- satisfy LLS
        local world_music = Game.world.music
        world_music:play("DRONE", 0.8)

        local cover = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        cover:setColor(COLORS["black"])
        cover:setParallax(0, 0)
        cover:setLayer(WORLD_LAYERS["below_ui"])
        Game.world:addChild(cover)

        local sideb_file_found = Mod:hasDRSidebSave()

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

        local can_exit = true
        cutscene:during(function()
            if not can_exit then return false end

            if Input.down("c") and Input.down("d") then
                Game:setFlag("skipped_intro", true)
                Assets.playSound("item", 0.1, 1.2)
                skip_hint:remove()
                Game.world.music:stop()
                Input.clear("c")
                Input.clear("d")

                -- NOTE: when this cutscene gets complex we may need to do
                -- some fallback configurations here
                cutscene:after(function()
                    if sideb_file_found then
                        Game.world.timer:after(2, function()
                            Game.world:startCutscene("_main.snowgraveskip")
                        end)
                    else
                        Game.world:loadMap("room1", nil, "down")
                    end
                end)
                cutscene:endCutscene()
            end
        end)

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

        if sideb_file_found then
            cutscene:wait(0.5)
            gonerText("BEFORE WE BEGIN.[wait:20]")
            cutscene:wait(0.5)
            gonerText("I'D LIKE TO[wait:20]\nNOTICE...[wait:20]")
            cutscene:wait(0.5)
            gonerText("THAT DURING ONE OF[wait:20]\nOUR EXPERIMENTS...[wait:20]")
            cutscene:wait(0.5)
            gonerText("YOU MADE SOME VERY,[wait:20]\nVERY INTERESTING...[wait:20]\nCHOICES.[wait:20]")
            cutscene:wait(0.5)
            gonerText("CHOICES THAT HAD[wait:20]\nCONSEQUENCES.[wait:20]")
            cutscene:wait(0.5)
            gonerText("SO WHAT IF[wait:20]\nI SAY...[wait:20]")
            cutscene:wait(0.5)
            gonerText("I HAVE A[wait:20]\nPROPOSITION[wait:20]\nFOR YOU?[wait:20]")
            cutscene:wait(0.5)
            gonerText("A PROPOSITION OF[wait:20]\nTRANSFERRING THESE...[wait:20]")
            cutscene:wait(0.5)
            gonerText("CHOICES AND[wait:20]\nCONSEQUENCES...[wait:20]\nHERE?[wait:20]")
            cutscene:wait(0.5)
            gonerText("WOULD YOU[wait:20]\nAGREE TO THAT?[wait:20]")
            cutscene:wait(0.5)

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
                cutscene:wait(0.5)
                gonerText("VERY WELL THEN.[wait:20]")
                cutscene:wait(0.5)
                gonerText("THERE'S NO[wait:20]\nGOING BACK NOW.[wait:20]")
                cutscene:wait(0.5)
                gonerText("...[wait:20]")
                updatePostSidebData()
                cutscene:wait(0.5)
                gonerText("IT IS DONE.[wait:20]")
                cutscene:wait(0.5)
                gonerText("NOW.[wait:20]")
            else
                cutscene:wait(0.5)
                gonerText("OF COURSE.[wait:20]\nOF COURSE.[wait:20]")
                cutscene:wait(0.5)
                gonerText("IN THAT CASE...[wait:20]")
            end
        end

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
		wahwah:remove()
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

        local you_sprite = Sprite("doobie", 320, 240, nil, nil, "world/cutscenes/intro")
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

        if chara_name ~= "DOOBIE" then
            gonerText("WRONG.[wait:40]\nYOU ARE SO[wait:40] STUPID.[wait:20]")
            gonerText(chara_name .. "?[wait:20]")
            gonerText("UNFORTUNATELY, YOU\nHAVE NOT PASSED\nTHE IQ TEST.[wait:20]")
            gonerText("BUT, I GUESS\nWE CAN... MAKE\nSOME EXCEPTIONS.[wait:20]")
        else
            --gonerText("CORRECT-A-MUNDO![wait:20]\nITS NAME IS YOU.[wait:20]")
            gonerText("CORRECT-A-MUNDO![wait:20]\nITS NAME IS DOOBIE.[wait:20]")
            gonerText("ALRIGHT KIDDO,\nSENDING YA OFF\nNOW![wait:20] BYE-BYE![wait:20]")
        end

        Game:setFlag("vesselChosen", 1)
        cutscene:wait(1)

        if Game:getFlag("noel_party") then -- Noel has already been set up at this point
            you_sprite:setSprite("noel")
            Assets.playSound("mysterygo", 1, 1)
            you_sprite:shake(6)
            cutscene:wait(0.1)
            Assets.stopSound("mysterygo")
        end

        background:remove()
        you_sprite:remove()

        Assets.playSound("locker")
        cutscene:wait(1.5)

        cutscene:after(function()
            Game.world:mapTransition("room1", nil, "down")
        end)
    end,

    snowgraveskip = function(cutscene)
        local text = DialogueText({
            "A save file with the snowgrave route achieved has been found.",
            "The consequences of your route can be carried over here.",
            "Would you want that?"
        }, 0, 100, SCREEN_WIDTH, SCREEN_HEIGHT,
        {
            align = "center"
        })
        text:setParallax(0, 0)
        text:setLayer(WORLD_LAYERS["ui"])
        Game.world:addChild(text)
        cutscene:wait(function()
            return text:isDone()
        end)

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

        if chosen == "YES" then
            text.alpha = 0
            cutscene:wait(2)

            updatePostSidebData()

            text.alpha = 1
            text:setText("It is done.")
        else
            text:setText("Your snowgrave route won't be acknoledged here.")
        end

        cutscene:wait(function()
            return not text:isTyping()
        end)

        cutscene:wait(2)
        cutscene:wait(cutscene:fadeOut(5, {global=true, color={1, 1, 1}}))
        cutscene:wait(1)
        cutscene:after(function()
            Game.world:loadMap("room1", nil, "down")
            Game.fader.alpha = 0
        end)
    end,

    unlock_ralsei = function(cutscene)
        Game.world.music:stop()

        local cover = Rectangle(-5, -5, 650, 490)
        cover:setColor(COLORS["black"])
        cover:setParallax(0, 0)
        cover.layer = WORLD_LAYERS["top"]
        Game.world:addChild(cover)
		
        local ral = Sprite("world/cutscenes/ralsei_unlock_popup", 90, 210)
        ral:setScale(2)
        ral:setParallax(0, 0)
        ral.alpha = 0
        ral.layer = WORLD_LAYERS["top"] + 1
        Game.world:addChild(ral)

        cutscene:wait(5)
		
        Assets.playSound("ralsei_unlock")
        Game.world.timer:tween(0.5, ral, {alpha = 1}, "linear")
    end,

	bean_spot = function(cutscene, event)
		if not Game:getFlag("hasObtainedLancer") then
			cutscene:text("* It seems you can't dig without a spade.")
            return
		end

        cutscene:detachFollowers()
        cutscene:detachCamera()

        Assets.playSound("ultraswing")
        local player = Game.world.player
        cutscene:setAnimation(player, "battle/act")
        cutscene:wait(cutscene:slideTo(player, player.x - 80, player.y, 0.5, "out-cubic"))
        
        Assets.playSound("lancerwhistle")
        local lancer = NPC("lancer", player.x, player.y, {facing = "down"})
        lancer.layer = player.layer - 0.01
        Game.world:addChild(lancer)
        event.layer = lancer.layer - 0.01
        
        cutscene:wait(cutscene:slideTo(lancer, event.x, event.y, 0.5, "out-cubic"))
        
        Assets.playSound("lancercough")
        cutscene:setAnimation(lancer, "wave")
        
        cutscene:wait(0.5)
        
        cutscene:text("* Lancer dug up a " .. event.name .. ".")
        Game:addFlag(event.flag_inc, 1)
        event:setFlag("dont_load", true)
        
        event:remove()
        
        cutscene:resetSprite(player)
        cutscene:resetSprite(lancer)
        cutscene:look(lancer, "left")
        cutscene:wait(cutscene:walkTo(player, lancer.x, lancer.y, 1))
        lancer:remove()
        
        cutscene:attachFollowers()
        cutscene:attachCamera(0.5)
        cutscene:wait(1)
	end,

    logo_debug = function(cutscene)
        Game.world.music:stop()
        local logo = Game.world:spawnObject(DarkPlaceLogo(), "ui")
        cutscene:wait(function() return logo:isRemoved() end)
    end
}
