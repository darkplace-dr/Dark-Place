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