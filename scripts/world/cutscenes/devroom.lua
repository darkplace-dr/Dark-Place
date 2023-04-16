return {
    brandon = function(cutscene, event)
        if not Game:getFlag("brandon_talkedto") then
            if cutscene:getCharacter("kris") then
                cutscene:showNametag("Brandon")
                cutscene:text("* Well,[wait:5] if it isn't Kris Deltarune themself.", "happy", "brandon")

                cutscene:showNametag("Susie")
                cutscene:text("* Okay,[wait:5] first of all,[wait:5] that isn't their last name.", "annoyed", "susie")
                cutscene:text("* Second of all,[wait:5] how the hell do you know their name?", "sus_nervous", "susie")

                cutscene:showNametag("Brandon")
                cutscene:text("* Eh,[wait:5] that isn't really important.", "happy", "brandon")
                cutscene:text("* Anyways...", "neutral", "brandon")
            end
            cutscene:text("* It's so cool that you guys showed up here.", "happy", "brandon")
            if cutscene:getCharacter("dess") then
                cutscene:text("* ... Minus one of you...", "miffed", "brandon")

                cutscene:showNametag("Dess")
                cutscene:text("* Gee I wonder who that could be lol", "condescending", "dess")
            end

            cutscene:showNametag("Brandon")
            cutscene:text("* Hey,[wait:5] could I join the party?", "happy", "brandon")
            cutscene:hideNametag()
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* So,[wait:5] did you change your mind?", "happy", "brandon")
            cutscene:hideNametag()
        end

        if cutscene:choicer({"Yes", "No"}) == 1 then
            cutscene:showNametag("Brandon")
            cutscene:text("* Nice,[wait:5] thanks!", "happy", "brandon")
            cutscene:hideNametag()

            Game:addPartyMember("brandon")
            event:convertToFollower()
            cutscene:attachFollowers()

            cutscene:text("* Brandon joined the party.")

            Game:setFlag("brandon_inparty", true)
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Ah,[wait:5] okay then.", "frown", "brandon")
            cutscene:text("* Well,[wait:5] I'm always here if you change your mind.", "happy", "brandon")
            cutscene:hideNametag()

            Game:setFlag("brandon_talkedto", true)
        end
    end,

	velvet = function(cutscene, velvet)
        local susie = cutscene:getCharacter("susie")
        local has_special_interaction = susie

        if velvet.interact_count == 1 then
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "looking_down", "velvet")
            cutscene:hideNametag()

            cutscene:wait(1)

            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* ...?", "default", "velvet")
            cutscene:text("* Sup!", "pissed_b", "velvet")
            cutscene:hideNametag()
        elseif velvet.interact_count == 2 then
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "looking_down", "velvet")
            cutscene:hideNametag()

            cutscene:wait(1)

            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* ...", "default", "velvet")
            velvet:setAnimation("pissed_talk")
            cutscene:text("* How can I help?", "default", "velvet")
            cutscene:hideNametag()

            if susie then
                velvet:setAnimation("phone_look_up")

                cutscene:showNametag("Susie")
                cutscene:text("* Dunno... you just look like a Maus.", "neutral", "susie")
                cutscene:text("* Except all depressed and gray-looking.", "nervous", "susie")
                cutscene:hideNametag()

                cutscene:showNametag("Velvet")
                cutscene:text("* .....", "surprised", "velvet")
                velvet:setAnimation("pissed_talk")
                cutscene:text("* Okay then?", "surprised_b", "velvet")
                cutscene:hideNametag()
            end
        elseif velvet.interact_count == 3 or not has_special_interaction then
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* What?", "pissed", "velvet")
            cutscene:hideNametag()

            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* Stop looking at your phone!", "annoyed", "susie")
                cutscene:hideNametag()

                velvet:setAnimation("pissed_talk")
                cutscene:showNametag("Velvet")
                cutscene:text("* So?", "pissed", "velvet")
                cutscene:text("* I get to decide if I want to ignore people...", "pissed_b", "velvet")
                cutscene:text("* That includes rude purple dinosaurs!", "smile_b", "velvet")
                cutscene:hideNametag()

                cutscene:showNametag("Susie")
                cutscene:text("* ...... ", "shy_b", "susie")
                cutscene:text("* Geez that rat is feisty...", "shy_b", "susie")
                cutscene:hideNametag()
            end
        elseif susie then
            if velvet.interact_count == 4 then
                cutscene:showNametag("Susie")
                cutscene:text("* Hey YOU watch this...\n * This is gonna make her talk for sure!", "smile", "susie")
                cutscene:text("* You're the one who gave Spamton a blanket, right?", "sincere_smile", "susie")
                cutscene:hideNametag()

                velvet:setAnimation("smile_look_up")
                cutscene:showNametag("Velvet")
                cutscene:text("* !!!", "shock", "velvet")
                velvet:setAnimation("smile_talk")
                cutscene:text("* Did I hear that right?\n * You said Spamton with a blanket?", "surprised_b", "velvet")
                cutscene:hideNametag()
                velvet:setAnimation("smile_look_up")

                cutscene:showNametag("Susie")
                cutscene:text("* Absolutely! Is that really you?", "sincere_smile", "susie")
                cutscene:hideNametag()

                velvet:setAnimation("smile_no_phone")
                cutscene:showNametag("Velvet")
                cutscene:text("* Glad you asked! I am the creator!", "smile_b", "velvet")
                cutscene:text("* Wanna hear more about him?", "smile", "velvet")
                cutscene:hideNametag()
                velvet:setAnimation("idle_smile_no_phone")

                cutscene:showNametag("Susie")
                cutscene:text("* ......", "sus_nervous", "susie")
                cutscene:text("* Actually, nevermind. I don't wanna hear it...", "nervous", "susie")
                cutscene:hideNametag()

                cutscene:showNametag("Velvet")
                velvet:setAnimation("smile_no_phone")
                cutscene:text("* Oh it's fine... No hard feelings!", "smile_b", "velvet")
                velvet:setAnimation("pissed_no_phone")
                cutscene:text("* After all... I don't talk to mean purple lizards...", "pissed_b", "velvet")
                velvet:setAnimation("idle_pissed_no_phone")
                cutscene:hideNametag()

                cutscene:showNametag("Susie")
                cutscene:text("* ...... ", "surprise", "susie")
                cutscene:text("* What did I even say? ", "surprise_frown", "susie")
                cutscene:hideNametag()
            elseif velvet.interact_count == 5 then
                cutscene:showNametag("Susie")
                cutscene:text("* Hey if you're a Maus, can you squeak?", "nervous_side", "susie")
                cutscene:hideNametag()

                velvet:setAnimation("phone_look_up")
                cutscene:showNametag("Velvet")
                cutscene:text("* .....", "surprised", "velvet")
                velvet:setAnimation("pissed_talk")
                cutscene:text("* Say what now?", "surprised_b", "velvet")
                cutscene:hideNametag()
                velvet:setAnimation("phone_look_up")

                cutscene:showNametag("Susie")
                cutscene:text("* If you can squeak like a Maus?", "nervous_side", "susie")
                cutscene:hideNametag()

                velvet:setAnimation("phone_look_up")
                cutscene:showNametag("Velvet")
                cutscene:text("* .....", "pissed", "velvet")
                velvet:setAnimation("pissed_talk")
                cutscene:text("* Yea no... Fat chance!", "pissed_b", "velvet")
                cutscene:hideNametag()
            elseif velvet.interact_count >= 6 and velvet.interact_count <= 9 then
                cutscene:showNametag("Susie")
                cutscene:text("* Squeak...", "smile", "susie")
                cutscene:hideNametag()

                cutscene:showNametag("Velvet")
                velvet:setAnimation("pissed_talk")
                cutscene:text("* No...", "pissed_b", "velvet")
                cutscene:hideNametag()
            elseif velvet.interact_count == 10 then
                velvet:setAnimation("phone_look_up")
                cutscene:showNametag("Velvet")
                cutscene:text("* Okay fine, you wanna to hear it so you can shut up?", "pissed", "velvet")
                cutscene:text("* Well, here it is...", "pissed_b", "velvet")
                cutscene:hideNametag()

                Game.world.music:pause()
                cutscene:wait(2.5)

                cutscene:showNametag("Velvet")
                cutscene:text("[voice:nil][func:sound]* Squeak!", "smile_b", "velvet", {
                    functions = {
                        sound = function()
                            Assets.stopAndPlaySound("velvetsqueak")
                        end
                    }
                })
                cutscene:hideNametag()

                cutscene:wait(1)

                cutscene:showNametag("Velvet")
                cutscene:text("* There I squeaked!\n * Never going to do that again!", "default", "velvet")
                cutscene:hideNametag()

                Game.world.music:resume()

                Kristal.callEvent("completeAchievement", "velvetsqueak")
            else
                velvet:setAnimation("phone_look_up")
                cutscene:showNametag("Velvet")
                cutscene:text("* Stop bothering me...\n * I squeaked once and I am not gonna do it again!", "pissed_b", "velvet")
                cutscene:hideNametag()
            end
        end

        velvet:resetSprite()
    end,

    wardrobe = function(cutscene, event)
        cutscene:text("* (It's a wardrobe.)\n* (What drawer would you like to open?)")

        local menu = cutscene:choicer({ "Party", "Costumes" })
        if menu == 1 then
            cutscene:after(function()
                Game.world:openMenu(Costumes())
            end)
        end
    end,

	dumbie = function(cutscene, event)
        cutscene:showNametag("Dummy?")
        cutscene:text("* I'm a Dummy", "fear", "dumbie")

	    cutscene:showNametag("Susie")
		cutscene:text("* Uhm, no you're not?", "sus_nervous", "susie")

	    cutscene:showNametag("Dumbie")
		cutscene:text("* Well, your mom didn't say that!", "angryforward", "dumbie")
		cutscene:text("* ...", "confused", "dumbie")
		cutscene:text("* I'm a Dummy", "fear", "dumbie")
	    cutscene:hideNametag()
    end
}
