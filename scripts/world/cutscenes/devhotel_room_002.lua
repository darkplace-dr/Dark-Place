return {
    entry = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")

        if susie then
            cutscene:wait(1)

            cutscene:showNametag("Susie")
            cutscene:text("[voice:susie]* Huh... Guess we fit after all", "surprise_smile", "susie")
            cutscene:hideNametag()
        end

        Game:setFlag("enter_velvet_room", true)
    end,

    transition = function(cutscene, event)
        Game.world:mapTransition("devhotel1", "door_002")
    end,

    corgi = function(cutscene, event)
        local corgi = cutscene:getCharacter("corgi")
        local susie = cutscene:getCharacter("susie")
        local noelle = cutscene:getCharacter("noelle")

        if not Game:getFlag("corgi_friend") then
            cutscene:text("* It's a sleeping dog!")
            cutscene:text("* Do you want to wake the dog up?")

            local opinion = cutscene:choicer({"Yes", "No"})
            if opinion == 1 then
                cutscene:text("* You attempt to wake the dog up")

                corgi:setSprite("awake")
                Assets.playSound("noise")
                cutscene:wait(1)
                cutscene:text("* You woke up the dog!")

                corgi:setSprite("awake_bark")
                Assets.playSound("dog_yip")
                cutscene:wait(0.3)
                corgi:setSprite("awake")

                cutscene:wait(1)
                corgi:shake(2)
                corgi:setSprite("sleepy_sit")
                Assets.playSound("wing")

                cutscene:wait(1)
                if susie then
                    cutscene:showNametag("Susie")
                    cutscene:text("* I don't think playing with a dog isn't worth our time...", "nervous_side", "susie")

                    if noelle then
                        cutscene:showNametag("Noelle")
                        cutscene:text("* Come on! Admit it, playing with dogs are worht it!", "blush_finger", "noelle")
                    end
                    cutscene:hideNametag()
                end

                if noelle then
                    cutscene:showNametag("Noelle")
                    cutscene:text("* Aren't you just adorable!", "smile_closed", "noelle")
                    cutscene:hideNametag()
                end

                cutscene:text("* The dog seems to be interested in you!")

                corgi:setSprite("bark_2")
                Assets.playSound("dog_yip")
                cutscene:wait(0.2)
                corgi:setSprite("bark_1")
                cutscene:wait(0.4)
                corgi:setSprite("bark_2")
                Assets.playSound("dog_yip")
                cutscene:wait(0.4)
                corgi:setSprite("bark_1")

                cutscene:wait(1)

                Assets.playSound("mercyadd")
                cutscene:text("* You befriended the dog!")
                

                cutscene:wait(1)

                corgi:setSprite("sleepy_sit")
                Assets.playSound("noise")
                corgi:shake(2)
                cutscene:text("* But this dog is sleepy!\n* So you let it sleep...")

                Assets.playSound("wing")
                corgi:resetSprite()

                Kristal.callEvent("completeAchievement", "corgi")
                Game:setFlag("corgi_friend", true)
            else
                cutscene:text("* You remain silent...")
            end
        else
            cutscene:text("* It's a sleeping dog!")

            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* Hey hold on a sec. Isn't that the dog from the pasta shop?", "surprise", "susie")
                cutscene:text("* What's it doing out of the shop?", "surprise_frown", "susie")
                cutscene:text("* Better not question that...", "nervous", "susie")
                cutscene:hideNametag()
            end
        end
    end,
}