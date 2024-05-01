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
        cutscene:text("* REMEMB3R TO FOLLOW THE [T.H.I.N.K] PRINCIPLE, YOU [Little Sponge]!!", nil, "alternatespam")
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
        cutscene:text("* HEY [wait:5][wave]EVERY~", nil, "marispam")
        cutscene:text("* WAITING FOR [wave]SOMETHING[wave:0] TO HAPPEN?", nil, "marispam")
        cutscene:hideNametag()
    end,
    mosquito = function(cutscene, event)
        cutscene:showNametag("Spamton Mosquito")
        cutscene:text("* EVER WANTED TO JUST RELAX FOR THE [[Hot Summer Deals]]?", nil, "spam_mosquito")
        cutscene:text("* BUT ALL THE DAMN [bugs] ARE IN THE WAY?", nil, "spam_mosquito")
        cutscene:text("* WE GOT YOU COVERED WITH THE NEW [[Hyperlink Blocked]]!", nil, "spam_mosquito")
        cutscene:text("* [currently not in stock].", nil, "spam_mosquito")
        cutscene:hideNametag()
    end,
    cungadero = function(cutscene, event)
        cutscene:showNametag("Cungadero Spamton")
        cutscene:text("* Take a ride around town on our special Cungadero!", nil, "cungaderospamton")
        event:setSprite("smile")
        cutscene:text("* Hey everybody![wait:10]\n* It's me!", nil, "cungaderospamton")
        event:setSprite("wink")
        cutscene:text("* Everybody's favorite salesman,[wait:5] Spamton G. Spamton!", nil, "cungaderospamton")
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
            cutscene:text("* Why,[wait:5] to show it off,[wait:5] of course!", nil, "cungaderospamton")
            event:setSprite("neutral")
            cutscene:text("* I would of gotten here sooner if I hadn't got into traffic.", nil, "cungaderospamton")
            event:setSprite("angry")
            cutscene:text("* WHY WAS I STUCK IN TRAFFIC?![wait:10]\n* DON'T THEY KNOW?[wait:10]\n* DON'T THEY KNOW WHO I AM?!", nil, "cungaderospamton")
            event:setSprite("sideeye")
            cutscene:text("[noskip][speed:0.3]* ...", nil, "cungaderospamton")
            event:setSprite("wink")
            cutscene:text("* Spamton G. Spamton,[wait:5] that's who I am!", nil, "cungaderospamton")
            event:setSprite("rage")
            cutscene:text("* AAAAAAAAAARGH!!!", nil, "cungaderospamton")
            event:setSprite("neutral")
        end
        if cutscene:getCharacter("dess") then
            cutscene:showNametag("Dess")
            cutscene:text("* yooooo is that the uhhhhh big shot guy????", "neutral", "dess")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("wink")
            cutscene:text("* Ah,[wait:5] a loyal fan I see.", nil, "cungaderospamton")
            cutscene:showNametag("Dess")
            cutscene:text("* who said I actually liked you lmfao", "condescending", "dess")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("shock")
            cutscene:text("[noskip][speed:0.3]* ...", nil, "cungaderospamton")
            event:setSprite("neutral")
        end
        if cutscene:getCharacter("brenda") then
            cutscene:showNametag("Brenda")
            cutscene:text("* Woah,[wait:5] it's sureal seeing you before you lost your marbles.", "neutral", "brenda")
            cutscene:showNametag("Cungadero Spamton")
            event:setSprite("shock")
            cutscene:text("* Uh...[wait:10] what?", nil, "cungaderospamton")
            cutscene:showNametag("Brenda")
            cutscene:text("* Oh,[wait:5] nothing,[wait:5] nothing!", "blush", "brenda")
            event:setSprite("neutral")
        end
        event:setSprite("happy")
        cutscene:hideNametag()
    end,
    cardspam = function (cutscene, event, player)
        if player.facing == "left" then
            event.flip_x = true
        else
            event.flip_x = false
        end
        cutscene:showNametag("Spamton")
        event:setSprite("hold_cards")
        cutscene:text("* PICK A CARD,[wait:5]\nANY [Kaard].", nil, "cungaderospamton")

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
        cutscene:text("[style:GONER][voice:silent][noskip]* [instant][shake:1][func:gigatalk]WRONG[stopinstant][wait:20] [instant][func:gigatalk]CARD", nil, "cungaderospamton", {
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
            if cutscene:getCharacter("brenda") then
                cutscene:showNametag("Brenda")
                cutscene:text("[noskip]* O-oh,[wait:5] well I-", "owo_blush", "brenda", {auto = true})
                cutscene:text("* WAIT SHIT RIGHT,[wait:5] RULE ONE!", "blush", "brenda")
                if cutscene:getCharacter("susie") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* The hell is rule one???", "suspicious", "susie")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* There can't be any NSFW in this mod.", "neutral_side", "brenda")
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
                if cutscene:getCharacter("brenda") then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* WHAT THE [color:red][shake:1]FUCK[shake:0][color:reset]?![wait:10]\n* IS THAT SPAMTON'S [color:red][shake:1]D-[shake:0][color:reset]?!", "shock", "brenda", {auto = true})
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

    muppet = function(cutscene, event)
        cutscene:showNametag("Other Kris")
        event:setAnimation("talk")
        cutscene:text("* WOAH ISN'T IT A LI\n[wait:20]* A LOGH\n[wait:10]* A LIGHNR[wait:10]", nil, "muppet_kris", {auto = true})
        cutscene:text("* I S'T A LIGNERE\n[wait:20]* A NEW ROACH\n[wait:10]* A LIGHT N3R?[wait:30]", nil, "muppet_kris", {auto = true})
        cutscene:hideNametag()
        event:setAnimation("idle")
    end,
}
