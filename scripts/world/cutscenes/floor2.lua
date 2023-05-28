return {
    queen_sip = function(cutscene, event)
        Assets.playSound("queen/queensip_1")
        cutscene:text("[noskip]*[wait:3s]", "sip", "queen", {auto = true})

        if Game:hasPartyMember("YOU") then
            cutscene:text("* Susie Blue Frog That Isn't Kris How Do You Like My New:", "smile", "queen")
        elseif Game:hasPartyMember("kris") then
            cutscene:text("* Kris Susie How Do You Like My New:", "smile", "queen")
		else
            cutscene:text("* Greetings Everyone How Do You Like My New:", "smile", "queen")
        end
		
        Assets.playSound("queen/queensip_2")
        cutscene:text("[noskip]*[wait:1s]", "sip", "queen", {auto = true})
		
        cutscene:text("* Room", "smile", "queen")

        Assets.playSound("queen/queensip_3")
        cutscene:text("[noskip]*[wait:2s]", "sip", "queen", {auto = true})

        cutscene:text("* Do You Want A Sip", "smile", "queen")
        cutscene:text("* Uhh...[wait:3] that's acid. We'd die.", "nervous_side", "susie")
        cutscene:text("* Oh Dear First You Don't Want To Swim In The Free Pool", "smile", "queen")
        cutscene:text("* Now You Don't Want To Drink The Free Pool Water", "pout", "queen")
        cutscene:text("* More For Me I Suppose", "smile_side_l", "queen")
    end,



    borencountervortex = function(cutscene)
        
        Game.world.music:fade(0, 1)

        cutscene:detachFollowers()

        local kris = cutscene:getCharacter("YOU")
        local susie = cutscene:getCharacter("susie")

        cutscene:slideTo(kris, 540 - 30, 380, 0.3)
        cutscene:slideTo(susie, 540 + 30, 380, 0.3)
        cutscene:panTo(540, 380, 0.25)

        cutscene:wait(1)

        if Game:hasPartyMember("susie") then
            cutscene:text("* What the?!", "angry_b", "susie")
            if Game:hasPartyMember("kris") then
                cutscene:text("* Look,[wait:0.1s] Kris![wait:0.3s]\n* It's another time vortex!", "angry_b", "susie")
            elseif Game:hasPartyMember("YOU") then
                cutscene:text("* Look,[wait:0.1s] Kr-[wait:0.1s]YOU![wait:0.3s]\n* It's a time vortex!", "angry_b", "susie")
                
                local choice = cutscene:choicer({"What the shit\nis that", "oh"})
                cutscene:text("* Oh,[wait:0.1s] right.[wait:0.3s] You don't know what that is.", "annoyed_down", "susie")
                if cutscene:getCharacter("bor") then
                    cutscene:text("* Okay,[wait:0.1s] so.[wait:0.3s] Basically, a time vortex is-[next]", "annoyed_down", "susie")
                    cutscene:text("* missing light reference", "pog", "bor")
                    cutscene:text("* What", "neutral", "susie")
                    cutscene:text("* deltarun missing light reference", "pog", "bor")
                    cutscene:getCharacter("susie"):setSprite("angry_down")
                    cutscene:text("* Dude,[wait:0.1s] what the FUCK is a \"missing light\"?!", "teeth", "susie")
                    cutscene:getCharacter("susie"):resetSprite()
                    cutscene:text("* My world", "smug", "bor")
                    cutscene:text("* Oh,[wait:0.1s] so that's where you weirdos come from.", "annoyed", "susie")
                    cutscene:text("* No you fucking buffoon", "question", "bor")
                    cutscene:text("* Just caus i MADE a place doesnt mean i LIVE in it.", "question", "bor")
                    cutscene:getCharacter("susie"):setSprite("angry_down")
                    cutscene:text("* Oh my god", "teeth_b", "susie")
                    cutscene:getCharacter("susie"):resetSprite()

                    cutscene:text("* k so basically vortexes are things", "happy", "bor")
                    cutscene:text("* things that our good friends,", "happy", "bor")
                    cutscene:text("* Krispy, Barney and Frisbee Undertail,", "happy", "bor")
                    cutscene:text("* have to go through,", "happy", "bor")
                    cutscene:text("* so that they can save the entire plane of existence from a silly billy Krispy commited when going edgy-mode[next]", "happy", "bor")

                    cutscene:text("* Okay that's enough.", "teeth_b", "susie")
                    cutscene:text("* But basically,[wait:0.1s] we have to go down there NOW!", "angry", "susie")

                    cutscene:text("* alr bluddies keep me outta this", "troll", "bor")
                    cutscene:getCharacter("susie"):setSprite("angry_down")
                    cutscene:text("* YES YOU STAY HERE YOU FORSAKEN PIECE OF SHIT", "teeth", "susie")

                    cutscene:text("* jeez lady, \"chill\" out.", "smug", "bor")

                    cutscene:text("* I AM DONE TALKING TO YOU", "teeth", "susie")
                    cutscene:getCharacter("susie"):resetSprite()
                else
                    cutscene:text("* Okay,[wait:0.1s] so.[wait:0.3s] Basically, a time vortex is,[wait:0.1s] uh...", "neutral_side", "susie")
                    cutscene:text("* Like some kind of opening in the fabric of time and space,[wait:0.1s] or something.[wait:0.3s] Quoting Ralsei here.", "nervous_side", "susie")
                    cutscene:text("* But basically we have to go down there NOW!", "angry", "susie")
                end
            else
                cutscene:text("* Look![wait:0.3s]\n* It's a time vortex!", "angry_b", "susie")

                if cutscene:getCharacter("bor") then
                    cutscene:text("* Okay,[wait:0.1s] so.[wait:0.3s] Basically, a time vortex is-[next]", "annoyed_down", "susie")
                    cutscene:text("* missing light reference", "pog", "bor")
                    cutscene:text("* What", "neutral", "susie")
                    cutscene:text("* deltarun missing light reference", "pog", "bor")
                    cutscene:getCharacter("susie"):setSprite("angry_down")
                    cutscene:text("* Dude,[wait:0.1s] what the FUCK is a \"missing light\"?!", "teeth", "susie")
                    cutscene:getCharacter("susie"):resetSprite()
                    cutscene:text("* My world", "smug", "bor")
                    cutscene:text("* Oh,[wait:0.1s] so that's where you weirdos come from.", "annoyed", "susie")
                    cutscene:text("* No you fucking buffoon I MADE that place.[wait:0.2s]\n* That doesn't mean I LIVE in it.", "question", "bor")
                    cutscene:getCharacter("susie"):setSprite("angry_down")
                    cutscene:text("* Oh my god", "teeth_b", "susie")
                    cutscene:getCharacter("susie"):resetSprite()

                    cutscene:text("* k so basically vortexes are things", "happy", "bor")
                    cutscene:text("* things that Krispy Kreme, Barney and Frisbee Undertail go through", "happy", "bor")
                    cutscene:text("* so that they can save the entire plane of existence from a silly billy Krispy commited when going edgy-mode", "happy", "bor")

                    cutscene:text("* Okay that's enough.", "teeth_b", "susie")
                    cutscene:text("* But basically,[wait:0.1s] we have to go down there NOW!", "angry", "susie")

                    cutscene:text("* alr bluddies keep me outta this", "troll", "bor")
                    cutscene:getCharacter("susie"):setSprite("angry_down")
                    cutscene:text("* YES YOU STAY HERE YOU FORSAKEN PIECE OF SHIT", "angry", "susie")

                    cutscene:text("* jeez lady, \"chill\" out.", "smug", "bor")

                    cutscene:text("* I AM DONE TALKING TO YOU", "angry", "susie")
                    cutscene:getCharacter("susie"):resetSprite()
                else
                    cutscene:text("* Okay,[wait:0.1s] so.[wait:0.3s] Basically, a time vortex is,[wait:0.1s] uh...", "neutral_side", "susie")
                    cutscene:text("* Like some kind of opening in the fabric of time and space,[wait:0.1s] or something.[wait:0.3s] Quoting Ralsei here.", "nervous_side", "susie")
                    cutscene:text("* But basically we have to go down there NOW!", "angry", "susie")
                end
            end

            for _,pmemb in pairs(Game.party) do
                if pmemb.id ~= "YOU" and pmemb.id ~= "susie" then
                    Game:removePartyMember(pmemb.id)
                end
            end
            
            cutscene:after(function()
                Game.world:startCutscene("TimeVortexCutscene", "roombor")
            end)

        end

        Game:setFlag("cloudwebStoryFlag", 1)
        
    end,






    -- ┌──────────────────────────┐ --
	-- │     Bor Door Thingy      │ --
	-- └──────────────────────────┘ --
    bordoor = function(cutscene, event)
        local flag = Game:getFlag("BorDoorCodeUnlocked", false)

        if flag == false then
            cutscene:text("* The door is locked.")
            cutscene:text("* It seems to have some kind of cryptic password.")
            cutscene:text("* Would you like to enter a code? It might be correct.")

            if cutscene:choicer({ "Yes", "No" }) == 2 then
                return
            end

            if cutscene:getCharacter("bor") then
                cutscene:text("* Hey, blud.", "happy", "bor")
                cutscene:text("* You should try entering \"ISUCKASS\".", "look_side", "bor")
                cutscene:text("* I bet it will surely work\n[wait:0.5s]    and stuff", "troll", "bor")
            end

            cutscene:after(function()
                local menu = BorDoorInputMenu()
                -- I'm sorry
                ---@param action BorDoorCodeInfo
                menu.finish_cb = function(action)
                    Game.world:startCutscene("floor2", "bordoor_proc", action)
                end
                Game.world:openMenu(menu)
            end)

        else

            --take to room instantly
    
            Game.world.fader:fadeOut(nil, {
                speed = 0.3,
            })
    
            cutscene:wait(0.5)
            cutscene:loadMap("floor2/roombor", "entryup", "up")
            Game.world.fader:fadeIn(nil, {
                speed = 0.2,
            })



        end
        
	end,

	---@param cutscene WorldCutscene
	---@param action BorDoorCodeInfo
	bordoor_proc = function(cutscene, action)

        local timesusedthisshid = Game:getFlag("timesUsedWrongBorDoorCode", 0)
        
        if cutscene:getCharacter("bor") then



            if Game:getFlag("timesUsedWrongBorDoorCode", 0) == 5 then
                Game:setFlag("timesUsedWrongBorDoorCode", 0)
                cutscene:text("* iPhone Unavailable\n* Try again in 1 minute.")
                cutscene:text("* Wooooooooooow.", "confused", "bor")
                cutscene:text("* Just wow.", "confused_side", "bor")
                cutscene:text("* I LITERALLY TOLD YOU THE CODE YOU PRIMATE", "HOLYFUCK", "bor")
                cutscene:text("* YOU FUCKIGN APE", "OHMYFUCKINGGOD", "bor")
                cutscene:text("* Nice", "happy", "bor")
                cutscene:text("* FUCKINg nice", "oml", "bor")
                cutscene:text("* I'm now locked out of my own room. For an entire minute.", "blush", "bor")
                return
            end
    
            if not action then
                cutscene:text("* \"Incorrect password, bitch! Stop trying to break into my goddamn room!!\".")
                Game:setFlag("timesUsedWrongBorDoorCode", timesusedthisshid + 1)
                cutscene:text("* Wooooooooooow.", "confused", "bor")
                cutscene:text("* Just wow.", "confused_side", "bor")
                cutscene:text("* I LITERALLY TOLD YOU THE CODE YOU PRIMATE", "HOLYFUCK", "bor")
                cutscene:text("* YOU FUCKIGN APE", "OHMYFUCKINGGOD", "bor")
                return
            end
    
                
            cutscene:text("* Door unlocked.")
            Game:setFlag("BorDoorCodeUnlocked", true)
    
            cutscene:wait(0.2)
    
            Game.world.fader:fadeOut(nil, {
                speed = 1,
            })
    
            cutscene:wait(1)
            cutscene:loadMap("floor2/roombor", "entryup", "up")
            Game.world.fader:fadeIn(nil, {
                speed = 0.25,
            })



        else

            if Game:getFlag("timesUsedWrongBorDoorCode", 0) == 5 then
                Game:setFlag("timesUsedWrongBorDoorCode", 0)
                cutscene:text("iPhone Unavailable\nTry again in 1 minute.")
                if Game.susieWarnedPlayerAboutBorDoorCode == false then
                    Game.susieWarnedPlayerAboutBorDoorCode = true
                    if cutscene:getCharacter("susie") then
                        if cutscene:getCharacter("YOU") then
                            cutscene:text("* Hey, YOU.", "sus_nervous", "susie")
                        elseif cutscene:getCharacter("kris") then
                            cutscene:text("* Hey, Kris.", "sus_nervous", "susie")
                        end
                        cutscene:text("* It seems like we,[wait:0.1s] um,[wait:0.1s] fucked up.", "sus_nervous", "susie")
                        cutscene:text("* I think we should...[wait:0.1s] go find somebody who can help us??", "sus_nervous", "susie")
                    else
                        cutscene:text("* (Damn, it looks like I fucked up.)")
                        cutscene:text("* (I should go find someone who can help.)")
                        cutscene:text("* (Perhaps a blue blob with orange arms and kirby's feet?)")
                    end
                end
                return
            end

            cutscene:text("* \"Incorrect password, bitch! Stop trying to break into my goddamn room!!\".")
            Game:setFlag("timesUsedWrongBorDoorCode", timesusedthisshid + 1)
            return

        end
        
    end,
}