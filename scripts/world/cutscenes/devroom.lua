return {
	velvet = function(cutscene, event)
        if event.interact_count == 1 then
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "looking_down", "velvet")
            cutscene:hideNametag()
            cutscene:wait(1)
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* ...?", "default", "velvet")
            cutscene:setSpeaker(velvet)
            cutscene:text("* Sup!", "pissed_b", "velvet")
            cutscene:hideNametag()
            velvet:resetSprite()
        
        elseif event.interact_count == 2 then
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "looking_down", "velvet")
            cutscene:hideNametag()
            cutscene:wait(1)
            velvet:setAnimation("phone_look_up")
            cutscene:wait(1)
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:showNametag("Velvet")
            cutscene:text("* How can I help?", "default", "velvet")
            velvet:setAnimation("phone_look_up")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Dunno... you just look like a Maus.", "neutral")
                cutscene:text("* Except all depressed and gray-looking.", "nervous")
                cutscene:hideNametag()
            end

            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "surprised", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* Okay then?", "surprised_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 3 then
            local velvet = cutscene:getCharacter("velvet")
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* What?", "pissed", "velvet")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Stop looking at your phone!", "annoyed")
                cutscene:hideNametag()
            end

            cutscene:showNametag("Velvet")
            velvet:setAnimation("pissed_talk")
            cutscene:setSpeaker(velvet)
            cutscene:text("* So?", "pissed", "velvet")
            cutscene:text("* I get to decide if I want to ignore people...", "pissed_b", "velvet")
            cutscene:text("* That includes rude purple dinosaurs!", "smile_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* ...... ", "shy_b")
                cutscene:text("* Geez that rat is feisty...", "shy_b")
                cutscene:hideNametag()
            end

        elseif event.interact_count == 4 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Hey YOU watch this...\n * This is gonna make her talk for sure!", "smile")
                cutscene:text("* You're the one who gave Spamton a blanket, right?", "sincere_smile")
                cutscene:hideNametag()
            end
            
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            velvet:setAnimation("smile_look_up")
            cutscene:text("* !!!", "shock", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("smile_talk")
            cutscene:text("* Did I hear that right?\n * You said Spamton with a blanket?", "surprised_b", "velvet")
            velvet:setAnimation("smile_look_up")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Absolutely! Is that really you?", "sincere_smile")
                cutscene:hideNametag()
            end
           
            velvet:setAnimation("smile_no_phone")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            cutscene:text("* Glad you asked! I am the creator!", "smile_b", "velvet")
            cutscene:text("* Wanna hear more about him?", "smile", "velvet")
            velvet:setAnimation("idle_smile_no_phone")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* ......", "sus_nervous")
                cutscene:text("* Actually, nevermind. I don't wanna hear it...", "nervous")
                cutscene:hideNametag()
            end

            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("smile_no_phone")
            cutscene:text("* Oh it's fine... No hard feelings!", "smile_b", "velvet")
            velvet:setAnimation("pissed_no_phone")
            cutscene:text("* After all... I don't talk to mean purple lizards...", "pissed_b", "velvet")
            cutscene:hideNametag()
            velvet:setAnimation("idle_pissed_no_phone")

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* ...... ", "surprise")
                cutscene:text("* What did I even say? ", "surprise_frown")
                cutscene:hideNametag()
            end

            velvet:resetSprite()

        elseif event.interact_count == 5 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Hey if you're a Maus, can you squeak?", "nervous_side")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "surprised", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* Say what now?", "surprised_b", "velvet")
            cutscene:hideNametag()
            velvet:setAnimation("phone_look_up")

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* If you can squeak like a Maus?", "nervous_side")
                cutscene:hideNametag()
            end

            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "pissed", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* Yea no... Fat chance!", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 6 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()


        elseif event.interact_count == 6 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 7 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 8 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 9 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 10 then
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* Okay fine, you wanna to hear it so you can shut up?", "pissed", "velvet")
            cutscene:text("* Well, here it is...", "pissed_b", "velvet")
            cutscene:hideNametag()

            Game.world.music:pause()
            cutscene:wait(2.5)
            Assets.playSound("velvetsqueak")
            cutscene:setSpeaker(default)
            cutscene:showNametag("Velvet")
            cutscene:text("* Squeak!", "smile_b", "velvet")
            cutscene:hideNametag()

            cutscene:wait(1)

            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            cutscene:text("* There I squeaked!\n * Never going to do that again!", "default", "velvet")
            cutscene:hideNametag()

            velvet:resetSprite()
            Game.world.music:resume()

            if not Mod:hasAch("velvetsqueak") then
                Kristal.callEvent("completeAchievement", "velvetsqueak")
            end

        else
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* Stop bothering me...\n * I squeaked once and I am not gonna do it again!", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()
	    end
    end,
}