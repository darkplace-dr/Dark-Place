return {

    spamdumpster = function(cutscene)
        local jamm = cutscene:getCharacter("jamm")
		
        if Game:getFlag("weird") then
            if Game:getFlag("weirdEnemiesKilled", 0) <= 19 then
                -- FIXME: otherwise unset variable
                if Game.talkedToSpamDumpsterInAlley2 == false then
                    cutscene:text("[voice:spamton]* LOOKING FOR [Irresistible Deals] THAT WILL [Blow Your Mind!?]")
                    cutscene:text("[voice:spamton]* WELL [Shut Your Mouth] BECAUSE YOU ARE [A Weakling!]")
                    cutscene:text("[voice:spamton]* TRY A LITTLE [Friday Night Work Out]...")
                else
                    cutscene:text("[voice:spamton]* GET STRONGER")
                end
                cutscene:text("[voice:spamton]* THEN I'LL SHOW YOU MY")
                cutscene:text("[voice:spamton]* THEN I'LL SHOW YOU MY")
                cutscene:text("[voice:spamton]* ".. math.max(0, 20 - Game:getFlag("weirdEnemiesKilled", 0)) .." LEFT.")
            else
                cutscene:text("[voice:spamton]* [Angel],[wait:0.1s] [Angel]")
                cutscene:text("[voice:spamton]* ARE YOU LOOKING FOR THE [Microwave] of [Fuckin' Hell]?")
                local choicer1 = cutscene:choicer({"Yes", "No"})
                if choicer1 == 1 then
                    cutscene:text("[voice:spamton]* THat'll be 1997 KROMER.")
                    local choicer2 = cutscene:choicer({"Yes", "No"})
                    if choicer2 == 1 then
                        if Game.money >= 1997 then
                            if not Game.inventory:addItem("thornring") then
                                cutscene:text("[voice:spamton]* LET ME CHECK YOUR [Pockets]")
                                cutscene:text("[voice:spamton]* WOW, NICE AND SPACIOUS!!")
                                cutscene:text("[voice:spamton]* PERFECT FOR [City Livin']")
                                cutscene:text("[voice:spamton]* HOW CAN YOU [Afford] THIS!?!?!")
                                cutscene:text("[voice:spamton]* ... YET THERE'S NO ROOM FOR A [Microwave]")
                                if Game.lancerinventory then
                                    -- For jaru's lancer library, once it's implemented
                                    cutscene:text("[voice:spamton]* THERE'S A [Boy], BUT THERE'S NO ROOM FOR A [Microwave.width/2]")
                                else
                                    cutscene:text("[voice:spamton]* THERE'S A [Backful] OF [Consumable], BUT THERE'S NO ROOM FOR A [Microwave.width/2]")
                                end
                                return
                            end
                            cutscene:text("[voice:spamton]* HERE'S YOUR [microwehv]![wait:0.1s] CAREFUL,[wait:0.1s] IT MIGHT [Burn]\n* EAHEAHEAH")
                            cutscene:text("(You got the Microwave.)")
							if jamm and not Game:getFlag("dungeonkiller") then
								cutscene:showNametag("Jamm")
								cutscene:text("* (What the hell...)", "neutral", "jamm")
								cutscene:hideNametag()
							end
                            return
                        else
                            cutscene:text("[voice:spamton]* [Money] NO")
                            return
                        end
                    elseif choicer2 == 2 then
                        cutscene:text("[voice:spamton]* BUT IT WAS SUCH A GOOD YEAR.")
                    end
                else
                    cutscene:text("[voice:spamton]* THEN [[WHY]] GO TO A DUMPSTER!!!")
                end
                
            end
        else
            cutscene:text("* It's a lone dumpster.")
            cutscene:text("* There doesn't seem to be anything, or anyone, inside it.")
        end

    end,

    enterstaralley = function(cutscene)

        if not Game:getFlag("openedStarwalkerValley", false) then
            
            if Game:getFlag("unlockedStarwalkerValley", false) == false then
                cutscene:text("* (There's traffic cones blocking the\n          [color:yellow]way[color:reset]")
            else
                cutscene:text("* (Do you want to open the\n          [color:yellow]starwalker[color:reset]\n                    valley)")
                local cc = cutscene:choicer({"Yes", "No"})
                if cc == 1 then
                    cutscene:text("* (You opened\n          [color:yellow]it[color:reset]")
                    Game:setFlag("openedStarwalkerValley", true)
                    Game.world.map:getEvent("cone1"):explode()
                    Game.world.map:getEvent("cone2"):explode()
                    Game.world.map:getEvent(214):remove()
                else
                    cutscene:text("* (You didn't open\n          [color:yellow]it[color:reset]")
                end
            end

        end
    end,

    starwalker = function(cutscene, event, player, facing)
        --event.interacted = true
    
        local kris = cutscene:getCharacter("kris")
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")
        local noelle = cutscene:getCharacter("noelle")
    
        if Game.money <= 0 and not event.interacted then
            cutscene:showShop()
            local shopbox = cutscene.shopbox
            Game.world.music:pause()
            
            cutscene:text("* Lmao you're broke as\n          [func:remove][color:yellow]fuck[noskip][wait:1.2s]", {functions = {
                remove = function()
                    Game.money = Game.money - 1
                    Assets.playSound("locker")
    
                    local fx = shopbox:addFX(ColorMaskFX({1, 1, 0}, 0.5))
                    Game.stage.timer:tween(1, fx, {amount = 0}, "out-quad", function()
                        shopbox:removeFX(fx)
                    end)
    
                    Game.world.fader:fadeIn(nil, {speed = 0.8, color = {1, 1, 1}, alpha = 1})
    
                    if kris then
                        kris:setSprite("fell")
                    end
                    susie:setSprite("fell")
                    if ralsei then ralsei:setSprite("splat") end
                    if noelle then
                        noelle:setSprite("collapsed")
                        noelle.sprite.flip_x = true
                    end
                end
            }})
            
            cutscene:hideShop()
            cutscene:wait(0.5)
            if noelle then
                noelle.sprite.flip_x = false
                noelle:resetSprite()
                noelle:shake(4)
                Assets.playSound("wing")
                cutscene:wait(0.5)
            end
            if ralsei then
                ralsei:resetSprite()
                ralsei:shake(4)
                Assets.playSound("wing")
                cutscene:wait(0.5)
            end
            if kris then
                susie:resetSprite()
                susie:shake(4)
                Assets.playSound("wing")
                cutscene:wait(0.5)
                kris:resetSprite()
                kris:shake(4)
                Assets.playSound("wing")
            else
                cutscene:wait(0.5)
                susie:resetSprite()
                susie:shake(4)
                Assets.playSound("wing")
            end
            cutscene:wait(0.1)
            Game.world.music:resume()
            cutscene:wait(0.4)
            return
        end
    
        if not event.interacted then
            event.interacted = true
            cutscene:showShop()
            cutscene:setSpeaker(event)
            
            cutscene:text("* These [color:yellow]bananas[color:reset] are [color:yellow]Pissing[color:reset] me\noff...")

            Game:setFlag("starwalker_money", Game.money)
            
            while Game.money > 0 do
                Game.money = math.floor(Utils.lerp(Game.money, 0, 0.33))
                cutscene:wait(1/30)
            end
            
            if cutscene:getCharacter("susie") then
                cutscene:text("* WH-!", "shock", "susie")
                cutscene:text("* HEY,[wait:5] WHAT THE HELL?!", "teeth_b", "susie")
            end
            cutscene:text("* I'm a   [color:yellow]Starwalker[color:reset]")
            
            cutscene:setSpeaker()
            cutscene:hideShop()
            cutscene:wait(0.25)
            Assets.playSound("save")
            cutscene:wait(0.5)
            Game:saveQuick(Game.world.player:getPosition())
            
            cutscene:text("* (The   [color:yellow]Starwalker[color:reset][wait:6]\n   somehow saved your game...)")
            
        elseif cutscene:getCharacter("susie") then
            Game.world.music:pause()
            
            cutscene:text("* [color:yellow]You[color:reset] are [color:yellow]Pissing[color:reset] me off...", nil, event)
            
            cutscene:text("* I,[wait:5] uh,[wait:5] what?", "sus_nervous", "susie")
            cutscene:text("* Well,[wait:5] hey,[wait:5] you know\nwhat?", "annoyed", "susie")
            cutscene:text("* You piss us off too.", "smirk", "susie")
            --Game.world.music:fade(1,0)
            local cutscene_music = Music("s_neo")
            cutscene:detachFollowers()
            if kris then
                cutscene:walkTo(kris, kris.x, kris.y - 40, 1, "down", true)
                cutscene:wait(cutscene:walkTo(susie, kris.x, kris.y, 1, facing))
            end
            cutscene:text("* If you have a problem\nwith us,[wait:5] then we have\na problem with you.", "smirk", "susie")
            cutscene:text("* Do you know what we do\nwith problems?", "smirk", "susie")
            cutscene:text("* We stomp.[wait:10] Them.[wait:10] Into.[wait:10]\nThe.[wait:10] Ground.", "smile", "susie")
            cutscene_music:stop()
            Assets.playSound("boost")
    
            event.sprite:set("wings")
    
            local offset = event.sprite:getOffset()
    
            local flash_x = event.x - (event.actor:getWidth() / 2 - offset[1]) * 2
            local flash_y = event.y - (event.actor:getHeight() - offset[2]) * 2
    
            local flash = FlashFade("npcs/starwalker/starwalker_wings", flash_x, flash_y)
            flash.flash_speed = 0.5
            flash:setScale(2, 2)
            flash.layer = event.layer + 1
            event.parent:addChild(flash)
    
            cutscene:wait(1)
            cutscene:text("* Uh,[wait:5] what-", "surprise_frown", "susie", {auto=true})
    
            local encounter = cutscene:startEncounter("og_starwalker", true, {{"og_starwalker", event}})
    
            local defeated_enemies = encounter:getDefeatedEnemies()
    
            if defeated_enemies then
                local done_state = defeated_enemies[1].done_state
    
                if done_state then
                    if done_state == "VIOLENCED" or done_state == "KILLED" or done_state == "FROZEN" then
                        event.sprite:resetSprite()
                        event.interacted = false
                        Game.world.map:getEvent(45):remove()
                        cutscene:wait(1)
                        cutscene:text("* Hey,[wait:5] uh.", "neutral", "susie")
                        cutscene:text("* I know they were in our way,[wait:5] but...", "annoyed_down", "susie")
                        susie:setFacing("up")
                        cutscene:text("* What happened to the ACTing thing?", "neutral", "susie")
                        cutscene:text("* ...", "annoyed_down", "susie")
                        Assets.playSound("ominous")
                        cutscene:wait(1.5)
                        Game:setFlag("weird", true)
                        Game:setFlag("killedTRUEOriginalStarwalkerInAlley2", true)
                        Game.world.music:play("deltarune/cybercity_alt")
                        --Game.world.music.volume = 1
                        Game.world.player:setFacing("down")
                    else
                        event.sprite:resetSprite()
                        event.interacted = false
                        cutscene:text("* Wow, con grats on [color:yellow]beating[color:reset] my [color:yellow]ass[color:reset]")
                        cutscene:text("* I will give you the keys of my\n          [color:yellow]house[color:reset]")

                        Kristal.callEvent("completeAchievement", "unoriginalstarwalker")
                        Game:setFlag("unlockedStarwalkerValley", true)

                        cutscene:text("* (You got the keys to the\n          [color:yellow]starwalker[color:reset]\n                    valley)")
                        Game.world.music:resume()
                        --Game.world.music.volume = 1
                        Game.world.player:setFacing("down")
                    end
                end
            end

            --[color:yellow]Starwalker[color:reset]

            cutscene:interpolateFollowers()
            cutscene:attachFollowers()
        else
            cutscene:text("* [color:yellow]Starwalker[color:reset].", nil, event)
        end
    end,

    pink_ad = function(cutscene)
        local addisonpink = cutscene:getCharacter("addisonpink")
        addisonpink:setAnimation("idle")
        cutscene:text("* I'm still a WIP! Don't mind me here!", "wink", "addisonpink")
        addisonpink:resetSprite()
    end,

    gamer = function(cutscene, event)
        cutscene:text("* For some reason there's a door on the floor.")
        cutscene:text("* Will you go inside?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            Game.world:mapTransition("gamertimeentrance", "spawn")
        end
    end,

    notypee = function(cutscene, event)
        if event:getFlag("can_rant", {false, false})[1] and love.math.random(0, 3)==1 then
            cutscene:showNametag(event:getFlag("can_rant", {false, false})[2] and "Notypee" or "???")
            Game.world.timer:after(3, function()
                if Game.world.cutscene and not cutscene.ended then
                    cutscene:during(function()
                        if not cutscene.textbox then return false end
                        cutscene.textbox.text.y = cutscene.textbox.text.y - 1.2*DTMULT
                    end, false)
                end
            end)
            Game.world.timer:after(1/FRAMERATE, function()
                if Game.world.cutscene and not cutscene.ended and cutscene.textbox then
                    cutscene.textbox.text.canvas = love.graphics.newCanvas(cutscene.textbox.text.width, 1300)
                    cutscene.textbox.text:processInitialNodes()
                end
            end)
            local skipped = false
            cutscene:during(function()
                if (cutscene.textbox.text:isTyping() and (Input.pressed("cancel") or Input.pressed("menu"))) or FAST_FORWARD then
                    skipped = true
                end
            end)
            cutscene:text("Ohh boy...I think I need to shower before I start talking...I mean streaming...I mean entertain you guys. I mean, sorry about that....errr...lets get back to what I was saying before I was distracted there for a second by the smell of my own body odor...ummm....I really hope I don't smell too bad because I haven't had a shower in like two days now and I've been wearing this t-shirt with like five layers of clothes under it for the last few days because I haven't washed it since I wore it last week and I'm kinda starting to smell like a gym bag right now....oh god I hope I'm not offending anyone with my bad hygiene right now because I'm just not used to this level of exposure yet and I don't want to make anyone feel uncomfortable around me or anything so I'm gonna take a shower real quick and hopefully after that I won't smell too bad and I'll be able to continue talking with you guys without any more distractions from my stinky self thank you guys so much for reading my ramblings and I'm sorry if I made you uncomfortable in any way shape or form.")
            local e = event:explode()
            if not skipped then
                Game.world.timer:during(math.huge, function()
                    if not e or (e and not e.parent) then
                        Kristal.callEvent("completeAchievement", "airant")
                        return false
                    end
                end)
            end
            if cutscene:getCharacter("brandon") then
                cutscene:wait(3)
                cutscene:showNametag("Brandon")
                cutscene:text("* Excuse me what the actual fuck was that.", "shock", "brandon")
                cutscene:hideNametag()
            end
        else
            if event.interact_count == 1 then
                event.interacted_with = nil
                cutscene:showNametag("???")
                cutscene:text("[color:red]* DO NOT APPROCH!![wait:5] FOR I AM THE MASTER OF HELL AND DEATH!!")
                cutscene:text("[color:red]* I CAN HAVE YOUR SOUL IN A SECOND!!")
                if cutscene:getCharacter("susie") then
                    event.interacted_with = "susie"
                    cutscene:showNametag("Susie")
                    cutscene:text("* Dude,[wait:2] you're a flame in a gymbag.", "suspicious", "susie")
                    cutscene:text("* You think you're scary or something?", "neutral_side", "susie")
                    cutscene:showNametag("???")
                    cutscene:text("* What-[wait:2] Hey![wait:5] I'm not a flame!")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Then what are you?", "nervous", "susie")
                    cutscene:showNametag("???")
                    cutscene:text("[color:red]* WHAT I AM IS PURE MYSTERY.[wait:5] NONE CAN SEE PAST THE MEANING OF MY EXISTENCE")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Cut it off.", "annoyed", "susie")
                    cutscene:text("* Your whole act sucks.[wait:3] Plus anyone can see right through it.", "bangs_neutral", "susie")
                    cutscene:text("* So I repeat:[wait:5] what are you?", "bangs_teeth", "susie")
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:showNametag("Notypee")
                    cutscene:text("* Notypee.[wait:5] I'm Notypee...")
                    cutscene:showNametag("Susie")
                    cutscene:text("* There we go.[wait:3] Easy,[wait:2] right?", "smile", "susie")
                    cutscene:showNametag("Notypee")
                    cutscene:text("* Mmm...")
                elseif cutscene:getCharacter("dess") then
                    event.interacted_with = "dess"
                    cutscene:showNametag("Dess")
                    cutscene:text("* i have no soul tho", "condescending", "dess")
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:text("* Are you,[wait:2] like,[wait:2] sure?")
                    cutscene:showNametag("Dess")
                    cutscene:text("* Yeah.", "neutral", "dess")
                    cutscene:showNametag("???")
                    cutscene:text("* Not even a little bit?")
                    cutscene:showNametag("Dess")
                    cutscene:text("* Nope.", "wink", "dess")
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:text("* Damn...[wait:3] Here goes my whole act...")
                elseif cutscene:getCharacter("brandon") then
                    event.interacted_with = "brandon"
                    cutscene:showNametag("Brandon")
                    cutscene:text("* Oh yeah?[wait:10]\n* Prove it then.", "smug", "brandon")
                    cutscene:showNametag("???")
                    cutscene:text("* ... Uh...")
                    cutscene:showNametag("Brandon")
                    cutscene:text("* Steal my soul right now.", "smug", "brandon")
                    cutscene:showNametag("???")
                    cutscene:text("[color:red]* YES YOUR SOUL WILL SOON BE MINE!")
                    cutscene:showNametag("Brandon")
                    cutscene:text("* ...", "suspicious", "brandon")
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:showNametag("Brandon")
                    cutscene:text("* ... Do it no balls?", "neutral_side", "brandon")
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:showNametag("Brandon")
                    cutscene:text("* You can't steal souls,[wait:5] can you?", "dissapointed", "brandon")
                    cutscene:showNametag("???")
                    cutscene:text("* AND SO WHAT IF I CAN'T????")
                elseif cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
                    event.interacted_with = "jamm"
                    cutscene:showNametag("Jamm")
                    cutscene:text("* Uh oh.[wait:5]\n* Did Tubba Blubba lose his heart again?", "neutral", "jamm")
                    cutscene:showNametag("???")
                    cutscene:text("* What-[wait:2] Hey![wait:5] I'm not a heart!")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* I dunno.[wait:5] You kinda look like him.", "neutral", "jamm")
                    cutscene:text("* Are you sure you don't belong to Tubba Blubba?", "neutral", "jamm")
                    cutscene:showNametag("???")
                    cutscene:text("* I don't even know who that is!")
                elseif cutscene:getCharacter("YOU") then
                    event.interacted_with = "YOU"
                    local YOU = cutscene:getCharacter("YOU")
                    cutscene:hideNametag()
                    cutscene:wait(1)
                    YOU:setSprite("walk/"..YOU.facing.."_2")
                    local frog = Assets.playSound("frog")
                    cutscene:wait(function()
                        if not frog:isPlaying() then
                            YOU:resetSprite()
                            return true
                        end
                        return false
                    end)
                    cutscene:wait(2)
                    cutscene:showNametag("???")
                    cutscene:text("* Uhm...[wait:3] What?")
                    cutscene:hideNametag()
                    YOU:setSprite("walk/"..YOU.facing.."_2")
                    local frog = Assets.playSound("frog")
                    cutscene:wait(function()
                        if not frog:isPlaying() then
                            YOU:resetSprite()
                            return true
                        end
                        return false
                    end)
                    cutscene:wait(0.5)
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:text("* You look like a turtle.")
                    cutscene:text("* I don't know if I can hurt turtles.")
                    YOU:setSprite("fightorflight")
                    if YOU.x >= event.x then
                        YOU.flip_x = true
                    end
                    cutscene:text("* Or if I should put you in the rhum.")
                    YOU:resetSprite()
                    YOU.flip_x = false
                    cutscene:text("* I should have asked for more instructions...")
                end
            else
                if event.interacted_with == "susie" then
                    cutscene:showNametag("Susie")
                    cutscene:text("* So what the hell are you even doing?", "neutral_side", "susie")
                    cutscene:showNametag("Notypee")
                    cutscene:text("[color:red]* MY-")
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...", "bangs_teeth", "susie")
                    cutscene:showNametag("Notypee")
                    cutscene:text("* ...[wait:2]I am part of an evil army...")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Oh yeah?[wait:3] Which one?", "smirk", "susie")
                    cutscene:showNametag("Notypee")
                    cutscene:text("* I-[wait:2]I can't just say that![wait:3] I'd betray our leader!")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Are you sure?", "closed_grin", "susie")
                    cutscene:showNametag("Notypee")
                    cutscene:text("* Look,[wait:2] I don't think she wanna come her anyway so you're safe,[wait:2] okay?")
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...Yeah,[wait:2] I'll take that.", "nervous", "susie")
                    cutscene:text("* But you better not lie.", "closed_grin", "susie")
                elseif event.interacted_with == "dess" then
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:showNametag("Dess")
                    cutscene:text("* ...", "neutral", "dess")
                    cutscene:showNametag("???")
                    cutscene:text("* Still no soul?")
                    cutscene:showNametag("Dess")
                    cutscene:text("* Last I checked,[wait:2] nope.", "neutral_c", "dess")
                    cutscene:showNametag("???")
                    cutscene:text("* When did you last check?")
                    cutscene:showNametag("Dess")
                    cutscene:text("* I don't know man.[wait:3] I mean I don't really need a soul since the player's soul takes over ours anyway.", "condescending", "dess")
                    cutscene:showNametag("???")
                    cutscene:text("* ...What.")
                elseif event.interacted_with == "brandon" then
                    cutscene:showNametag("Brandon")
                    cutscene:text("* So uhhhhhhhhh...", "neutral_side", "brandon")
                    cutscene:text("* Read any good books lately?", "neutral", "brandon")
                    cutscene:showNametag("???")
                    cutscene:text("* No.")
                    cutscene:showNametag("Brandon")
                    cutscene:text("* Uh okay then.", "neutral_side", "brandon")
                elseif event.interacted_with == "jamm" and not Game:getFlag("dungeonkiller") then
                    cutscene:showNametag("Jamm")
                    cutscene:text("* Are you sure the name Mario doesn't ring a bell?", "neutral", "jamm")
                    cutscene:text("* Goombario?[wait:5] Kooper?[wait:5] Bombette?[wait:5] Parakarry?[wait:5] Bow?", "neutral", "jamm")
                    cutscene:showNametag("???")
                    cutscene:text("* I'M NOT A PAPER MARIO CHARACTER!")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* Jeez, alright![wait:5]\n* No need to get your ventricles in a twist.", "neutral", "jamm")
                elseif event.interacted_with == "YOU" then
                    local YOU = cutscene:getCharacter("YOU")
                    cutscene:showNametag("???")
                    cutscene:text("* ...")
                    cutscene:text("* So uh,[wait:2] do you have a girlfriend?")
                    YOU:setSprite("disappointed")
                    cutscene:text("* I know a turtle like you,[wait:2] y'know?")
                    cutscene:text("* It was easier for him to create an AI than to have a girlfriend.")
                    cutscene:text("* Or so my leader's sister said.")
                    YOU:resetSprite()
                    cutscene:hideNametag()
                    cutscene:wait(0.5)
                    YOU:setSprite("walk/"..YOU.facing.."_2")
                    local frog = Assets.playSound("frog")
                    cutscene:wait(function()
                        if not frog:isPlaying() then
                            YOU:resetSprite()
                            return true
                        end
                        return false
                    end)
                    cutscene:wait(0.5)
                    cutscene:showNametag("???")
                    cutscene:text("* Yeah,[wait:2] my leader is an AI.[wait:3] Her sister too.")
                    YOU:setSprite("confused")
                    cutscene:text("* And the turtle is their dad.[wait:3]\n* Funny how that works.")
                    YOU:resetSprite()
                end
                event:setFlag("can_rant", {true, event.interacted_with == "susie"})
            end
        end
        cutscene:hideNametag()
    end
}
