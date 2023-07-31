return {
    ---@param cutscene WorldCutscene
    backrooms_entry = function(cutscene, event)
        Game.world.music:fade(0, 0.25)
        Assets.playSound("dooropen")
        event:setSprite("world/events/floor2/backroomsdoor_open")
        cutscene:wait(0.5)

        cutscene:wait(cutscene:mapTransition("backrooms/entrance", "entry"))
        Assets.playSound("doorclose")
    end,
    queen_sip = function(cutscene, event)
        Assets.playSound("queen/queensip_1")
        cutscene:text("[noskip]*[wait:3s]", "sip", "queen", {auto = true})
        if Game:hasPartyMember("YOU") and Game:hasPartyMember("susie") then
            cutscene:text("* Susie Two Legged Amphibian How Do You Like My New:", "smile", "queen")
        elseif Game:hasPartyMember("kris") and Game:hasPartyMember("susie") then
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

    bordoor = function(cutscene, event)
        if Game:getFlag("BorDoorCodeUnlocked", false) then
            --take to room instantly
            Game.world.fader:fadeOut(nil, {
                speed = 0.3,
            })
            cutscene:wait(0.5)
            cutscene:loadMap("floor2/roombor", "entryup", "up")
            Game.world.fader:fadeIn(nil, {
                speed = 0.2,
            })
            return
        end

        if event.timeouted then
            cutscene:text("* iPhone Unavailable\n* Try again in 1 minute.")
            return
        end

        local timesusedthisshid = Game:getFlag("timesUsedWrongBorDoorCode", 0)
        if timesusedthisshid < 1 then
            cutscene:text("* The door is locked.")
            cutscene:text("* It seems to have some kind of cryptic password.")
            cutscene:text("* Would you like to enter a code? It might be correct.")
        else
            cutscene:text("* The door is locked. Enter a code?")
        end

        if cutscene:choicer({ "Yes", "No" }) == 2 then
            return
        end

        if cutscene:getCharacter("bor") then
            if timesusedthisshid < 1 then
                cutscene:text("* Hey, blud.", "happy", "bor")
                cutscene:text("* You should try entering \"ISUCKASS\".", "look_side", "bor")
                cutscene:text("* I bet it will surely work\n[wait:0.5s]    and stuff", "troll", "bor")
            else
                cutscene:text("* Try entering \"ISUCKASS\"", "troll", "bor")
            end
        end

        local wbi_ok = false
        local entered_correct_code = false
        local wbi = WarpBinInputMenu()
        wbi.as_warp_bin_ui = false
        wbi.finish_cb = function(action, raw_input)
            wbi_ok = true
            entered_correct_code = raw_input:lower() == "isuckass"
        end
        Game.world:spawnObject(wbi, "ui")
        cutscene:wait(function() return wbi_ok end)

        if not entered_correct_code then
            if timesusedthisshid == 5 then
                Game:setFlag("timesUsedWrongBorDoorCode", 0)
                event.timeouted = true
                cutscene:text("* iPhone Unavailable\n* Try again in 1 minute.")
            else
                Game:addFlag("timesUsedWrongBorDoorCode", 1)
                cutscene:text("* \"Incorrect password, bitch! Stop trying to break into my goddamn room!!\".")
            end

            if cutscene:getCharacter("bor") then
                cutscene:text("* Wooooooooooow.", "confused", "bor")
                cutscene:text("* Just wow.", "confused_side", "bor")
                cutscene:text("* I LITERALLY TOLD YOU THE CODE YOU PRIMATE", "HOLYFUCK", "bor")
                cutscene:text("* YOU FUCKIGN APE", "OHMYFUCKINGGOD", "bor")
                if timesusedthisshid == 5 then
                    cutscene:text("* Nice", "happy", "bor")
                    cutscene:text("* FUCKINg nice", "oml", "bor")
                    cutscene:text("* I'm now locked out of my own room. For an entire minute.", "blush", "bor")
                end
            elseif cutscene:getCharacter("susie") and not event.susie_warned_about_code then
                event.susie_warned_about_code = true
                if cutscene:getCharacter("YOU") then
                    cutscene:text("* Hey, YOU.", "sus_nervous", "susie")
                elseif cutscene:getCharacter("kris") then
                    cutscene:text("* Hey, Kris.", "sus_nervous", "susie")
                end
                cutscene:text("* It seems like we,[wait:0.1s] um,[wait:0.1s] screwed up.", "sus_nervous", "susie")
                cutscene:text("* I think we should...[wait:0.1s] go find somebody who can help us??", "sus_nervous", "susie")
            else
                cutscene:text("* (Damn, it looks like I fucked up.)")
                cutscene:text("* (I should go find someone who can help.)")
                cutscene:text("* (Perhaps a blue blob with orange arms and Kirby's feet?)")
            end

            return
        end

        Game:setFlag("BorDoorCodeUnlocked", true)
        cutscene:text("* Door unlocked.")

        cutscene:mapTransition("floor2/roombor", "entryup", "up")
    end,

    borencountervortex = function(cutscene)
        local leader = Mod:getLeader("chara")
        local kris = cutscene:getCharacter("kris")
        local susie = cutscene:getCharacter("susie")
        local bor = cutscene:getCharacter("bor")
        if not susie then
            return
        end

        Game:setFlag("cloudwebStoryFlag", 1)

        Game.world.music:fade(0, 1)
        cutscene:detachFollowers()
        cutscene:slideTo(leader, 540 - 30, 380, 0.3)
        cutscene:slideTo(susie, 540 + 30, 380, 0.3)
        cutscene:panTo(540, 380, 0.25)
        cutscene:wait(1)

        cutscene:text("* What the?!", "angry_b", "susie")
        if kris then
            cutscene:text("* Look,[wait:0.1s] Kris![wait:0.3s]\n* It's another time vortex!", "angry_b", "susie")
            cutscene:text("* We have to go down there NOW!", "angry", "susie")
        else
            if Game:hasPartyMember("YOU") then
                cutscene:text("* Look,[wait:0.1s] Kr-[wait:0.1s]YOU![wait:0.3s]\n* It's a time vortex!", "angry_b", "susie")

                cutscene:choicer({"What the hell\nis that", "oh"})
                cutscene:text("* Oh,[wait:0.1s] right.[wait:0.3s] You don't know what that is.", "annoyed_down", "susie")
            else
                cutscene:text("* Look![wait:0.3s]\n* It's a time vortex!", "angry_b", "susie")
            end

            if bor then
                cutscene:text("* Okay,[wait:0.1s] so.[wait:0.3s] Basically, a time vortex is-[next]", "annoyed_down", "susie")

                cutscene:text("* missing light reference", "pog", "bor")

                cutscene:text("* What?", "neutral", "susie")

                cutscene:text("* deltarun missing light reference", "pog", "bor")

                susie:setSprite("angry_down")
                cutscene:text("* Dude,[wait:0.1s] what the actual HELL is a \"missing light\"?!", "teeth", "susie")
                susie:resetSprite()

                cutscene:text("* My world", "smug", "bor")

                cutscene:text("* Oh,[wait:0.1s] so that's where you weirdos come from.", "annoyed", "susie")

                cutscene:text("* No you fucking buffoon", "question", "bor")
                cutscene:text("* Just caus i MADE a place doesnt mean i LIVE in it.", "question", "bor")

                susie:setSprite("angry_down")
                cutscene:text("* Oh my god...", "teeth_b", "susie")
                susie:resetSprite()

                cutscene:text("* k so basically vortexes are things", "happy", "bor")
                cutscene:text("* things that our good friends,", "happy", "bor")
                cutscene:text("* Krispy, Barney and Frisbee Undertail,", "happy", "bor")
                cutscene:text("* have to go through,", "happy", "bor")
                cutscene:text("* so that they can save the entire plane of existence from a silly billy Krispy commited when going edgy-mode[next]", "happy", "bor")

                cutscene:text("* Okay that's enough.", "teeth_b", "susie")
                cutscene:text("* But basically,[wait:0.1s] we have to go down there NOW!", "angry", "susie")

                cutscene:text("* alr bluddies keep me outta this", "troll", "bor")

                susie:setSprite("angry_down")
                cutscene:text("* YES YOU STAY HERE YOU FORSAKEN BLOB OF SILLY PUTTY!", "teeth", "susie")

                cutscene:text("* jeez lady, \"chill\" out.", "smug", "bor")

                cutscene:text("* I AM DONE TALKING TO YOU!!", "teeth", "susie")
                susie:resetSprite()
            else
                cutscene:text("* Okay,[wait:0.1s] so.[wait:0.3s] Basically, a time vortex is,[wait:0.1s] uh...", "neutral_side", "susie")
                cutscene:text("* Some kind of opening in the fabric of time and space,[wait:0.1s] or something.", "nervous_side", "susie")
                cutscene:text("* But basically we have to go down there NOW!", "angry", "susie")
            end
        end

        for _,member in pairs(Game.party) do
            if member.id ~= "YOU" and member.id ~= "susie" then
                Game:removePartyMember(member.id)
            end
        end

        cutscene:gotoCutscene("TimeVortexCutscene", "roombor")
    end
}