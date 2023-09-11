return {
    fommt = function(cutscene, event)
        if not Game:getFlag("fommt_save") then
            cutscene:showNametag("Fommt")
            cutscene:text("* Hee hee hee...[wait:5]\n* Shall I help you SAVE?")
            cutscene:text("* I have enough power to let you SAVE at least once!")
            cutscene:hideNametag()
            cutscene:text("* (Would you like to SAVE?)")
            if cutscene:choicer({"Save", "Do Not"}) == 1 then
                Game.world.music:fade(0, 0.5)
                cutscene:wait(1)
                Assets.playSound("save")

                cutscene:wait(0.5)
                Game:saveQuick(Game.world.player:getPosition())
                cutscene:text("* You saved your game.[wait:2].[wait:2].[wait:5]somehow.")

                Game.world.music:fade(1, 0.5)
                cutscene:showNametag("Fommt")
                cutscene:text("* Hee hee hee!")
                cutscene:hideNametag()
				
                Game:setFlag("fommt_save", true)
            end
        else
            cutscene:showNametag("Fommt")
            cutscene:text("* Hee hee hee!")
            cutscene:hideNametag()
        end
    end,
    bb = function(cutscene, event)
        cutscene:playSound(Utils.pick({
            "bb_hi",
            "bb_hello",
            "bb_laugh"
        }))
        cutscene:text("[voice:nil]* HELLO FRIEND[wait:5]\n* WOULD YOU LIKE TO BUY SOME WARES", "90sbb/default")
        if cutscene:choicer({"Yes", "HELL NO"}) == 1 then
        else
            cutscene:playSound("bb_laugh")
            cutscene:text("[voice:nil]* FUCK YOU", "90sbb/default")
        end
    end,
    snick = function(cutscene, event)
        if not event.interacted then
            cutscene:showNametag("Snick")
            cutscene:text("* Oh hey,[wait:2] it's you!")
                if Game:hasPartyMember("YOU") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* Wait,[wait:2] you know YOU?", "surprise", "susie")
                    cutscene:showNametag("Snick")
                    cutscene:text("* Nah,[wait:2] I wasn't referring to your froggy companion.")
                    cutscene:text("* I was referring to [color:yellow]YOU![color:reset][wait:5]\n* The player!")
                    cutscene:showNametag("Susie")
                    cutscene:text('* Uh[speed:0.2]...[speed:1]what?[wait:5]\n* Who the hell is "The Player"?', "suspicious", "susie")
                    cutscene:showNametag("Snick")
                    cutscene:text("* (I would just roll with it, if I were you...)")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Okay...[wait:5] whatever.", "nervous_side", "susie")
                    cutscene:showNametag("Snick")
                else
                    cutscene:text("* (Didn't think anyone else would show up here other than me, to be honest.)")
                end
            cutscene:text("* Anyways, welcome to my shack.")
            cutscene:text("* Here you can play some of the cool games that I set up...")
            cutscene:text("* ...is what I would say if the games were actually finished.")
            cutscene:text("* Yeah, sorry my dude.[wait:5]\n* Game development takes a lot of time,[wait:2] y'know?")
            cutscene:text("* However, I'll tell you that if you beat the games when they finish development...")
            cutscene:text("* I may be able to join your party.")
            cutscene:hideNametag()
            event.interacted = true
        else
            cutscene:showNametag("Susie")
            cutscene:text("* Are you aware that the sign outside has the wrong year on it?", "neutral", "susie")
            cutscene:showNametag("Snick")
            cutscene:text("* Yeah,[wait:2] I know.[wait:5]\n* I just didn't bother to change it.")
            cutscene:text("* Saves enough budget for the games,[wait:2] y'know?")
            cutscene:hideNametag()
        end
    end,
    ---@param cutscene WorldCutscene
    rook = function(cutscene, event)
        --local rook = cutscene:getCharacter("rook")
        local nodeface = NodeFace()

        cutscene:showNametag("Rook")
        cutscene:text("* Well,[wait:5] LOOK who it iz...", "lookback", "rook")
        cutscene:text("* If it izn't the LIGHTNERZ!", "browraise", "rook")
        cutscene:text("* Been a while,[wait:5] hazn't it, Amigooze?", "smug", "rook")

        cutscene:showNametag("Susie")
        cutscene:text("* ...", "suspicious", "susie")
        cutscene:text("* Uh,[wait:3] I'm sorry, but who the hell are you?", "sus_nervous", "susie")

        cutscene:showNametag("Rook")
        cutscene:text("* WHO AM I?!", "browraise", "rook")
        cutscene:text("* C'mon DAWG, don't act like you don't know me!", "smug", "rook")
        cutscene:text("* We were bout to have a FIGHT and everything!![react:1]", "grin", "rook", {
            reactions = {
                {"At leazt until SHE showed up...", "mid", "bottom", "frown", "rook"}
            },
        })
        cutscene:text("* Izn't that right, No-Goze and Done-zo?", "smug", "rook")

        cutscene:showNametag("NG & DZ")
        cutscene:text("[func:nodeface,dz,-8,32] Mhm[wait:10]\n[func:nodeface,ng,-5,32] Can't say it better, Bossman!!",
        {
            functions = {
                nodeface = nodeface,
            }
        })

        cutscene:hideNametag()
	end,
    addisonsoda = function(cutscene, event)
        local skp = cutscene:getCharacter("addisonsoda")
        local skp_name = Mod:addiSwitch() and "Fizz" or "Yellow Addison"

        if Mod:addiSwitch() and Game:getFlag("about_fizz") and Game:getFlag("asked_fizz", false) == false and event.interact_count == 1 then
            cutscene:showNametag(skp_name)
            cutscene:text("* Hey there! You look like you need a refreshment!", "default", skp)
            cutscene:text("* Would you like a taste of Synthsoda?", "default", skp)
            cutscene:hideNametag()
            cutscene:wait(0.5)
            cutscene:showNametag(skp_name)
            cutscene:text("* Oh you wanna talk about the little dude, huh?", "default", skp)
            cutscene:text("* He's cool! A small guy with BIG dreams!", "wink", skp)
            cutscene:text("* I'll catch him later, gonna surprise him with some sweet soda!", "smile", skp)
            cutscene:hideNametag()

            Game:setFlag("asked_fizz", true)
        elseif not Mod:addiSwitch() and Game:getFlag("about_fizz") and Game:getFlag("asked_fizz", false) == false and event.interact_count == 1 then
            cutscene:showNametag(skp_name)
            cutscene:text("* Spamton? ... Don't know him!", "default", skp)
            cutscene:hideNametag()
        else
            cutscene:showNametag(skp_name)
            cutscene:text("* SynthSoda at half price! Now at 100D$", "smile", skp)
            cutscene:text("* Hey there! You look like you need a refreshment!", "default", skp)
            cutscene:text("* Would you like a taste of Synthsoda?", "default", skp)
            cutscene:hideNametag()

            cutscene:text("* (Buy SynthSoda for 100D$?)")
            cutscene:showShop()
            local choice = cutscene:choicer({ "Buy", "Don't Buy" })
            cutscene:hideShop()

            if choice == 1 then
                if Game.money < 100 then
                    cutscene:showNametag(skp_name)
                    cutscene:text("* Even with a discount, you still don't have enough...", "pissed_b", skp)
                    cutscene:hideNametag()
                elseif not Game.inventory:addItem("synthsoda") then
                    cutscene:showNametag(skp_name)
                    cutscene:text("* Come back when you got space in your pockets...", "pissed", skp)
                    cutscene:hideNametag()
                    return
                else
                Game.money = Game.money - 100
                cutscene:playSound("locker")

                cutscene:showNametag(skp_name)
                cutscene:text("* Happy to give you this special offer!", "wink", skp)
                cutscene:text("* Come back if you want more!", "wink", skp)
                cutscene:hideNametag()
                end
            end

            if choice == 2 then
                cutscene:showNametag(skp_name)
                cutscene:text("* Is that so? Okay then!", "default", skp)
                cutscene:text("* I'll still be here if you change your mind!", "smile", skp)
                cutscene:text("* That's until we sold out...", "pissed", skp)
                cutscene:hideNametag()
            end
        end
    end,
}