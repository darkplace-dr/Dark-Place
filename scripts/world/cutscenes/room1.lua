return {
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
    end,
    star = function(cutscene, event)
        cutscene:showNametag("Starwalker?")
        cutscene:text("* This [color:yellow]sprite[color:reset] was [color:yellow]Pissing[color:reset] me\noff...")
        cutscene:text("* I was the original   [color:yellow]Starwalker[color:reset]")
        cutscene:hideNametag()
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
            cutscene:showNametag("Sans")
            cutscene:text(string.format("[font:sans]* hey %s.[wait:5] sorry but you can't access this elevator yet.", #Game.party > 1 and "kids" or "kid"))
            cutscene:text("[font:sans]* it's kinda..[wait:5] not finished.")
            cutscene:text("[font:sans]* so come back later,[wait:2] 'k?")
            cutscene:hideNametag()
        end
    end,
    wah = function(cutscene, event)
        local wah4_sprite_list = {
            YOU = "date",
            susie = "shock",
            ralsei = "surprised_down",
            noelle = "shocked"
        }

        cutscene:showNametag("Takodachi")
        -- The 1st WAH!
        if event.interact_count == 1 then
            cutscene:text("* Pray to the 1st WAH![wait:10]\n* We Are Here!")
            -- The 2nd WAH!
        elseif event.interact_count == 2 then
            cutscene:text("* Pray to the 2nd WAH![wait:10]\n* We Are Happy!")
            -- The 3rd WAH!
        elseif event.interact_count == 3 then
            cutscene:text("* Pray to the 3rd WAH![wait:10]\n* We Are Hungry!")
            -- The 4th... wah..?
        elseif event.interact_count == 4 then
            cutscene:text(
            "[noskip]* Pray to the 4th WAH![wait:10]\n[func:oshit]* We Are[wait:25][func:thicc][instant] H O R N Y![stopinstant][wait:15]",
            nil, nil, {
                functions = {
                    oshit = function()
                        Assets.stopAndPlaySound("the4thWah")
                    end,
                    thicc = function()
                        cutscene:showNametag("Takolyshit")
                        Game.world.fader:fadeIn(nil, { speed = 0.8, color = { 1, 1, 1 }, alpha = 1 })
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
            event:setSprite("idle")
            for member, _ in pairs(wah4_sprite_list) do
                local char = cutscene:getCharacter(member)
                if char ~= nil then
                    char:resetSprite()
                end
            end
        else
            cutscene:text("* Pray to the priestess,[wait:2] Ina!")
        end

        cutscene:hideNametag()
    end,
    transition = function()
        if love.math.random(1, 100) <= 5 then
            Game.world:mapTransition("spamgolor_alley", "entrance")
        else
            Game.world:mapTransition("room2", "entry")
        end
    end
}
