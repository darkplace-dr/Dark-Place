return {

    spamdumpster = function(cutscene)
        
        if Game:getFlag("weird") then
            if Game:getFlag("weirdEnemiesKilled", 0) <= 19 then
                if Game.talkedToSpamDumpsterInAlley2 == false then
                    cutscene:text("[voice:spamton]* LOOKING FOR [Irresistible Deals] THAT WILL [Blow Your Mind!?]")
                    cutscene:text("[voice:spamton]* WELL [Shut Your Mouth] BECAUSE YOU ARE [A Weakling!]")
                    cutscene:text("[voice:spamton]* TRY A LITTLE [Friday Night Work Out]...")
                    cutscene:text("[voice:spamton]* THEN I'LL SHOW YOU MY")
                    cutscene:text("[voice:spamton]* THEN I'LL SHOW YOU MY")
                    cutscene:text("[voice:spamton]* ".. 20 - Game:getFlag("weirdEnemiesKilled", 0) .." LEFT.")
                else
                    cutscene:text("[voice:spamton]* GET STRONGER")
                    cutscene:text("[voice:spamton]* THEN I'LL SHOW YOU MY")
                    cutscene:text("[voice:spamton]* THEN I'LL SHOW YOU MY")
                    cutscene:text("[voice:spamton]* ".. 20 - Game:getFlag("weirdEnemiesKilled", 0) .." LEFT.")
                end
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
            
            while Game.money > 0 do
                Game.money = math.floor(Utils.lerp(Game.money, 0, 0.33))
                cutscene:wait(1/30)
            end
            
            cutscene:text("* I'm a   [color:yellow]Starwalker[color:reset]")
            
            cutscene:setSpeaker()
            cutscene:hideShop()
            cutscene:wait(0.25)
            Assets.playSound("save")
            cutscene:wait(0.5)
            Game:saveQuick(Game.world.player:getPosition())
            
            cutscene:text("* (The   [color:yellow]Starwalker[color:reset][wait:6]\n   somehow saved your game...)")
            
        else
            Game.world.music:pause()
            
            cutscene:text("* [color:yellow]You[color:reset] are [color:yellow]Pissing[color:reset] me off...", nil, event)
            
            cutscene:text("* I,[wait:5] uh,[wait:5] what?", "sus_nervous", "susie")
            cutscene:text("* Well,[wait:5] hey,[wait:5] you know\nwhat?", "annoyed", "susie")
            cutscene:text("* You piss us off too.", "smirk", "susie")
            --Game.world.music:fade(1,0)
            local cutscene_music = Music()
            cutscene_music:play("s_neo")
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
                        Game.world.music:play("cybercity_alt")
                        --Game.world.music.volume = 1
                        Game.world.player:setFacing("down")
                    else
                        event.sprite:resetSprite()
                        event.interacted = false
                        cutscene:text("* Wow, con grats on [color:yellow]beating[color:reset] my [color:yellow]ass[color:reset]")
                        cutscene:text("* I will give you the keys of my\n          [color:yellow]house[color:reset]")
                        if not Kristal.libCall("achievements", "hasAch", "unoriginalstarwalker") then
                            Kristal.callEvent("completeAchievement", "unoriginalstarwalker")
                        end
                        Game:setFlag("unlockedStarwalkerValley", true)
                        cutscene:text("* (You got the keys to the\n          [color:yellow]starwalker[color:reset]\n                    valley)")
                        Game.world.music:resume("cybercity")
                        --Game.world.music.volume = 1
                        Game.world.player:setFacing("down")
                    end
                end
            end

            --[color:yellow]Starwalker[color:reset]

            cutscene:interpolateFollowers()
            cutscene:attachFollowers()
        end
    end,

    pink_ad = function(cutscene)
        local addisonpink = cutscene:getCharacter("addisonpink")
        addisonpink:setAnimation("idle")
        cutscene:text("* I'm still a WIP! Don't mind me here!", "wink", "addisonpink")
        addisonpink:resetSprite()
    end,
}