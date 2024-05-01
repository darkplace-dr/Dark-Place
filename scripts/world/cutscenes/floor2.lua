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
        cutscene:showNametag("Queen")
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
        cutscene:hideNametag()

        cutscene:showNametag("Susie")
        cutscene:text("* Uhh...[wait:3] that's acid. We'd die.", "nervous_side", "susie")
        cutscene:hideNametag()
		
        if cutscene:getCharacter("jamm") then
            cutscene:showNametag("Jamm")
            cutscene:text("* Correction, Susie. YOU'd die.", "smug", "jamm")
            cutscene:text("* Wait, why's everyone looking at me like that?", "neutral", "jamm")
            cutscene:hideNametag()
        end

        cutscene:showNametag("Queen")
        cutscene:text("* Oh Dear First You Don't Want To Swim In The Free Pool", "smile", "queen")
        cutscene:text("* Now You Don't Want To Drink The Free Pool Water", "pout", "queen")
        cutscene:text("* More For Me I Suppose", "smile_side_l", "queen")
        cutscene:hideNametag()
    end,
	
    rouxls = function(cutscene, event)
        local rouxls = cutscene:getCharacter("rouxls")

        cutscene:setSpeaker("rouxls")
        cutscene:text("* Don't mindeth mineself, I'm just a lampe!", "neutral", "rouxls")
        if Game:hasPartyMember("susie") then
            cutscene:text("* The finest lampe made for her majesty, Que-", "open", "rouxls", { auto = true })
            cutscene:setSpeaker(nil)

            cutscene:text("* Dude, what the hell are you doing?", "suspicious", "susie")

            cutscene:setSpeaker("rouxls")
            cutscene:text("* Ah![wait:5] Look whom decidedeth to slither in like the wormes thoust are!", "shock", "rouxls")
            cutscene:text("* What does thoust need from the Duke of Lampes,[wait:5] Rouxls Kaard?", "wink", "rouxls")
            cutscene:setSpeaker(nil)
			
            cutscene:text("* Well, I have SEVERAL questions actually.", "sus_nervous", "susie")
            cutscene:text("* First of all,[wait:5] why are you disguising yourself as Queen's lamp?", "annoyed", "susie")

            cutscene:setSpeaker("rouxls")
            cutscene:text("* [speed:0.5]...", "shock", "rouxls")
            cutscene:text("* DON'T ASKETH QUESTIONS THOUST AREN'T PREPARED TO HEAR THE ANSWER TO.", "shock_right", "rouxls")
            cutscene:setSpeaker(nil)

            cutscene:text("* ...[wait:5]okay...?", "suspicious", "susie")
            cutscene:text("* Secondly, are you gonna hop back into our pockets now?", "sus_nervous", "susie")
            cutscene:text("* Y'know,[wait:5] since we found you and all that.", "nervous_side", "susie")

            cutscene:setSpeaker("rouxls")
            cutscene:text("* Nay![wait:5] I shan't!", "shock", "rouxls")
            cutscene:setSpeaker(nil)

            cutscene:text("* What?[wait:2] WHY?!", "teeth", "susie")
			
            cutscene:setSpeaker("rouxls")
            cutscene:text("* I shall not removeth mineself from the premises...", "open", "rouxls")
            cutscene:text("* Unless her Majesty says otherwise.", "eyesclosed", "rouxls")
            cutscene:setSpeaker(nil)

            cutscene:text("* Oh,[wait:2] really?[wait:8]\n* Well, in that case...", "surprise", "susie")
			
            cutscene:text("* Hey, Queen! Can we borrow your lamp for a bit?[react:1]", "smirk", "susie", {reactions = { 
                {"Wait what-", "right", "bottom", "shock", "rouxls"}
            }})

            Assets.playSound("queen/queensip_3")
            cutscene:text("[noskip]*[wait:2s]", "sip", "queen", {top = false, auto = true})
            cutscene:text("* Processing Verification[react:1]", "smile", "queen", {top = false, reactions = { 
                {"No, wait I-", "right", "bottom", "shock_right", "rouxls"}
            }})
            cutscene:text("* ...", "down_a", "queen", {top = false})
            cutscene:text("* Yeah You Can Take It", "smile_side_l", "queen", {top = false})
			
            cutscene:text("* Sick! Thanks, Queen.", "smile", "susie")
			
            cutscene:setSpeaker("rouxls")
            cutscene:text("[speed:0.5]* ...", "shock", "rouxls")
            cutscene:text("[speed:0.5]* GOD", "shock", "rouxls")
            cutscene:text("[speed:0.5]* DAMMIT", "shock", "rouxls")
            cutscene:setSpeaker(nil)
			
            rouxls:remove()
            Game:setFlag("hasObtainedRouxls", true)
            Game.inventory:tryGiveItem("rouxls")
            Assets.playSound("item")
            cutscene:text("* Rouxls Kaard re-entered your [color:yellow]KEY ITEMS[color:reset]...[wait:10]reluctantly.")
        else
            cutscene:text("* The finest lampe made for her majesty, Queen!", "open", "rouxls")
		end
    end,

    bordoor = function(cutscene, event)
        if Game:getFlag("BorDoorCodeUnlocked", false) then
            cutscene:mapTransition("floor2/roombor", "entryup", "up")
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
                cutscene:showNametag("Bor")
                cutscene:text("* Hey, blud.", "happy", "bor")
                cutscene:text("* You should try entering \"ISUCKASS\".", "look_side", "bor")
                cutscene:text("* I bet it will surely work\n[wait:0.5s]    and stuff", "troll", "bor")
                cutscene:hideNametag()
            else
                cutscene:showNametag("Bor")
                cutscene:text("* Try entering \"ISUCKASS\"", "troll", "bor")
                cutscene:hideNametag()
            end
        end

        local wbi_ok = false
        local entered_correct_code = false
        local wbi = WarpBinInputMenu()
        wbi.as_warp_bin_ui = false
        wbi.cancellable = false
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
                cutscene:showNametag("Bor")
                cutscene:text("* Wooooooooooow.", "confused", "bor")
                cutscene:text("* Just wow.", "confused_side", "bor")
                cutscene:text("* I LITERALLY TOLD YOU THE CODE YOU PRIMATE", "HOLYFUCK", "bor")
                cutscene:text("* YOU FUCKIGN APE", "OHMYFUCKINGGOD", "bor")
                if event.timeouted then
                    cutscene:text("* Nice", "happy", "bor")
                    cutscene:text("* FUCKINg nice", "oml", "bor")
                    cutscene:text("* I'm now locked out of my own room. For an entire minute.", "blush", "bor")
                end
                cutscene:hideNametag()
            elseif cutscene:getCharacter("susie") and not event.susie_warned_about_code then
                event.susie_warned_about_code = true
                if cutscene:getCharacter("YOU") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* Hey, YOU.", "sus_nervous", "susie")
                elseif cutscene:getCharacter("kris") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* Hey, Kris.", "sus_nervous", "susie")
                end
                cutscene:text("* It seems like we,[wait:0.1s] um,[wait:0.1s] screwed up.", "sus_nervous", "susie")
                cutscene:text("* I think we should...[wait:0.1s] go find somebody who can help us??", "sus_nervous", "susie")
                cutscene:hideNametag()
            else
                cutscene:text("* (Damn,[wait:5] it looks like you fucked up.)")
                cutscene:text("* (You should go find someone who can help.)")
                cutscene:text("* (Perhaps a blue blob with orange arms and Kirby's feet?)")
            end

            return
        end

        cutscene:shakeCamera(2, 2)
        Assets.playSound("impact", 0.6)
        Assets.playSound("screenshake")
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
    end,

    meet_lancer = function(cutscene, event)
        local leader = Mod:getLeader("chara")
        local susie = cutscene:getCharacter("susie")
        local lancer = cutscene:getCharacter("lancer")
        if not lancer then -- Somehow this can happen?
            lancer = Game.world:spawnNPC("lancer", 340, 200)
        end

        cutscene:detachFollowers()
        lancer:setPosition(325, 236)
        lancer:setFacing("up")
		
        cutscene:wait(1)

        if susie then
            cutscene:text("* Wait,[wait:2] is that-?", "surprise", "susie")

            Game.world.music:fade(0, 0.25)

            lancer:setFacing("right")
            cutscene:wait(0.5)
            lancer:setFacing("down")

            lancer.alert_icon = Sprite("effects/alert", lancer.sprite.width/2)
            lancer.alert_icon:setOrigin(0.5, 1)
            lancer.alert_icon.layer = 100
            lancer:addChild(lancer.alert_icon)
            Game.world.timer:after(0.8, function()
                lancer.alert_icon:remove()
            end)

            cutscene:wait(1)
            local lancer_theme = Music("deltarune/lancer", 0.8, 1)

            cutscene:text("* Susie!!", "smile_tongue", "lancer")
            cutscene:text("* Lancer!", "surprise_smile", "susie")

            cutscene:wait(cutscene:walkTo(susie, susie.x, 300, 0.4))
            cutscene:wait(cutscene:walkTo(susie, 400, susie.y, 0.25))
            cutscene:wait(cutscene:walkTo(susie, susie.x, 236, 0.2))

            susie:setFacing("left")
            lancer:setFacing("right")

            susie.visible = false
            lancer:setAnimation("highfive")

            cutscene:wait(0.2)
            Assets.playSound("jump")
            cutscene:wait(0.3)
            Assets.playSound("whip_hard")
            cutscene:wait(0.5)
            Assets.playSound("lancerlaugh")
            cutscene:wait(2)

            cutscene:text("* Great to see you again, dude!", "sincere_smile", "susie")
            cutscene:text("* But,[wait:2] uh,[wait:5] how'd you end up here?", "nervous", "susie")
			
            susie.visible = true
            lancer:setSprite("walk")
            lancer:setFacing("right")

            cutscene:text("* I actually don't know!", "tongue_b", "lancer")
            cutscene:text("* There I was,[wait:5] residing in Kris' Spacious Pants Hole...[react:1]", "handsome", "lancer", {reactions={
                {"Uhhh, pocket.", "rightmid", "bottom", "nervous_side", "susie"}
            }})
            cutscene:text("* When all of a sudden,[wait:5] I fell out and somehow ended up here!", "tongue_b", "lancer")
            cutscene:text("* Speaking of them,[wait:2] where DID those clowns run off too?", "confused_b", "lancer")
            cutscene:text("* Aren't they usually with you?", "confused_b", "lancer")

            susie:setSprite("away_scratch")

            cutscene:text("* Yeah...[wait:5] they, uh,[wait:2] kinda vanished on me, heh.", "nervous_side", "susie")
            cutscene:text("* Not really sure where they are either.", "nervous", "susie")
			
            susie:setSprite("walk")
            susie:setFacing("left")

            lancer:setFacing("down")
            cutscene:wait(2)

            cutscene:text("* Say[speed:0.5]...[wait:5]\n[speed:1]* Who are those guys over there?", "tongue_c", "lancer")

            susie:setFacing("down")

            susie:resetSprite()
            lancer:resetSprite()
            lancer_theme:stop()
            Game.world.music:fade(1, 0.5)

            cutscene:text("* NOTE:[wait:10] This cutscene is a very big WIP,[wait:5] so there's obviously gonna be some bugs.")
            cutscene:text("* But for now, I'll just give you Lancer so the Bean mechanic has a purpose.")

            lancer:remove()
            Game.inventory:tryGiveItem("lancer")
            Assets.playSound("item")
            Game:setFlag("hasObtainedLancer", true)
            cutscene:wait(1)
			
            cutscene:text("* Stay tuned for the finished cutscene.[wait:10]\n- J.A.R.U.")

            cutscene:interpolateFollowers()
            cutscene:attachFollowers()
        end
    end,
}