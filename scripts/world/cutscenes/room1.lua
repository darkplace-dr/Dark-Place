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
        local function zoom(scale, wait, overwrite_pos)
            local tx, ty = YOU:getRelativePos(YOU.width/2, YOU.height/2)
            Game.world.camera:setZoom(scale)
            if overwrite_pos then
                Game.world.camera:setPosition(overwrite_pos[1], overwrite_pos[2])
            else
                Game.world.camera:setPosition(tx, ty)
            end
            cutscene:wait(wait)
        end
        
        cutscene:detachCamera()
        zoom(2, 1/4)
        zoom(3, 1/4)
        zoom(4, 1/2)
        zoom(6, 1/2)
        local emotion = Sprite("world/cutscenes/react_to_YOU/bigemotion", -5, 6.5)
        emotion:setScale(0.125, 0.125)
        YOU:addChild(emotion)
        zoom(8, zoom_sfx, {Game.world.camera.x, Game.world.camera.y - 18})
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

    blankie_wall = function(cutscene, event)
        local hour = os.date("*t").hour
        if hour >= 21 or hour <= 8 then
            local blankie_wall = cutscene:getCharacter("blankie_wall")
            blankie_wall:setAnimation("blankie_wall_night")
            cutscene:text("* The wall is cracked but you can't break it right now!")
            cutscene:text("* But it just turned from a paper to a crack")
            cutscene:text("* That shouldn't happen as this is a wip!")
            cutscene:text("* This text should only appear from 9pm to 9am...")
            cutscene:text("* It should turn back paper after this dialogue\n * - Sans")
            blankie_wall:resetSprite()
        else
            cutscene:text("* The wall has a note taped with doodles.")
            cutscene:text("* But there is no proper cutscene yet as it's still a wip!")
            cutscene:text("* This text should only appear from 9am to 9pm...\n * - Sans")
        end
    end,

    guardian = function(cutscene, event)
        cutscene:showNametag("Wall Guardian")
        cutscene:text("* I Am the Wall Guardian.[wait:5]\n* This Wall is Off Limits for you\nno-good wall slammers.")
        cutscene:hideNametag()
        if not Kristal.libCall("achievements", "hasAch", "wallguardian") then
            Kristal.callEvent("completeAchievement", "wallguardian")
        end
    end,

    star = function(cutscene, event)
        cutscene:showNametag("Starwalker?")
        cutscene:text("* This [color:yellow]sprite[color:reset] was [color:yellow]Pissing[color:reset] me\noff...")
        cutscene:text("* I was the original   [color:yellow]Starwalker[color:reset]")
        cutscene:hideNametag()
        if not Kristal.libCall("achievements", "hasAch", "starwalker") then
            Kristal.callEvent("completeAchievement", "starwalker")
        end
    end,

    sans = function(cutscene, event)
        local hour = os.date("*t").hour
        if hour >= 21 or hour <= 8 then
            cutscene:showNametag("Sans", {font = "sans"})
            cutscene:text("[font:sans]* hey.\n * there might be another crack on the wall here.", "neutral", "sans")
            cutscene:hideNametag()
        else
            if cutscene:getCharacter("susie") then
                if event.interact_count == 1 then
                    cutscene:showNametag("Susie")
                    cutscene:text("* You??", "teeth_b", "susie")
                    if cutscene:getCharacter("YOU") then
                        cutscene:text("* No,[wait:2] not you, YOU..[wait:5]\n[face:teeth_b]* THAT guy!!", "sus_nervous", "susie")
                    end

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* hey.", "neutral", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* What are you DOING here??", "teeth", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* i'm keeping people away from this elevator.", "look_left", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* WHY??", "teeth", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* it's not finished yet.", "neutral", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* ...[wait:3]It looks pretty finished to me.", "neutral", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* that's just how tilesets are.", "joking", "sans")
                    cutscene:text("[font:sans]* give them a while,[wait:1] figuring out how an elevator works take some time.", "wink", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* (What is he even talking about??)", "sus_nervous", "susie")
                    cutscene:hideNametag()
                else
                    cutscene:showNametag("Susie")
                    cutscene:text("* How are you here by the way?", "neutral", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* i don't know. i'm just here for the work.", "neutral", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* Do you even know something?", "annoyed", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* hey, if you have a complaint[wait:1] you can tell my manager.", "joking", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* And who would that be?", "neutral_side", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* me.", "neutral", "sans")

                    cutscene:showNametag("Susie")
                    cutscene:text("* Aren't you already the cashier at Hometown??", "angry", "susie")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* nah, i'm the janitor.", "wink", "sans")
                    cutscene:hideNametag()
                end
            elseif cutscene:getCharacter("noelle") then
                if event.interact_count == 1 then
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* hey.", "neutral", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* Uhm...[wait:4] Hello?", "smile_closed", "noelle")
                    cutscene:text("* Wait, aren't you the guy keeping the store in Hometown?", "smile", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* nah, i'm just the cashier.", "neutral", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* Oh? But isn't the store named after you?", "question", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* nah, that's the name of the owner.", "look_left", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* Oh! Sorry for the confusion![wait:3] Can I ask for your name then?", "smile_closed", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* wow there girl, you don't just ask a hard worker like me his name. it's weird.", "joking", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* O-Oh... Sorry.", "surprise_frown_b", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* it's okay.[wait:3] i don't get pay enough to get mad at people.", "wink", "sans")
                    cutscene:hideNametag()
                else
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* what's up?", "neutral", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* Nothing special, mister... Uh..", "smile_closed", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* sans.[wait:2] sans the skeleton.", "wink", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* Oh okay, mister...[wait:4] [face:confused_surprise]Sans..?[wait:4][face:confused_surprise_b] Skeleton??[wait:4][face:question] The Skeleton???", "smile", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* how about you just call me sans?[wait:3] sounds nicer, right?", "look_left",
                    "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* I guess so, yeah..", "smile_side", "noelle")
                    cutscene:text("* Wait... So your name IS Sans!", "surprise_smile_b", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* that's me.", "neutral", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* I thought I shouldn't ask an hard worker his name!", "smile_closed", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* wow, the guy who told you that must be really weird.", "joking", "sans")
                    cutscene:text("[font:sans]* there's nothing wrong with knowing someone's name, you know?", "wink", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* ...", "what", "noelle")
                    cutscene:text("* Then uh.. Aren't you the owner of the shop in Hometown?", "question", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* nah, i'm their janitor.", "neutral", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* But didn't you tell us you were their cashier?", "frown", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* i'm just filling in.[wait:3] employees are hard to find nowadays.", "look_left", "sans")

                    cutscene:showNametag("Noelle")
                    cutscene:text("* Did you try to start some employment campaign?", "smile_closed_b", "noelle")

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* can't do that on a janitor's salary unfortunately.", "eyes_closed", "sans")
                    cutscene:hideNametag()
                end
            else
                local kid = #Game.party > 1 and "kids" or "kid"
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text(string.format("* hey %s.[wait:5] sorry but you can't access this elevator yet.", kid), "neutral", "sans")
                cutscene:text("* it's kinda..[wait:5] not finished.", "look_left", "sans")
                cutscene:text("* so come back later,[wait:2] 'k?", "wink", "sans")
                cutscene:hideNametag()
            end
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

            if not Kristal.libCall("achievements", "hasAch", "takodownbad") then
                Kristal.callEvent("completeAchievement", "takodownbad")
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
    end,
	
	diagonal_mario = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
        cutscene:showNametag("Diagonal Mario of C.A.")
        cutscene:text("* Cease and desist,[wait:5] you fucking idiot")
		if cutscene:getCharacter("susie") then
			cutscene:showNametag("Susie")
            cutscene:text("* Yeah?[wait:5]\n* Or what?", "annoyed", "susie")
			cutscene:showNametag("Diagonal Mario of C.A.")
			cutscene:text("* DMCA")
			cutscene:showNametag("Susie")
            cutscene:text("* Well,[wait:5] shi--", "shock", "susie", { auto = true })
			Game:removePartyMember("susie")
			susie:remove()
		end
        cutscene:hideNametag()
    end,

    sans_under_attack = function(cutscene, event, chara)
        if chara.sprite.facing == "up" then
            local sans = Game.world:getCharacter("sans")
            if not sans then event:remove() cutscene:endCutscene() return end
            --TODO: The cutscene if Susie is not in the party
            if not cutscene:getCharacter("susie") then event:remove() cutscene:endCutscene() return end
            Game.world.music:fade(0, 1, function() Game.world.music:stop() end)
            sans.x = 300

            local mario = Game.world:getEvent(48)
            local save = Game.world:getEvent(27)
            local wall_guardian = Game.world:getEvent(35)
            mario.visible = false
            save.visible = false
            if wall_guardian then wall_guardian.visible = false end

            shadowman1 = Game.world:spawnNPC("shadowmen", sans.x - 153, sans.y)
            shadowman1.flip_x = true
            shadowman2 = Game.world:spawnNPC("shadowmen", sans.x + 100, sans.y)
            shadowman1.sprite:stop(false)
            shadowman2.sprite:stop(false)
            Game.world:addChild(shadowman1)
            Game.world:addChild(shadowman2)

            cutscene:showNametag("???")
            cutscene:text("* Listen closely, ya little skelepunk.")
            cutscene:hideNametag()

            cutscene:wait(cutscene:panTo(sans))

            cutscene:setTextboxTop(false)
            shadowman2.sprite:stop(false)
            shadowman1:play(1/4)
            cutscene:showNametag("Shadowman 1")
            cutscene:text("* We only gave ya one job: preventing folks from enterin' that elevator.")
            cutscene:text("* And ya didn't even do it properly??")
            cutscene:showNametag("Sans", {font = "sans"})
            shadowman1.sprite:stop(false)
            cutscene:text("[font:sans]* well it's working now, isn't it?", "look_left", "sans")
            shadowman2:play(1/4)
            cutscene:showNametag("Shadowman 2")
            cutscene:text("* Don't play dumb with us, skeleman.")
            cutscene:text("* The boss ain't happy with what he heard. So ya gonna come with us right now or else...")
            shadowman2.sprite:stop(false)

            cutscene:detachFollowers()
            local moved_player = cutscene:walkTo(chara, 250, 260, 2)
            move_party = {}
            local nb_followers = #Game.world.followers
            for i,follower in ipairs(Game.world.followers) do
                if i == 1 then
                    table.insert(move_party, cutscene:walkTo(follower, 350, 260, 2))
                elseif i == 2 then
                    if nb_followers == 3 then
                        table.insert(move_party, cutscene:walkTo(follower, 250, 330, 2))
                    else
                        table.insert(move_party, cutscene:walkTo(follower, 300, 330, 2))
                    end
                elseif i == 3 then
                    table.insert(move_party, cutscene:walkTo(follower, 350, 330, 2))
                end
            end

            cutscene:showNametag("Susie")
            cutscene:text("* HEY!", "angry", "susie")
            cutscene:hideNametag()

            cutscene:wait(function()
                local moved_followers = true

                for k,func in pairs(move_party) do
                    if not func() then
                        moved_followers = false
                        break
                    end
                end

                return moved_player() and moved_followers
            end)

            shadowman1:play(1/4)
            cutscene:showNametag("Shadowman 1")
            cutscene:text("* What do ya want, kids?")
            shadowman1.sprite:stop(false)
            shadowman2:play(1/4)
            cutscene:showNametag("Shadowman 2")
            cutscene:text("* It's adult talking here, so get lost.")
            shadowman2.sprite:stop(false)
            cutscene:showNametag("Susie")
            cutscene:text("* Threats over an elevator doesn't sounds very \"adult\" to me.", "annoyed", "susie")
            cutscene:text("* So how about YOU get lost instead?", "teeth_smile", "susie")
            shadowman2:play(1/4)
            cutscene:showNametag("Shadowman 2")
            cutscene:text("* So ya think y'all tough 'cause you can show your teeths, girl?")
            shadowman2.sprite:stop(false)
            shadowman1:play(1/4)
            cutscene:showNametag("Shadowman 1")
            cutscene:text("* Fine by us. You walked right into that one anyway!")
            shadowman1.sprite:stop(false)
            cutscene:hideNametag()


            cutscene:startEncounter("shadowmen", nil, {shadowman1, shadowman2})
            shadowman1.visible = true --No idea why it gets hidden


            if Game:getFlag("shadowmen_violence", false) then
                if Game:getFlag("shadowmen_special_end", nil) == "FROZEN" then
                    local susie = cutscene:getCharacter("susie")
                    susie:setSprite("shock")
                    susie:setFacing("down")
                    susie:shake()
                    cutscene:wait(1)

                    cutscene:showNametag("Susie")
                    cutscene:text("* Uhhhh...", "shock_nervous", "susie")
                    if cutscene:getCharacter("dess") then
                        cutscene:showNametag("Dess")
                        cutscene:text("* ", "wtf", "dess")
                        cutscene:text("* Holy shit", "wtf", "dess")
                    end
                    susie:setSprite("walk")
                    susie:setFacing("up")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* wow kids. that's some powerful magic you got there.", "look_left", "sans")
                    cutscene:text("[font:sans]* you should totally NOT use it on random folks, y'know?", "wink", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* I, uh... I guess so, yeah.", "sus_nervous", "susie")
                    cutscene:text("* ("..Game.world.player.actor.name:upper()..", WHAT THE HELL WAS THAT???)", "teeth", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* i think you guys should go before someone else see this.", "neutral", "sans")
                    cutscene:text("[font:sans]* wouldn't want to get in trouble, right?", "look_left", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* You're, uh.. Okay with what just happened?", "sus_nervous", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* let's just say that as long as you've learn your lesson and don't do it again..", "eyes_closed", "sans")
                    cutscene:text("[font:sans]* i'll keep my eyes closed.", "wink", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Okay... Cool... I guess.", "sus_nervous", "susie")
                    cutscene:text("* Let's go, then.", "nervous", "susie")
                    cutscene:hideNametag()
                elseif Game:getFlag("shadowmen_special_end", nil) == "KILLED" then
                    cutscene:wait(1)

                    cutscene:showNametag("Susie")
                    cutscene:text("* ...", "sad_frown", "susie")
                    if cutscene:getCharacter("dess") then
                        cutscene:showNametag("Dess")
                        cutscene:text("* ...", "wtf", "dess")
                    end
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* ...", "look_left", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* ("..Game.world.player.actor.name:upper()..", WHAT THE HELL???)", "teeth", "susie")
                    cutscene:text("* So, uh...", "sus_nervous", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* did your parents never told you that killing was bad?", "wink", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Well...", "shy_down", "susie")
                    if cutscene:getCharacter("dess") then
                        cutscene:showNametag("Dess")
                        cutscene:text("* We did it for the vine.[react:1]", "wink", "dess", {reactions={
                            {"(BE SERIOUS!!)", "right", "bottommid", "teeth", "susie"}
                        }})
                    end
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* don't sweat too much about it.", "look_left", "sans")
                    cutscene:text("[font:sans]* as long as you've learn not to do it again, it's fine.", "neutral", "sans")
                        cutscene:showNametag("Susie")
                    cutscene:text("* Are you... For real?", "nervous", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* as real as can be.", "joking", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...", "nervous_side", "susie")
                    cutscene:text("* Then I guess we'll just go then.", "smirk", "susie")
                    cutscene:text("* Go and do some good deeds... Yeah...", "nervous", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* alright, later kids.", "wink", "sans")
                    cutscene:hideNametag()
                else
                    shadowman1:play(1/4)
                    shadowman2.sprite:stop(false)
                    cutscene:showNametag("Shadowman 1")
                    cutscene:text("* W-[wait:2]Wow wow! Come on, kids! We don't have to get to such extremes, ya know..?")
                    shadowman2:play(1/4)
                    shadowman1.sprite:stop(false)
                    cutscene:showNametag("Shadowman 2")
                    cutscene:text("* Yeah, let's all have a nice discussion, adults to teens..!")
                    shadowman2.sprite:stop(false)
                    cutscene:showNametag("Susie")
                    cutscene:text("* Scram.[wait:10] Now.", "bangs_teeth", "susie")
                    shadowman1:play(1/4)
                    shadowman2:play(1/4)
                    cutscene:showNametag("Shadowmen")
                    cutscene:text("* Y-[wait:2]Yes m'am!")
                    cutscene:hideNametag()

                    cutscene:slideTo(shadowman2, 450, shadowman2.y)

                    cutscene:wait(cutscene:slideTo(shadowman1, 110, shadowman1.y))

                    cutscene:slideTo(shadowman2, shadowman2.x, 355)
                    cutscene:wait(cutscene:slideTo(shadowman1, shadowman1.x, 355))
                    cutscene:wait(cutscene:slideTo(shadowman2, 305, shadowman2.y))
                    cutscene:wait(cutscene:slideTo(shadowman2, shadowman2.x, 600))
                    cutscene:wait(cutscene:slideTo(shadowman1, 255, shadowman1.y))
                    cutscene:wait(cutscene:slideTo(shadowman1, shadowman1.x, 600))

                    cutscene:wait(1)

                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* well.. that was something.", "look_left", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Yeah uh.. Maybe we went a bit overboard.", "neutral", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* don't beat yourself over it too much.", "neutral", "sans")
                    cutscene:text("[font:sans]* it's not like they're dead or something.", "wink", "sans")
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...Sure...", "suspicious", "susie")
                    cutscene:text("* But anyway, I think we'll just go.", "nervous", "susie")
                    cutscene:text("* Cool to talk to you and save your ass, I guess??", "nervous_side", "susie")
                    cutscene:showNametag("Sans", {font = "sans"})
                    cutscene:text("[font:sans]* anytime, kid.", "wink", "sans")
                    cutscene:hideNametag()
                end
            else
                shadowman1:play(1/4)
                cutscene:showNametag("Shadowman 1")
                cutscene:text("* Hey kids! You're pretty cool actually!")
                local nb_to_text = {"", " two", " three", " four"}
                cutscene:text("* The boss would love to hear from folks like you"..nb_to_text[#Game.party].."!")
                shadowman2:play(1/4)
                shadowman1.sprite:stop(false)
                cutscene:showNametag("Shadowman 2")
                cutscene:text("* Whaddya say? You could go on the big screen in no time!")
                shadowman2.sprite:stop(false)
                cutscene:showNametag("Susie")
                cutscene:text("* Yeah uh, how about you just get lost like we said before the battle?", "annoyed", "susie")
                cutscene:text("* And also let that guy alone.", "neutral_side", "susie")
                if cutscene:getCharacter("dess") then
                    cutscene:showNametag("Dess")
                    cutscene:text("* But Susie imagine all the fame and money that could come with it", "genuine_b", "dess")
                    cutscene:showNametag("Susie")
                    cutscene:text("* That's... Not something that interest me.", "nervous", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("* Less for you more for me I geuss.", "condescending", "dess")
                    cutscene:text("* Where could I star in?", "genuine", "dess")
                    shadowman1:play(1/4)
                    cutscene:showNametag("Shadowman 1")
                    cutscene:text("* Hmm... That dumb look on ya face..")
                    cutscene:text("* What's 9+10?")
                    shadowman1.sprite:stop(false)
                    cutscene:showNametag("Dess")
                    cutscene:text("* 21 yuh", "wink", "dess")
                    cutscene:showNametag("Shadowman 1")
                    cutscene:text("* ...")
                    cutscene:showNametag("Shadowman 2")
                    cutscene:text("* ...")
                    shadowman2:play(1/4)
                    shadowman1:play(1/4)
                    cutscene:showNametag("Shadowmen")
                    cutscene:text("* Perfect for reality shows.")
                    shadowman1.sprite:stop(false)
                end
                shadowman2:play(1/4)
                cutscene:showNametag("Shadowman 2")
                cutscene:text("* Okay, here's what we gonna do.")
                local leader_surnames = {
                    YOU = "frog",
                    kris = "blue person",
                    susie = "purple dino",
                    robo_susie = "dead inside dino",
                    noyno = "pretencious prince",
                    noelle = "nice deer",
                    berdly = "twitter bird",
                    dess = "dumb deer",
                    brandon = "dude or gal",
                    dumbie = "dummy",
                    bor = "ball",
                    osw = "unoriginal"
                }
                cutscene:text("* We let your skelefriend untouched, but you, the "..(leader_surnames[Game.world.player.actor.id] or "leader")..", take our number!")
                cutscene:hideNametag()
                local leader = cutscene:getCharacter(Game.world.player.actor.id)
                local x, y = shadowman2:getPosition()
                cutscene:wait(cutscene:slideTo(shadowman2, leader.x + shadowman2.width/2, leader.y - 20))
                Assets.playSound("item")
                cutscene:text("* (You've got the shadowmen's number even though you can't make calls in the Dark World.)")
                cutscene:wait(cutscene:slideTo(shadowman2, x, y))
                cutscene:showNametag("Shadowman 1")
                shadowman1:play(1/4)
                shadowman2.sprite:stop(false)
                cutscene:text("* If you ever feel like becoming superstars, we'll always be one call ahead!")
                cutscene:text("* Later! The showbiz doesn't wait!")
                shadowman1.sprite:stop(false)
                cutscene:hideNametag()

                cutscene:slideTo(shadowman2, 450, shadowman2.y)

                cutscene:wait(cutscene:slideTo(shadowman1, 110, shadowman1.y))

                Game.world.timer:after(0.5, function()
                    for _, member in ipairs(Game.party) do
                        cutscene:look(cutscene:getCharacter(member.id), "down")
                    end
                end)

                cutscene:slideTo(shadowman2, shadowman2.x, 355)
                cutscene:wait(cutscene:slideTo(shadowman1, shadowman1.x, 355))
                cutscene:wait(cutscene:slideTo(shadowman2, 305, shadowman2.y))
                cutscene:wait(cutscene:slideTo(shadowman2, shadowman2.x, 600))
                cutscene:wait(cutscene:slideTo(shadowman1, 255, shadowman1.y))
                cutscene:wait(cutscene:slideTo(shadowman1, shadowman1.x, 600))

                cutscene:wait(1)

                for _, member in ipairs(Game.party) do
                    cutscene:look(cutscene:getCharacter(member.id), "up")
                end

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* well that was something.", "neutral", "sans")
                cutscene:text("[font:sans]* thanks kids. i own you one.", "wink", "sans")
                cutscene:showNametag("Susie")
                cutscene:text("* Yeah uh.. No problem, I guess.", "neutral", "susie")
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* and i know exactly what you kids want.", "neutral", "sans")
                cutscene:showNametag("Susie")
                cutscene:text("* ...?", "nervous_side", "susie")
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* you're free to use the elevator whenever you like. isn't that cool?", "joking", "sans")
                cutscene:showNametag("Susie")
                cutscene:text("* Didn't we already have access to it?", "sus_nervous", "susie")
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* yeah but now it's official access.", "wink", "sans")
                cutscene:showNametag("Susie")
                cutscene:text("* ...Sure...", "suspicious", "susie")
                cutscene:text("* But anyway, I think we'll just go.", "nervous", "susie")
                cutscene:text("* Cool to talk to you and save your ass, I guess??", "nervous_side", "susie")
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* anytime, kid.", "wink", "sans")
                cutscene:hideNametag()
            end

            cutscene:getCharacter(Game.world.player.actor.id):setFacing("down")
            cutscene:wait(cutscene:alignFollowers())
            cutscene:wait(cutscene:attachFollowers())
            cutscene:attachCameraImmediate()
            shadowman1:remove()
            shadowman2:remove()
            -- Don't ask me why, I don't know either
            shadowman1.sprite:remove()
            shadowman2.sprite:remove()

            cutscene:wait(0.5)

            cutscene:fadeOut(0)
            Assets.playSound("noise")
            cutscene:wait(0.5)
            cutscene:getCharacter("sans"):remove()
            mario.visible = true
            save.visible = true
            if wall_guardian then wall_guardian.visible = true end
            Assets.playSound("noise")
            cutscene:fadeIn(0)

            cutscene:wait(0.5)

            if Game:getFlag("shadowmen_special_end", nil) ~= nil then
                local sfx = Assets.playSound("ominous")
                cutscene:wait(function()
                    return not sfx:isPlaying()
                end)
            end

            Game.world.music:play(nil, 1)
            event:remove()
            event:setFlag("dont_load", true)
            Game:setFlag("fun", love.math.random(1, 100))
        end
    end
}
