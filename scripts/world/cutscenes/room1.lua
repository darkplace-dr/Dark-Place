return {
    react_to_YOU = function(cutscene)
        local YOU = cutscene:getCharacter("YOU")
        local susie = cutscene:getCharacter("susie")
        if not susie then return end

        Game.world.music:stop()
        cutscene:wait(1)

        cutscene:detachFollowers()

        cutscene:setSpeaker(susie)
        cutscene:showNametag("Susie")
        cutscene:text("* So uh...", "sus_nervous")
        cutscene:hideNametag()
        cutscene:look(YOU, "left")
        cutscene:wait(cutscene:walkTo(susie, YOU.x - 60, YOU.y))
        cutscene:look(susie, "right")
        cutscene:showNametag("Susie")
        cutscene:text("* Who are you supposed to be?", "nervous_side")
        cutscene:text("* ...YOU?", "surprise")
        cutscene:text("* Dude, are you pulling my leg or what?", "surprise_smile")
        cutscene:text("* No way someone can have such a LAME name![wait:5] Hahaha!!", "sincere_smile")
        cutscene:text("* ...", "sincere_smile")
        cutscene:text("* Wait, you're serious?", "shock_down")
        cutscene:text("* Oops.", "shock_nervous")
        cutscene:text("* Well uh.. I'm Susie!", "shy_b")
        cutscene:text("* Nice to meet you,[wait:3] YOU the Frog...", "sincere_smile")
        cutscene:text("* ...Who looks at me[wait:3] with a dead inside expression[wait:3] piercing me...", "sus_nervous")
        cutscene:hideNametag()

        cutscene:look(YOU, "down")
        cutscene:wait(2)

        local zoom_sfx = cutscene:playSound("forestalt")
        local function zoom(scale, wait)
            Game.world.camera:setZoom(scale)
            cutscene:wait(wait)
        end
        local tx, ty = YOU:getRelativePos(YOU.width/2, YOU.height/2)
        cutscene:detachCamera()
        Game.world.camera:setPosition(tx, ty)
        zoom(2, 1/4)
        zoom(3, 1/4)
        zoom(4, 1/2)
        zoom(6, 1/2)
        local emotion = Sprite("world/cutscenes/react_to_YOU/bigemotion", -9, 4)
        emotion:setScale(0.125, 0.125)
        YOU:addChild(emotion)
        Game.world.camera.y = Game.world.camera.y - 18
        zoom(8, zoom_sfx)
        emotion:remove()
        cutscene:attachFollowersImmediate()
        cutscene:look(susie, "down")
        zoom(1, 0)
        cutscene:attachCameraImmediate()

        Game.world.music:play()
    end,

    wall = function(cutscene, event)
        -- Open textbox and wait for completion
        cutscene:text("* The wall seems cracked.")

        -- If we have Susie, play a cutscene
        local susie = cutscene:getCharacter("susie")
        if susie then
            -- Detach camera and followers (since characters will be moved)
            cutscene:detachCamera()
            cutscene:detachFollowers()

            -- All text from now is spoken by Susie
            cutscene:setSpeaker(susie)
            cutscene:showNametag("Susie")
            cutscene:text("* Hey,[wait:5] think I can break\nthis wall?", "smile")
            cutscene:hideNametag()

            -- Get the bottom-center of the broken wall
            local x = event.x + event.width / 2
            local y = event.y + event.height / 2

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
            susie:setAnimation({ "away_scratch", 0.25, true })
            susie:shake(4)
            Assets.playSound("wing")

            cutscene:wait(1)
            cutscene:showNametag("Susie")
            cutscene:text("* Guess not.", "nervous")
            cutscene:hideNametag()

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
    end,

    guardian = function(cutscene, event)
        cutscene:showNametag("Wall Guardian")
        cutscene:text("* I Am the Wall Guardian.[wait:5]\n* This Wall is Off Limits for you\nno-good wall slammers.")
        cutscene:hideNametag()

        Kristal.callEvent("completeAchievement", "wallguardian")
    end,

    star = function(cutscene, event)
        cutscene:showNametag("Starwalker?")
        cutscene:text("* This [color:yellow]sprite[color:reset] was [color:yellow]Pissing[color:reset] me\noff...")
        cutscene:text("* I was the original   [color:yellow]Starwalker[color:reset]")
        cutscene:hideNametag()

        Kristal.callEvent("completeAchievement", "starwalker")
    end,

    sans = function(cutscene, event)
        if cutscene:getCharacter("susie") then
            if event.interact_count == 1 then
                cutscene:showNametag("Susie")
                cutscene:text("* You??", "teeth_b", "susie")
                if cutscene:getCharacter("YOU") then
                    cutscene:text("* No,[wait:2] not you, YOU..[wait:5]\n[face:teeth_b]* THAT guy!!", "sus_nervous", "susie")
                end

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* hey.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* What are you DOING here??", "teeth", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* i'm keeping people away from this elevator.", "look_left", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* WHY??", "teeth", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* it's not finished yet.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* ...[wait:3]It looks pretty finished to me.", "neutral", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* that's just how tilesets are.", "joking", "sans")
                cutscene:text("[font:sans]* give them a while,[wait:1] figuring out how an elevator works take some time.", "wink", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* (What is he even talking about??)", "sus_nervous", "susie")
                cutscene:hideNametag()
            else
                cutscene:showNametag("Susie")
                cutscene:text("* How are you here by the way?", "neutral", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* i don't know. i'm just here for the work.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* Do you even know something?", "annoyed", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* hey, if you have a complaint[wait:1] you can tell my manager.", "joking", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* And who would that be?", "neutral_side", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* me.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* Aren't you already the cashier at Hometown??", "angry", "susie")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* nah, i'm the janitor.", "wink", "sans")
                cutscene:hideNametag()
            end
        elseif cutscene:getCharacter("noelle") then
            if event.interact_count == 1 then
                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* hey.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Uhm...[wait:4] Hello?", "smile_closed", "noelle")
                cutscene:text("* Wait, aren't you the guy keeping the store in Hometown?", "smile", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* nah, i'm just the cashier.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Oh? But isn't the store named after you?", "question", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* nah, that's the name of the owner.", "look_left", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Oh! Sorry for the confusion![wait:3] Can I ask for your name then?", "smile_closed", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* wow there girl, you don't just ask a hard worker like me his name. it's weird.", "joking", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* O-Oh... Sorry.", "surprise_frown_b", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* it's okay.[wait:3] i don't get pay enough to get mad at people.", "wink", "sans")
                cutscene:hideNametag()
            else
                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* what's up?", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Nothing special, mister... Uh..", "smile_closed", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* sans.[wait:2] sans the skeleton.", "wink", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Oh okay, mister...[wait:4] [face:confused_surprise]Sans..?[wait:4][face:confused_surprise_b] Skeleton??[wait:4][face:question] The Skeleton???", "smile", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* how about you just call me sans?[wait:3] sounds nicer, right?", "look_left",
                "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* I guess so, yeah..", "smile_side", "noelle")
                cutscene:text("* Wait... So your name IS Sans!", "surprise_smile_b", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* that's me.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* I thought I shouldn't ask an hard worker his name!", "smile_closed", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* wow, the guy who told you that must be really weird.", "joking", "sans")
                cutscene:text("[font:sans]* there's nothing wrong with knowing someone's name, you know?", "wink", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* ...", "what", "noelle")
                cutscene:text("* Then uh.. Aren't you the owner of the shop in Hometown?", "question", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* nah, i'm their janitor.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* But didn't you tell us you were their cashier?", "frown", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* i'm just filling in.[wait:3] employees are hard to find nowadays.", "look_left", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Did you try to start some employment campaign?", "smile_closed_b", "noelle")

                cutscene:showNametag("Sans")
                cutscene:text("[font:sans]* can't do that on a janitor's salary unfortunately.", "eyes_closed", "sans")
                cutscene:hideNametag()
            end
        else
            local kid = #Game.party > 1 and "kids" or "kid"
            cutscene:showNametag("Sans")
            cutscene:text(string.format("* hey %s.[wait:5] sorry but you can't access this elevator yet.", kid), "neutral", "sans")
            cutscene:text("* it's kinda..[wait:5] not finished.", "look_left", "sans")
            cutscene:text("* so come back later,[wait:2] 'k?", "wink", "sans")
            cutscene:hideNametag()
        end
    end,

    wah = function(cutscene, event)
        if event.interact_count == 1 then
            -- The 1st WAH!
            cutscene:showNametag("Takodachi")
            cutscene:text("* Pray to the 1st WAH![wait:10]\n* We Are Here!")
            cutscene:hideNametag()
        elseif event.interact_count == 2 then
            -- The 2nd WAH!
            cutscene:showNametag("Takodachi")
            cutscene:text("* Pray to the 2nd WAH![wait:10]\n* We Are Happy!")
            cutscene:hideNametag()
        elseif event.interact_count == 3 then
            -- The 3rd WAH!
            cutscene:showNametag("Takodachi")
            cutscene:text("* Pray to the 3rd WAH![wait:10]\n* We Are Hungry!")
            cutscene:hideNametag()
        elseif event.interact_count == 4 then
            -- The 4th... wah..?
            local wah4_sprite_list = {
                YOU = "date",
                susie = "shock",
                ralsei = "surprised_down",
                noelle = "shocked"
            }

            cutscene:showNametag("Takodachi")
            cutscene:text(
            "[noskip]* Pray to the 4th WAH![wait:10]\n[func:oshit]* We Are[wait:25][func:thicc][instant] H O R N Y![stopinstant][wait:15]",
            nil, nil, {
                functions = {
                    oshit = function()
                        Assets.stopAndPlaySound("the4thWah")
                    end,
                    thicc = function()
                        cutscene:showNametag("Takolyshit")
                        Game.fader:fadeIn(nil, { speed = 0.8, color = { 1, 1, 1 }, alpha = 1 })
                        event:setSprite("takolyshit")
                        -- Credits to Dobby233Liu for making this not awful code
                        for member, sprite in pairs(wah4_sprite_list) do
                            local char = cutscene:getCharacter(member)
                            if char ~= nil then
                                char:setSprite(sprite)
                            end
                        end
                    end
                }
            })
            cutscene:hideNametag()

            event:setSprite("idle")
            for member, _ in pairs(wah4_sprite_list) do
                local char = cutscene:getCharacter(member)
                if char ~= nil then
                    char:resetSprite()
                end
            end
        else
            cutscene:showNametag("Takodachi")
            cutscene:text("* Pray to the priestess,[wait:2] Ina!")
            cutscene:hideNametag()
        end
    end,

    plaedmc2 = function(cutscene, event)
        local dog = cutscene:getCharacter("dog")

        cutscene:showNametag("Dog")
        cutscene:text("* I'm just a dog, but I'm also...")
        cutscene:hideNametag()

        Game.world.music:pause()
        local nokia = Music("nokia")
        nokia:play()
        cutscene:wait(2.5)

        cutscene:showNametag("Dog")
        dog:setAnimation("holdphone")
        cutscene:text("* Who the...")
		cutscene:text("* Excuse me for a sec.")
		nokia:remove()
		dog:setAnimation("talkphone")
		cutscene:text("* .[wait:5].[wait:5].[wait:10]Hello?")
        cutscene:hideNametag()

        local dmc2 = Music("plaeDMC2")
        dmc2:play()
        cutscene:wait(2.5)

        cutscene:showNametag("Dog")
        cutscene:text("* ...[wait:10]You again.")
        cutscene:text("* I already told you...[wait:5]\nTHIS ISN'T FUNNY!")
        dog:setAnimation("holdphone")
        cutscene:text("* Hey...[wait:5] Hey![wait:5] HEEEY![wait:5] \nARE YOU LISTENING TO ME?")
        cutscene:text("* I've had enough of this!")
        cutscene:text("* I have your number you know,[wait:5]\nI know where you live.[wait:8]\n* YOU...[wait:10][shake:2]SCUM!!!")
        cutscene:hideNametag()

		dmc2:remove()
		Game.world.music:resume()
		dog:resetSprite()
    end,

    transition = function()
        if love.math.random(1, 100) <= 5 then
            Game.world:mapTransition("spamgolor_alley", "entrance")
        else
            Game.world:mapTransition("room2", "entry")
        end
    end
}
