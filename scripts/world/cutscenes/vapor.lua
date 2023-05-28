return {
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
}