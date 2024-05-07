return {
    ceroba = function(cutscene, event)
        ceroba = cutscene:getCharacter("ceroba")
        susie = cutscene:getCharacter("susie")
        if Game:getFlag("ceroba_talkedto") == true then
            if #Game.party >= Game:getFlag("party_max") then
                cutscene:showNametag("Ceroba")
                cutscene:text("* Still a bit too much of you.[wait:5] Sorry.", "closed_eyes", "ceroba")
                cutscene:hideNametag()
            else
                cutscene:showNametag("Ceroba")
                cutscene:text("* Is this offer about walking still valid?", "neutral", "ceroba")
                cutscene:hideNametag()
                local opinion = cutscene:choicer({"Yes", "No"})
                if opinion == 1 then
                    cutscene:hideNametag()
                    Game:addPartyMember("ceroba")
                    ceroba:resetSprite()
                    ceroba:convertToFollower()
                    cutscene:text("* Ceroba joined the party.")
                    Game:setFlag("ceroba_party", true)
                    Game:setFlag("ceroba_inparty", true)
                    Mod:unlockPartyMember("ceroba")
                else
                    cutscene:showNametag("Ceroba")
                    cutscene:text("* Okay then.", "closed_eyes", "ceroba")
                    cutscene:hideNametag()
                end
            end
        else
            if Game:getFlag("know_ceroba_name") == true then
                cutscene:showNametag("Ceroba")
            else
                cutscene:showNametag("Fox lady")
            end

            cutscene:text("* ...", "dissapproving", "ceroba")
            if susie then
                Game:setFlag("ceroba_talkedto", true)
                cutscene:showNametag("Susie")
                cutscene:text("* Um,[wait:5] hello?", "nervous", "susie")

                if Game:getFlag("know_ceroba_name") == true then
                    cutscene:showNametag("Ceroba")
                else
                    cutscene:showNametag("Fox lady")
                end
            
                cutscene:text("* Huh?", "surprised", "ceroba")
                cutscene:text("* Oh,[wait:5] hello.", "neutral", "ceroba")
                cutscene:text("* Do you...[wait:5] Need something?", "alt", "ceroba")

                cutscene:showNametag("Susie")
                cutscene:text("* Just wanted to know if you're alright.", "nervous_side", "susie")

                if Game:getFlag("know_ceroba_name") == true then
                    cutscene:showNametag("Ceroba")
                else
                    cutscene:showNametag("Fox lady")
                end

                cutscene:text("* I'm... Okay.", "dissapproving", "ceroba")
                cutscene:text("* Wait...[wait:5] Who are you again?[wait:5] I don't think I've seen you before.", "alt", "ceroba")

                cutscene:showNametag("Susie")
                cutscene:text("* Oh,[wait:5] I'm Susie.[wait:5] Kind of not from here.", "smirk", "susie")

                if Game:getFlag("know_ceroba_name") == true then
                    cutscene:text("* And you must be Ceroba?", "smirk", "susie")
                    cutscene:showNametag("Ceroba")
                    cutscene:text("* Yeah.", "dissapproving", "ceroba")
                else
                    cutscene:showNametag("Ceroba")
                    cutscene:text("* I'm Ceroba.", "neutral", "ceroba")
                end

                cutscene:showNametag("Susie")
                cutscene:text("* Nice to meet ya.", "smile", "susie")
                cutscene:text("* Say,[wait:5] whatever's troubling you...", "nervous", "susie")
                cutscene:text("* Maybe you could use a little walk?", "nervous", "susie")
            
                if #Game.party >= Game:getFlag("party_max") then
                    cutscene:showNametag("Ceroba")
                    cutscene:text("* There's a bit too much of you all right now.", "closed_eyes", "ceroba")
                    cutscene:text("* Come back...[wait:5] When there's less of you.", "neutral", "ceroba")
                    cutscene:hideNametag()
                else
                    cutscene:showNametag("Ceroba")
                    cutscene:text("* I guess a little walk wouldn't hurt right now.", "closed_eyes", "ceroba")
                    cutscene:hideNametag()
                    Game:addPartyMember("ceroba")
                    ceroba:resetSprite()
                    ceroba:convertToFollower()
                    cutscene:text("* Ceroba joined the party.")
                    Game:setFlag("ceroba_party", true)
                    Game:setFlag("ceroba_inparty", true)
                    Mod:unlockPartyMember("ceroba")
                end
            else
                cutscene:hideNametag()
                cutscene:text("* You decided not to disturb her.")
            end
        end
    end,
    exit = function(cutscene, event)
        ceroba = cutscene:getCharacter("ceroba")

        if Game:getFlag("ceroba_gavequest")==true and ceroba then
            cutscene:showNametag("Ceroba")
            cutscene:text("* You ready to leave?", "neutral", "ceroba")
            cutscene:text("* Just remember that we [color:red]won't be able to come back for a while[color:reset].", "closed_eyes", "ceroba")
            cutscene:hideNametag()
            local opinion = cutscene:choicer({"Yes", "No"})
            if opinion == 1 then
                cutscene:text("* Apologies, but this area isn't ready yet.\n-Nelle")
            else
                cutscene:showNametag("Ceroba")
                cutscene:text("* Just don't take too long,[wait:5] alright?", "neutral", "ceroba")
                cutscene:hideNametag()
            end
        else
            cutscene:text("* Shouldn't leave now.")
        end
        cutscene:walkTo(Game.world.player, Game.world.player.x, Game.world.player.y - 40, 0.5)
    end,
    saloonshop = function(cutscene, event)
        Game.world:lightShopTransition("saloon")
    end,
}
