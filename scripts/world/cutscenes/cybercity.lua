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
    end

    pink_ad = function(cutscene)
        local addisonpink = cutscene:getCharacter("addisonpink")
        addisonpink:setAnimation("idle")
        cutscene:text("* I'm still a WIP! Don't mind me here!")
        addisonpink:resetSprite()
    end
    
}