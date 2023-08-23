return {

    greatdoor_view = function(cutscene)
        local susie = cutscene:getCharacter("susie")
        local alseri = cutscene:getCharacter("alseri")
        local ralsei = cutscene:getCharacter("ralsei")

        if not Game:getFlag("mrbeast_greatdoorviewseen", false) then

            if alseri then

                cutscene:text("[speed:999]* Oh my!\n* The Great Door is\nopened?!", "surprise", "alseri")
                cutscene:text("* No wonder Jimmy was\nable to come through...", "surprise", "alseri")
                cutscene:text("* ...", "look_down", "alseri")
                cutscene:text("* ".. Game.party[1].name ..",[wait:5] once we pass through this door...", "look_down", "alseri")
                cutscene:text("* Our adventure will\nreally begin.", "look_down", "alseri")
                cutscene:text("* Our journey to save Kris...", "look_down", "alseri")
                cutscene:text("* But,[wait:5] ".. Game.party[1].name ..",[wait:5] I believe YOUR choices are important,[wait:5] too.", "pleased", "alseri")
                cutscene:text("* This world is full of\nall kinds of people,[wait:5]\n".. Game.party[1].name ..".", "smile", "alseri")
                cutscene:text("* In the end,[wait:5] how we treat\nthem makes all the difference.", "pleased", "alseri")
                cutscene:text("* So let's try our best to\nget by without FIGHTing.", "smile_b", "alseri")
                cutscene:text("* If we can manage to do\nthat...", "look_down", "alseri")
                cutscene:text("* I believe this tale may\nhave a happy ending.", "smile", "alseri")
                cutscene:text("* Otherwise,[wait:5] I fear\nthat...", "pleased", "alseri")
                cutscene:text("* ... you may not...[wait:5] find\nthe result favorable.", "look_down", "alseri")
                cutscene:text("* ... Oh,[wait:5] I'm sorry![wait:10] Is\nthat too much to ask?", "surprise", "alseri")
                local choice = cutscene:choicer({"I can\nhandle it", "....."})
                if choice == 1 then
                    cutscene:text("* ".. Game.party[1].name ..",[wait:5] I knew you were a hero the moment I saw you.", "smile", "alseri")
                    cutscene:text("* Let's try our best,[wait:5]\nalright?", "pleased", "alseri")
                else
                    cutscene:text("* ... Oh,[wait:5] I'm sorry!", "surprise", "alseri")
                    cutscene:text("* ".. Game.party[1].name ..",[wait:5] in the end,[wait:5] what you choose is up to you.", "pleased", "alseri")
                    cutscene:text("* As long as you're happy\nwith it,[wait:5] I'm happy too.", "smile_b", "alseri")
                    cutscene:text("* So just try your best,[wait:5]\nand don't worry!", "smile", "alseri")
                end
    
            elseif susie then
    
                cutscene:text("[speed:999]* What the?!\n* The Great Door is\nopened?!", "surprise_frown", "susie")
                cutscene:text("* No wonder Jimmy was\nable to come through...", "sus_nervous", "susie")
                cutscene:text("* ...", "shy_down", "susie")
                cutscene:text("* ".. Game.party[1].name ..",[wait:5] once we pass through this door...", "neutral", "susie")
                cutscene:text("* Our adventure will\nreally begin.", "small_smile", "susie")
                cutscene:text("* Our journey to save Kris...", "smile", "susie")
                cutscene:text("* I mean,[wait:5] ".. Game.party[1].name ..",[wait:5] I believe YOUR choices are important too.", "smirk", "susie")
                cutscene:text("* This world is full of\nall kinds of people,[wait:5]\nafter all.", "smile", "susie")
                cutscene:text("* So...[wait:5] I guess how we treat them makes all the difference,[wait:5] am I right?", "shy_b", "susie")
                cutscene:text("* So let's try our best to\nget by without FIGHTing.", "smile", "susie")
                cutscene:text("* If we can manage to do\nthat...", "smirk", "susie")
                cutscene:text("* I believe this tale may\nhave a happy ending.", "smile", "susie")
                cutscene:text("* Otherwise,[wait:5] I think\nthat...", "sus_nervous", "susie")
                cutscene:text("* ... we may not...[wait:5] find\nthe result favorable.", "sincere", "susie")
                cutscene:text("* ... Is that too much to ask?", "small_smile", "susie")
                local choice = cutscene:choicer({"I can\nhandle it", "....."})
                if choice == 1 then
                    cutscene:text("* 'Course you can.", "sincere_smile", "susie")
                    cutscene:text("* Let's try our best,[wait:5]\nalright?", "sincere", "susie")
                else
                    cutscene:text("* ... Oh,[wait:5] sorry.", "shy_down", "susie")
                    cutscene:text("* In the end,[wait:5] what you choose is up to you.", "shy_down", "susie")
                    cutscene:text("* As long as you're happy\nwith it,[wait:5] I'm happy too,[wait:5] I guess.", "smile_b", "susie")
                    cutscene:text("* So just try your best,[wait:5]\nand don't worry.", "smile", "susie")
                end
    
            elseif ralsei then
                if ralsei.path == "party/ralsei/dark_ch1" then
                    cutscene:text("[speed:999]* Oh my!\n* The Great Door is\nopened?!", "surprise", "ralsei")
                    cutscene:text("* No wonder Jimmy was\nable to come through...", "surprise", "ralsei")
                    cutscene:text("* ...", "look_down", "ralsei")
                    cutscene:text("* ".. Game.party[1].name ..",[wait:5] once we pass through this door...", "look_down", "ralsei")
                    cutscene:text("* Our adventure will\nreally begin.", "look_down", "ralsei")
                    cutscene:text("* Our journey to save Kris...", "look_down", "ralsei")
                    cutscene:text("* But,[wait:5] ".. Game.party[1].name ..",[wait:5] I believe YOUR choices are important,[wait:5] too.", "pleased", "ralsei")
                    cutscene:text("* This world is full of\nall kinds of people,[wait:5]\n".. Game.party[1].name ..".", "smile", "ralsei")
                    cutscene:text("* In the end,[wait:5] how we treat\nthem makes all the difference.", "pleased", "ralsei")
                    cutscene:text("* So let's try our best to\nget by without FIGHTing.", "smile_b", "ralsei")
                    cutscene:text("* If we can manage to do\nthat...", "look_down", "ralsei")
                    cutscene:text("* I believe this tale may\nhave a happy ending.", "smile", "ralsei")
                    cutscene:text("* Otherwise,[wait:5] I fear\nthat...", "pleased", "ralsei")
                    cutscene:text("* ... you may not...[wait:5] find\nthe result favorable.", "look_down", "ralsei")
                    cutscene:text("* ... Oh,[wait:5] I'm sorry![wait:10] Is\nthat too much to ask?", "surprise", "ralsei")
                    local choice = cutscene:choicer({"I can\nhandle it", "....."})
                    if choice == 1 then
                        cutscene:text("* ".. Game.party[1].name ..",[wait:5] I knew you were a hero the moment I saw you.", "smile", "ralsei")
                        cutscene:text("* Let's try our best,[wait:5]\nalright?", "pleased", "ralsei")
                    else
                        cutscene:text("* ... Oh,[wait:5] I'm sorry!", "surprise", "ralsei")
                        cutscene:text("* ".. Game.party[1].name ..",[wait:5] in the end,[wait:5] what you choose is up to you.", "pleased", "ralsei")
                        cutscene:text("* As long as you're happy\nwith it,[wait:5] I'm happy too.", "smile_b", "ralsei")
                        cutscene:text("* So just try your best,[wait:5]\nand don't worry!", "smile", "ralsei")
                    end
                end
            end

            Game:setFlag("mrbeast_greatdoorviewseen", true)
        end

        
    end,

    greatdoor = function(cutscene)

        Game.world.music:fade(0, 1)

        cutscene:wait(0.1)

        local alpha = Game.world.player:addFX(AlphaFX())

        Game.stage.timer:tween(0.5, alpha, {alpha = 0})

        cutscene:wait(0.75)

        local follower
        if cutscene:getCharacter("alseri") then
            follower = cutscene:getCharacter("alseri")
        elseif cutscene:getCharacter("ralsei") then
            follower = cutscene:getCharacter("ralsei")
        else
            if Game.party[2] then
                follower = cutscene:getCharacter(Game.party[2].id)
            end
        end

        if follower then
            cutscene:walkTo(follower, "sillybilly", 1.25, "up")
            cutscene:wait(1.26)
            cutscene:look(follower, "down")
            cutscene:wait(1.74)
            for _,pmemb in pairs(Game.party) do
                local pchara = cutscene:getCharacter(pmemb.id)
                if pchara then
                    pchara.alpha = 0
                end
            end
            Game.world.map:getEvent("giantdarkdoor").tile = 0
            Assets.playSound("impact")
        end

        cutscene:wait(1)
        cutscene:fadeOut(1)
        cutscene:wait(1)
        Game.world:loadMap("cloudwebs/_Chapter1/Fields/fields_1", "entrydown", "down")
        cutscene:wait(1)
        cutscene:fadeIn(1)
        Game.world.music:fade(1, 1)

        cutscene:after(function()
            Game.world:startCutscene(function(cutscene)
                cutscene:wait(cutscene:fadeOut(0)) -- remove fadein
                cutscene:fadeIn(3)
            end)
        end)
        
    end,

    fohad_sign_1 = function(cutscene)
        cutscene:text("* (Enemies ahead![wait:5] You're gonna\ndie!)[wait:5]\n* (SIGNED, LANCER)")
        cutscene:text("* Huh,[wait:5] a sign from Lancer?", "smile", "susie")
        cutscene:text("* ...", "annoyed_down", "susie")
        cutscene:text("* Hey,[wait:5] where the HELL is Lancer,[wait:5] anyway?", "annoyed", "susie")
    end,
    fohad_sign_2 = function(cutscene)
        cutscene:text("* (If you're reading this...[wait:5]\nI guess you're dead.)[wait:5]\n* (SIGNED, LANCER)")
    end,
    fohad_sign_3 = function(cutscene)
        cutscene:text("* (These types of trees DON'T contain an item that can heal you.)")
        cutscene:text("* (Whatever you do,[wait:5] DON'T check the tree and use [".. Input.key_bindings["menu"][1]:upper() .."] to open your menu!)")
        cutscene:text("* (You got it!?)\n* (SIGNED,[wait:5] LANCER)")
    end,

    thegiftreaction = function(cutscene)
        local noyno = cutscene:getCharacter("noyno")
        local alseri = cutscene:getCharacter("alseri")
        local ralsei = cutscene:getCharacter("ralsei")
        if noyno then
            cutscene:text("* Hey,[wait:5] would ya look at that.[wait:10] \"The Gift\" is lighting up the path again.", "doubt", "noyno")
            cutscene:text("* Last time it was more like...[wait:5] Shitty green colored.", "doubt", "noyno")
            cutscene:text("* Y'know,[wait:5] just like you?", "gleeful", "noyno")
            cutscene:text("* Oh well.", "look_left", "noyno")
        elseif alseri then
            cutscene:text("* Oh,[wait:5] look at that![wait:10] Your eyes are lighting up the path for us!", "surprise", "alseri")
            cutscene:text("* So you have \"The Gift\" too,[wait:5] huh?", "smug", "alseri")
            cutscene:text("* What?[wait:10] No, I don't have it.[wait:10] I just know someone who does.", "look_side", "alseri")
            cutscene:text("* And I'm not talking about you,[wait:5] YOU.", "ravioli", "alseri")
            cutscene:text("* I totally haven't been binging through multiple playthroughs of Ribbit for these last 7 years.", "blush_side_b", "alseri")
            cutscene:text("* I'm talking about Kris,[wait:5] if you were wondering.", "neutral", "alseri")
        elseif ralsei then
            cutscene:text("* Oh,[wait:5] look at that![wait:10] Your eyes are lighting up the path for us!", "surprise", "ralsei")
            cutscene:text("* That's,[wait:5] um,[wait:5], cool.", "smile_b", "ralsei")
        end
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
            cutscene:text("* Hey,[wait:5] think I can break\nthis wall?", "smile")

            -- Get the bottom-center of the broken wall
            local x = event.x + event.width/2
            local y = event.y + event.height/2

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
            susie:setAnimation({"away_scratch", 0.25, true})
            susie:shake(4)
            Assets.playSound("wing")

            cutscene:wait(1)
            cutscene:text("* Guess not.", "nervous")

            -- Reset Susie's sprite
            susie:resetSprite()

            -- Reattach the camera
            cutscene:attachCamera()

            -- Align the follower positions behind Kris's current position
            cutscene:alignFollowers()
            -- And reattach them, making them return to their target positions
            cutscene:attachFollowers()
        end
    end,

}