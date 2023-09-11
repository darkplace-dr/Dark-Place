return {

    dresser = function(cutscene, event)
        cutscene:text("* It looks like a dresser,[wait:5] will you peek inside?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            if Game.party[1].id ~= "brandon" then
                cutscene:text("[noskip]* You open the dr", nil, nil, {auto = true})
                cutscene:showNametag("Brandon")
                cutscene:text("* Hey,[wait:5] no!", "miffed", "brandon")
                cutscene:text("* Don't look at my stuff without my permission,[wait:5] okay?", "frown", "brandon")
                cutscene:hideNametag()
                cutscene:text("* Brandon closed the dresser.")
            else
                cutscene:text("* Brandon opened the dresser.")
                cutscene:text("* It's a drawer filled with socks.")
                cutscene:text("* Scandelous!")
            end
        else
            cutscene:text("* You decide not to.")
        end
    end,

    foodbowl = function(cutscene, event)
        cutscene:text("* It's a bowl for putting pet food in.")
        cutscene:text("* The name on it is \"Breadulous\".")
        if not Game:getFlag("pikpik_quest") then
            cutscene:showNametag("Brandon")
            cutscene:text("* Ah crap,[wait:5] I gotta get more Pikpik carrots.", "shock", "brandon")
            cutscene:text("* Breadulous can eat other things,[wait:5] but...", "neutral_side", "brandon")
            cutscene:text("* He really,[wait:5] really likes Pikpik carrots!", "happy_b", "brandon")
            cutscene:text("* I don't blame him either,[wait:5] I like 'em too.", "happy", "brandon")
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* Where the hell do you get those?", "nervous_side", "susie")
                cutscene:showNametag("Brandon")
            else
                cutscene:text("* Hm?[wait:5] Where do I get them from?", "neutral_side", "brandon")
            end
            cutscene:text("* Well,[wait:5] they're normally pretty expensive.", "neutral", "brandon")
            cutscene:text("* Interstellar shipping is NOT cheap.", "dissapointed", "brandon")
            cutscene:text("* But,[wait:5] I know of a place where they naturally grow.", "grin", "brandon")
            cutscene:text("* The downside is,[wait:5] that place is SUPER dangerous.", "frown_side", "brandon")
            cutscene:text("* That is,[wait:5] if you're going alone.", "happy", "brandon")
            cutscene:text("* What do I mean by that?", "neutral_side", "brandon")
            cutscene:text("* Well,[wait:5] you'll see eventually.", "happy", "brandon")
            cutscene:text("* I actually know the Warp Bin code to that place.", "happy_side", "brandon")
            cutscene:text("* It's \"PIKNF404\".", "happy", "brandon")
            cutscene:text("* Man,[wait:5] hopefully Breadulous doesn't get mad at me...", "suspicious", "brandon")
            cutscene:hideNametag()
            Game:setFlag("pikpik_quest", true)
            Kristal.callEvent("createQuest", "Pikpik Dandori", "pikpik", "Brandon is out of Pikpik carrots to feed Breadulous with. Buying them outright is too expensive, so you're going to have to find naturally grown carrots instead. Brandon said the code to where they grow is \"PIKNF404\", but be warned, the place is dangerous even with a full party!")
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Good luck getting those carrots.", "happy_b", "brandon")
            cutscene:hideNametag()
        end
    end,

    breadulous = function(cutscene, event)
        --WIP (I really gotta sleep)
        if Mod:isNight() then
            cutscene:text("* A mimir.")
        else
            cutscene:text("* The boy.")
        end
    end,

    bed = function(cutscene, event)
        cutscene:text("* It's a bed for two people.")
        cutscene:text("* It looks very comfortable.")
        if Mod:isNight() and #Game.party == 4 then
            cutscene:showNametag("Brandon")
            cutscene:text("* Actually...[wait:10] It's getting pretty late,[wait:5] isn't it?", "happy_side", "brandon")
            cutscene:text("* You guys can spend the night here if you'd like!", "happy_b", "brandon")
            cutscene:hideNametag()
            if cutscene:choicer({"Yes", "No"}) == 1 then
                cutscene:showNametag("Brandon")
                cutscene:text("* Great!", "happy_b", "brandon")
                cutscene:text("* You guys can sleep in the living room.", "happy", "brandon")
                cutscene:text("* I'd let one of you guys sleep with me,[wait:5] but...", "neutral", "brandon")
                cutscene:text("* That just feels a bit weird,[wait:5] since well...", "neutral_side", "brandon")
                cutscene:text("* I share this bed with my girlfriend.", "happy_blush", "brandon")
                cutscene:text("* But uh anyways...", "blush", "brandon")
                cutscene:text("* Goodnight guys,[wait:5] sweet dreams!", "joy", "brandon")
                cutscene:hideNametag()
                cutscene:wait(cutscene:fadeOut(2, {color = {0, 0, 0}, music = true}))
                Game:removePartyMember("brandon")
                -- TODO: Make this actually work
                --[[local x,y = 300,260
                Game.world:mapTransition("devhotel/rooms/room_001/entrance", "sleepover")
                cutscene:detachCamera()
                cutscene:detachFollowers()
                if Game:hasPartyMember("YOU") and Game:hasPartyMember("susie") and Game:hasPartyMember("dess") then
                    cutscene:walkTo("YOU", x, y - 20, 0.1, "up")
                    cutscene:walkTo("susie", x - 50, y, 0.1, "up")
                    cutscene:walkTo("dess", x + 50, y, 0.1, "up")
                    cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}, music = true}))
                end]]
                cutscene:text("* Everyone had a good night's rest.")
                Game:addPartyMember("brandon")
                cutscene:wait(cutscene:fadeIn(2, {color = {0, 0, 0}, music = true}))
            else
                cutscene:showNametag("Brandon")
                cutscene:text("* Alright then,[wait:5] suit yourselves.", "neutral_side", "brandon")
                cutscene:hideNametag()
            end
        else
            cutscene:text("* A sleepover would be nice if there were 4 people.")
        end
    end
}