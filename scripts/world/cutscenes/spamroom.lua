return {
    amogus = function(cutscene, sus)
        if sus.interact_count == 1 then
            sus:setAnimation("dead")
            Assets.playSound("amoguskill", 0.7, 1)
        else
            cutscene:text("* Spamongus was the imposter.")
        end
    end,
    mandela = function(cutscene, event)
        cutscene:showNametag("Alternate Spamton")
        cutscene:text("* REMEMB3R TO FOLLOW THE [T.H.I.N.K] PRINCIPLE, YOU [Little Sponge]!!", "", "alternatespam")
        cutscene:hideNametag()
    end,
    soapton = function(cutscene, event)
        cutscene:text("* There's a tagline written on the soap bar here...")
        cutscene:text("* SPAMTON [Rank A] CLEANING SOAP\n* PERFECT FOR WASHING YOUR [Sorry @$$] AWAY!!")
    end,
    poster = function(cutscene, event)
        cutscene:text("* (The poster is torn,[wait:5] revealing\na faded one underneath.)")
        cutscene:text("* BIG SHOT AUTOS![wait:5] TAKE A RIDE\nAROUND TOWN IN OUR SPECIAL")
        cutscene:text("* (The rest is cut off.)")
    end,
    mari = function(cutscene, event)
        cutscene:showNametag("Mariton")
        cutscene:text("* HEY [wait:5][wave]EVERY~", "", "marispam")
        cutscene:text("* WAITING FOR [wave]SOMETHING[wave:0] TO HAPPEN?", "", "marispam")
        cutscene:hideNametag()
    end,
    mosquito = function(cutscene, event)
        cutscene:showNametag("Spamton Mosquito")
        cutscene:text("* EVER WANTED TO JUST RELAX FOR THE [[Hot Summer Deals]]?", "", "spam_mosquito")
        cutscene:text("* BUT ALL THE DAMN [bugs] ARE IN THE WAY?", "", "spam_mosquito")
        cutscene:text("* WE GOT YOU COVERED WITH THE NEW [[Hyperlink Blocked]]!", "", "spam_mosquito")
        cutscene:text("* [currently not in stock].", "", "spam_mosquito")
        cutscene:hideNametag()
    end,
    cungadero = function(cutscene, event)
        cutscene:showNametag("Cungadero Spamton")
        cutscene:text("* Take a ride around town on our special Cungadero!", "", "cungaderospamton")
        event:setSprite("smile")
        cutscene:text("* Hey everybody![wait:10]\n* It's me!", "", "cungaderospamton")
        event:setSprite("wink")
        cutscene:text("* Everybody's favorite salseman,[wait:5] Spamton G. Spamton!", "", "cungaderospamton")
        event:setSprite("neutral")
        if cutscene:getCharacter("jamm") then
            cutscene:showNametag("Jamm")
            cutscene:text("* (Which one are you talking about?)", "neutral", "jamm")
        end
        if cutscene:getCharacter("susie") then
            cutscene:showNametag("Susie")
            cutscene:text("* Uh,[wait:5] why is your car parked on the sidewalk?", "neutral", "susie")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("wink")
            cutscene:text("* Why,[wait:5] to show it off,[wait:5] of course!", "", "cungaderospamton")
            event:setSprite("neutral")
            cutscene:text("* I would of gotten here sooner if I hadn't got into traffic.", "", "cungaderospamton")
            event:setSprite("angry")
            cutscene:text("* WHY WAS I STUCK IN TRAFFIC?![wait:10]\n* DON'T THEY KNOW?[wait:10]\n* DON'T THEY KNOW WHO I AM?!", "", "cungaderospamton")
            event:setSprite("sideeye")
            cutscene:text("[noskip][speed:0.3]* ...", "", "cungaderospamton")
            event:setSprite("wink")
            cutscene:text("* Spamton G. Spamton,[wait:5] that's who I am!", "", "cungaderospamton")
            event:setSprite("rage")
            cutscene:text("* AAAAAAAAAARGH!!!", "", "cungaderospamton")
            event:setSprite("neutral")
        end
        if cutscene:getCharacter("dess") then
            cutscene:showNametag("Dess")
            cutscene:text("* yooooo is that the uhhhhh big shot guy????", "neutral", "dess")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("wink")
            cutscene:text("* Ah,[wait:5] a loyal fan I see.", "", "cungaderospamton")
            cutscene:showNametag("Dess")
            cutscene:text("* who said I actually liked you lmfao", "condescending", "dess")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("shock")
            cutscene:text("[noskip][speed:0.3]* ...", "", "cungaderospamton")
            event:setSprite("neutral")
        end
        if cutscene:getCharacter("brandon") then
            cutscene:showNametag("Brandon")
            cutscene:text("* Woah,[wait:5] it's sureal seeing you before you lost your marbles.", "neutral", "brandon")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("shock")
            cutscene:text("* Uh...[wait:10] what?", "", "cungaderospamton")
            cutscene:showNametag("Brandon")
            cutscene:text("* Oh,[wait:5] nothing,[wait:5] nothing!", "blush", "brandon")
            event:setSprite("neutral")
        end
        event:setSprite("happy")
        cutscene:hideNametag()
    end,
    velvetspam = function(cutscene, event)
        if Mod:isNight() then
            if Game:getFlag("blankie_returned") then
                local velvetspam = cutscene:getCharacter("velvetspam")
                cutscene:setSpeaker(velvetspam)
                cutscene:showNametag("Velvet!Spamton")
                cutscene:text("* You know the best part of [Restless Sleepless Nights]?")
                cutscene:text("* Is having my [specil] Blankie [TM] on top!")
                cutscene:text("* Nothing! And I mean NOTHING! Can [[BATTERIES NEED REPLACEMENT]]!")
                cutscene:hideNametag()
            else
                local velvetspam = cutscene:getCharacter("velvetspam")
                cutscene:setSpeaker(velvetspam)
                cutscene:showNametag("Velvet!Spamton")
                cutscene:text("* Noticed anything [[Different from the Leading Brand!]]?")
                cutscene:text("* Well that difference is that I don't have my [specil] Blankie [TM] with me!")
                cutscene:hideNametag()
            end
        else
            local noelle = cutscene:getCharacter("noelle")
            local velvetspam = cutscene:getCharacter("velvetspam")
            if Game:getFlag("blankie_returned") then
                local rnd = math.random(1, 5)
                    if rnd == 1 then
                        if Game:getFlag("asked_java", false) then
                            cutscene:setSpeaker(velvetspam)
                            cutscene:showNametag("Velvet!Spamton")
                            velvetspam:setSprite("curious")
                            cutscene:text("* Look at you! Just had some [Hot Brewed Tea]!")
                            cutscene:text("* Told you [[Free Java Coding Lessons]] makes great tea!")
                            velvetspam:resetSprite()
                            cutscene:hideNametag()
                        else
                            cutscene:setSpeaker(velvetspam)
                            cutscene:showNametag("Velvet!Spamton")
                            velvetspam:setSprite("curious")
                            cutscene:text("* Have you met [HOT JAVA LAVA] yet?")
                            cutscene:text("* You should grab some [[Hot Dealz]] tea! All personalized!")
                            velvetspam:resetSprite()
                            cutscene:hideNametag()

                            Game:setFlag("about_java", true)
                        end
                    elseif rnd == 2 then
                        cutscene:setSpeaker(velvetspam)
                        cutscene:showNametag("Velvet!Spamton")
                        velvetspam:setSprite("curious")
                        cutscene:text("* Hey! [CLICK THE BLUE LINK] has some sweet shoes somewhere!")
                        cutscene:text("* Don't forget to try some [[Free Samples!]]")
                        velvetspam:resetSprite()
                        cutscene:hideNametag()

                        Game:setFlag("about_click", true)
                    elseif rnd == 3 then
                        cutscene:setSpeaker(velvetspam)
                        cutscene:showNametag("Velvet!Spamton")
                        velvetspam:setSprite("curious")
                        cutscene:text("* Did you know [[Press the Button]] made this suit for me?")
                        cutscene:text("* He put all his [blood and tears] into this!")
                        velvetspam:resetSprite()
                        cutscene:hideNametag()

                        Game:setFlag("about_button", true)
                    elseif rnd == 4 then
                        if Game:getFlag("asked_fizz", false) then
                            cutscene:setSpeaker(velvetspam)
                            cutscene:showNametag("Velvet!Spamton")
                            velvetspam:setSprite("curious")
                            cutscene:text("* WOW! Lookin like a [Energetic Sports Drink]!")
                            cutscene:text("* See? [[Bubbly Fizz]] has all the flavors!")
                            velvetspam:resetSprite()
                            cutscene:hideNametag()
                        else
                            cutscene:setSpeaker(velvetspam)
                            cutscene:showNametag("Velvet!Spamton")
                            velvetspam:setSprite("curious")
                            cutscene:text("* You look like a [dried raisin]...")
                            cutscene:text("* Don't worry! [[Fizzy Lemon Soda]] has got some refreshments!")
                            velvetspam:resetSprite()
                            cutscene:hideNametag()

                            Game:setFlag("about_fizz", true)
                        end
                    else
                        if noelle then
                            if noelle.facing == "left" then
                                noelle:setSprite("walk_happy/left_1")
                            elseif noelle.facing == "right" then
                                noelle:setSprite("walk_happy/right_1")
                            else
                                noelle:setSprite("walk_happy/down_1")
                            end

                            cutscene:setSpeaker(noelle)
                            cutscene:showNametag("Noelle")
                            cutscene:text("* Spamton! Is that you?!", "smile_closed", "noelle")

                            cutscene:setSpeaker(velvetspam)
                            cutscene:showNametag("Velvet!Spamton")
                            velvetspam:setSprite("curious")
                            cutscene:text("* Is that [holidaygirl1225]?!\n* How are ya, pal?")
                            
                            cutscene:setSpeaker(noelle)
                            cutscene:showNametag("Noelle")
                            velvetspam:setAnimation("laugh")
                            cutscene:text("* I am doing so great!", "smile_closed", "noelle")
                            cutscene:text("* I have so much to tell you!", "smile", "noelle")
                            cutscene:text("* Now that I'm here, you wanna chat a bit?", "smile", "noelle")
                            cutscene:hideNametag()

                            cutscene:setSpeaker(velvetspam)
                            cutscene:showNametag("Velvet!Spamton")
                            velvetspam:setSprite("curious")
                            cutscene:text("* Of course!\n* We can [[Chat Not Available]] for days!")

                                if cutscene:getCharacter("susie") then
                                    cutscene:showNametag("Susie")
                                    cutscene:text("* Great... Now we have to listen to you guys ramble...", "annoyed", "susie")
                                    cutscene:hideNametag()

                                    velvetspam:shake(2)
                                    noelle:shake(2)
                                    Assets.playSound("wing")
                                    velvetspam:setSprite("curious_angry")
                                    noelle:setSprite("hand_mouth_side")

                                    cutscene:wait(1.5)

                                    cutscene:setSpeaker(noelle)
                                    cutscene:showNametag("Noelle")
                                    cutscene:text("* Um. Nevermind then...", "what_smile_b", "noelle")
                                    cutscene:hideNametag()

                                    cutscene:setSpeaker(velvetspam)
                                    cutscene:showNametag("Velvet!Spamton")
                                    cutscene:text("* Of course the dinosaur has to ruin the [F.U.N. Inc.]...")

                                    cutscene:showNametag("Susie")
                                    cutscene:text("* HEY!", "teeth_b", "susie")
                                    cutscene:hideNametag()
                                end
                            noelle:resetSprite()
                        else
                        cutscene:setSpeaker(velvetspam)
                        cutscene:showNametag("Velvet!Spamton")
                        velvetspam:setSprite("curious")
                        cutscene:text("* Hey, [specil thanks] for finding my Blankie[tm]")
                        cutscene:text("* I owe you my [[GRATITUDE]]!")
                        end
                        
                        velvetspam:resetSprite()
                        cutscene:hideNametag()
                    end
                if Game:getFlag("about_java") and Game:getFlag("about_click") and Game:getFlag("about_button") and Game:getFlag("about_fizz") and Game:getFlag("addison_family", false) == false then
                    Kristal.callEvent("createQuest", "5 for 1 Specil", "vspamfamily", "Velvet!Spam told the gang about his family, but he barely mentioned about their names. Only about their jobs and what they sell. You think you can find who Velvet!Spamton is refering to?\n\nHINT: There's an option in the EXTRAS menu that can help!")
                    Game:setFlag("addison_family", true)
                end
            else
                cutscene:setSpeaker(velvetspam)
                cutscene:showNametag("Velvet!Spamton")
                velvetspam:setAnimation("talk")
                cutscene:text("* KRIS!!! So nice 2 see you! I am doing [[Easy Well-Done Beef]]!")
                velvetspam:setAnimation("idle")
                cutscene:hideNametag()

                if cutscene:getCharacter("susie") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* Actually that's not Kris\n* It's YOU...", "nervous_side", "susie")
                    cutscene:hideNametag()

                    local velvetspam = cutscene:getCharacter("velvetspam")
                    cutscene:setSpeaker(velvetspam)
                    cutscene:showNametag("Velvet!Spamton")
                    velvetspam:setAnimation("talk")
                    cutscene:text("* What do you mean it's [[Me myself and I]]?!\n * You're Kris!")
                    velvetspam:setAnimation("idle")
                    cutscene:hideNametag()

                    cutscene:showNametag("Susie")
                    cutscene:text("* Nevermind then...", "annoyed", "susie")
                    cutscene:hideNametag()
                end
                velvetspam:resetSprite()
            end
        end
    end,

    cardspam = function (cutscene, event, player)
        if player.facing == "left" then
            event.flip_x = true
        else
            event.flip_x = false
        end
        cutscene:showNametag("Spamton")
        event:setSprite("hold_cards")
        cutscene:text("* PICK A CARD,[wait:5]\nANY [Kaard].", "", "cungaderospamton")

        cutscene:hideNametag()
        cutscene:choicer({"1", "3", "2"})
        Assets.playSound("item")
        Game.world.music:fade(0, 0.1, Game.world.music:pause())
        cutscene:wait(1)
        cutscene:detachCamera()
        for _, party in ipairs(Game.party) do
            local pc = cutscene:getCharacter(party.actor.id)
            if party.actor.id == "YOU" then
            pc:setSprite("fightorflight")
            elseif party.actor.id == "susie" then
                pc:setSprite("shock_right")
            else
            pc:setSprite("battle/hurt")
            end
            if player.facing == "left" then
            pc.flip_x = true
            end
        end
        cutscene:showNametag("Spamton")
        cutscene:text("[style:GONER][voice:silent][noskip]* [instant][shake:1][func:gigatalk]WRONG[stopinstant][wait:20] [instant][func:gigatalk]CARD",  "", "cungaderospamton", {
            functions = {
                gigatalk = function ()
                    event:setSprite("laugh_1")
                    Assets.playSound("voice/gigatalk")
                    Game.world.fader:fadeIn(nil, {speed = 0.5, color = {1, 1, 1}, alpha = 1})
                    Game.world.timer:after(0.5,  function ()
                        event:setSprite("laugh_2")
                        
                    end)
                    
                end

        }})
        cutscene:hideNametag()
        cutscene:wait(2)
        for _, party in ipairs(Game.party) do
            local pc = cutscene:getCharacter(party.actor.id)
            pc:resetSprite()
            pc.flip_x = false
        end
        cutscene:attachCamera()
        event:resetSprite()
        Game.world.music:resume()
        Game.world.music:fade(1, 0.1)
    end,

    bikini = function(cutscene, event)
        local old_x = event.x
        if Game.world.player.x >= event.x and event.interact_count ~= 10 then
            event.flip_x = true
            event.x = 125
        end
        cutscene:showNametag("Bikini Spamton")
        if event.interact_count == 1 then
            cutscene:text("* HEY YOU!! DO YOU WANNA BE A [[Certified Fanservice Character]]??", nil, "spamtong")
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* What's that?", "neutral", "susie")
                cutscene:showNametag("Bikini Spamton")
                event:setSprite("arms_up")
                cutscene:text("* THE ONLY WAY TO [Heaven]!!", nil, "spamtong")
                cutscene:text("* PEOPLE WOULD GIVE ANYTHING JUST TO SEE THAT [You Have Been Terminated For Breaching TOS]!!", nil, "spamtong")
                cutscene:showNametag("Susie")
                cutscene:text("* Uh...[wait:3] Ok?", "nervous", "susie")
            end
            if cutscene:getCharacter("dess") then
                cutscene:showNametag("Dess")
                cutscene:text("* Joke's on you I'm already one.", "condescending", "dess")
                event:resetSprite()
                cutscene:showNametag("Bikini Spamton")
                cutscene:text("* OH?[wait:3] SO YOU'RE A REGULAR AT [Green Site]?", nil, "spamtong")
                cutscene:showNametag("Dess")
                cutscene:text("* Oh wait that's what you meant", "wtf", "dess")
                cutscene:text("* Well it's inevitable for us all anyway.", "genuine", "dess")
                cutscene:showNametag("Bikini Spamton")
                event:setSprite("dark")
                cutscene:text("[speed:0.9]* [You're God Damn Right.]", nil, "spamtong")
            end
            if cutscene:getCharacter("jamm") then
                if Game:getFlag("dungeonkiller") then
                    cutscene:showNametag("jamm")
                    cutscene:text("* ...Nah.", "neutral", "jamm")
                elseif Game:getFlag("jamm_closure") then
                    cutscene:showNametag("Jamm")
                    cutscene:text("* I dunno,[wait:5] man.[wait:5]\n* Bikinis aren't my style.", "neutral", "jamm")
                    event:resetSprite()
                    cutscene:showNametag("Bikini Spamton")
                    cutscene:text("* OH?[wait:3] IS A THONG MORE YOUR [Stylish!]?", nil, "spamtong")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* HELL.[wait:5] NO.", "determined", "jamm")
                else
                    cutscene:showNametag("Jamm")
                    cutscene:text("* But we didn't even do my second sidequest yet.", "neutral", "jamm")
                    cutscene:text("* I'm barely even a character at this point in the story.", "neutral", "jamm")
                    cutscene:showNametag("Bikini Spamton")
                    cutscene:text("* SINCE WHEN DO YOU [Authentication required] TO BE A MAIN CHARACTER TO [Change-up] YOUR", nil, "spamtong")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* ...Pass.", "neutral", "jamm")
                end
            end
            if cutscene:getCharacter("brandon") then
                cutscene:showNametag("Brandon")
                cutscene:text("[noskip]* O-oh,[wait:5] well I-", "owo_blush", "brandon", {auto = true})
                cutscene:text("* WAIT SHIT RIGHT,[wait:5] RULE ONE!", "blush", "brandon")
                if cutscene:getCharacter("susie") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* The hell is rule one???", "suspicious", "susie")
                    cutscene:showNametag("Brandon")
                    cutscene:text("* There can't be any NSFW in this mod.", "neutral_side", "brandon")
                    if cutscene:getCharacter("dess") then
                        cutscene:showNametag("Dess")
                        cutscene:text("* aw man...", "neutral_b", "dess")
                    end
                end
                if cutscene:getCharacter("jamm") then
                    cutscene:showNametag("Jamm")
                    cutscene:text("* The fact that you were actually considering it is deeply concering.", "worried", "jamm")
                end
            end
        elseif event.interact_count == 10 then
            Game.world.music:pause()
            Assets.playSound("daddygirl")
            cutscene:showNametag("Bikini Spamton")
            cutscene:text("[noskip]* Baby girl?")
            cutscene:hideNametag()
            cutscene:wait(1)
            event:setSprite("myfirstartdontsteal")
            cutscene:wait(1)
            event:setSprite("mysecondartitscool")
            Assets.playSound("babyhome")
            cutscene:showNametag("Bikini Spamton")
            cutscene:text("[noskip]* Daddy's home.")
            cutscene:hideNametag()
            cutscene:wait(3)
            Assets.playSound("dimbox")
            event:setSprite("thisisfuckinghorrible_1")
            event:flash()
            cutscene:wait(1.5)
            event:setSprite("thisisfuckinghorrible_2")
            cutscene:wait(0.5)
            event:setSprite("thisisfuckinghorrible_3")
            cutscene:wait(1.5)
            Assets.playSound("helloprincess")
            cutscene:showNametag("Bikini Spamton?")
            cutscene:text("[noskip]* Hello princess.")
            cutscene:hideNametag()
            Game.world.music:resume()
            Kristal.callEvent("completeAchievement", "flipacursed")
        else
            cutscene:text("* INTERESTED IN SEEING MY [[Sitting Cheeks]]?", nil, "spamtong")
            event:setSprite("hands")
            cutscene:text("* I'LL GIVE YOU A SMALL [[Subcribe Now For 19.97% Less]]", nil, "spamtong")
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* No thanks??", "sus_nervous", "susie")
                cutscene:showNametag("Bikini Spamton")
                event:resetSprite()
                cutscene:text("* YOU'RE MISSING OUT KID.", nil, "spamtong")
            end
            if cutscene:getCharacter("dess") then
                cutscene:showNametag("Dess")
                cutscene:text("* I'm interested.", "genuine", "dess")
                cutscene:text("* Hey "..Mod:getLeader().name.." give me money", "condescending", "dess")
                cutscene:hideNametag()
                cutscene:choicer({"Ok", "Hell no"})
                cutscene:showNametag("Dess")
                cutscene:text("* Cool thank you.", "genuine_b", "dess")
                cutscene:hideNametag()
                Game.money = Game.money - 19 --I could prevent negative money but it's funnier not to do that
                local money_drop = Game:addFlag("money_drop_spamton", 19)
                local again = event.interact_count > 2 and "..[wait:5] again." or ""
                cutscene:text("* (Dess bought some sort of subscription for whatever Spamton was selling."..again..")")
                cutscene:showNametag("Dess")
                cutscene:text("* Damn guys you're missing out.", "neutral", "dess")
                cutscene:text("* He even has cool merchandise.", "neutral_b", "dess")
                if cutscene:getCharacter("brandon") then
                    cutscene:showNametag("Brandon")
                    cutscene:text("* WHAT THE [color:red][shake:1]FUCK[shake:0][color:reset]?![wait:10]\n* IS THAT SPAMTON'S [color:red][shake:1]D-[shake:0][color:reset]?!", "shock", "brandon", {auto = true})
                end
                cutscene:showNametag("Bikini Spamton")
                event:setSprite("arms_up")
                cutscene:text("* GLAD YOU LIKE MY ONLYPipis.", nil, "spamtong")
                if money_drop >= 300 then
                    Kristal.callEvent("completeAchievement", "fuckinscam")
                end
            end
        end
        event:resetSprite()
        event.flip_x = false
        event.x = old_x
        cutscene:hideNametag()
    end,

    spambass = function(cutscene, event)
        cutscene:text("* There's a description written on the mount...")
        cutscene:text("* NOW YOU TOO CAN LISTEN TO MY [charming voice] IN THE SHAPE OF A [big mouth bass]!")
        cutscene:text("* Batteries not included")
    end,

    -- ┌───────────────────────┐ --
    -- │     The Warp Bin      │ --
    -- └───────────────────────┘ --
    warpbin = function(cutscene, event)
        cutscene:text("* It's the warp bin.")
        cutscene:text("* Would you like to warp?[wait:10]\n* You only need the code.")

        if cutscene:choicer({"Sure", "Nope"}) == 2 then
            return
        end

        local wbi_ok = false
        ---@type WarpBinCodeInfo
        local action
        local action_raw
        local wbi = WarpBinInputMenu()
        wbi.finish_cb = function(_action, _action_raw)
            wbi_ok = true
            action = _action
            action_raw = _action_raw
        end
        Game.world:spawnObject(wbi, "ui")
        cutscene:wait(function() return wbi_ok end)

        if not action then
            if event.foolproof_counter == nil then event.foolproof_counter = 0 end
            event.foolproof_counter = event.foolproof_counter + 1
            if event.foolproof_counter == 10 then
                cutscene:text("* For some reason, the lid opened...")
                action = { result = "backrooms/gramophone" }
            else
                cutscene:text("* That doesn't seem to work.")
                if event.foolproof_counter >= 3 and event.foolproof_counter < 10 then
                    cutscene:text("* You're reminded of the fact that you can put in \"00000000\" when you're stuck.")
                    if event.foolproof_counter >= 5 then
                        cutscene:text("* Seriously, you're not getting anywhere with this.")
                    end
                end
                return
            end
        end

        local warpable = true
        if action.cond then
            warpable = action.cond()
        elseif action.flagcheck then
            local inverted, flag = Utils.startsWith(action.flagcheck, "!")

            local result = Game.flags[flag]
            local value = action.flagvalue
            local is_true
            if value ~= nil then
                is_true = result == value
            elseif type(result) == "number" then
                is_true = result > 0
            else
                is_true = result
            end

            if is_true then
                warpable = not inverted
            else
                warpable = inverted
            end
        end

        local result = action.result or action[1]
        local marker = action.marker or action[2]
        local silence_system_messages = action.silence_system_messages
        if silence_system_messages == nil then
            silence_system_messages = false
        end

        if type(result) == "function" then
            result = result(cutscene)
            if not result then return end
            if type(result) == "table" then
                marker = result.marker or result[2]
                result = result.result or result[1]
            end
        elseif not warpable then
            if action.on_fail then
                action.on_fail(cutscene)
            elseif silence_system_messages then
                cutscene:text("* That doesn't seem to work.")
            end
            return
        end

        assert(type(result) == "string", "result should be the id of a map or a function (got a "..type(result)..")")

        local dest_map
        pcall(function() dest_map = Registry.createMap(result, Game.world) end)
        if not dest_map then
            if silence_system_messages then
                cutscene:text("* Where are you warping to?")
            end
            return
        end
        if Game.world.map.id == dest_map.id then
            if silence_system_messages then
                cutscene:text("* But you're already there.")
            end
            return
        end

        cutscene:wait(0.2)

        Game.world.music:stop()
        -- Hell naw is this the only way to stop all sounds?
        for key,_ in pairs(Assets.sound_instances) do
            Assets.stopSound(key, true)
        end
        cutscene:fadeOut(0)
        cutscene:playSound("impact")

        cutscene:wait(1)
        cutscene:loadMap(dest_map, marker, "down")
        cutscene:fadeIn(0.25)
    end,
}
