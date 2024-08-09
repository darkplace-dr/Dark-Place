return {
    spamgolor = function(cutscene, event)
        if not Game:getFlag("spamgolor_defeated") then
            cutscene:text("* There appears to be a note here...")
            cutscene:text("* CURRENTLY OUT IN\n[[A room between]].", "", "spamgolor")
            cutscene:text("* COME CHECK BACK\n[[Coming soon]].", "", "spamgolor")
        else
            cutscene:text("* The door appears to be unlocked.")
            cutscene:text("* Will you go inside?")
            if cutscene:choicer({"Yes", "No"}) == 1 then
                Game.world:shopTransition("spamgolor", { marker="door1", facing="down" })
            end
        end
    end,

    diamond_store = function(cutscene, event)
        Game.world:shopTransition("diamond_store")
    end,

    --"* \"Life is designed to knock you down.[wait:5] Just get back up.\""

    warp_codes = function(cutscene, event)
        cutscene:text("* There appears to be some advertisements for codes here.")

        cutscene:text("* (Go to the code \"[color:yellow]SPAM[color:pink]ROOM[color:reset]\"! It's where all the [BIG SHOT]s are!)")

        cutscene:text("* (yo whaddup. go to \"[color:red]DESSHERE[color:reset]\".)")

        cutscene:text("* (Want to fight bosses you've previously fought?[wait:10]\nGo to \"[color:yellow]BOSSRUSH[color:reset]\"!)")

        cutscene:text("* (Want to meet the devs of this game? Check out \"[color:blue]DEVDINER[color:reset]\"!)")

        cutscene:text("* (Do you have horrible internet? Visit \"[color:black]WIFIDOWN[color:reset]\" now to resolve all of your network troubles!)")

        cutscene:text("* (Check out the Dark Place X \"[color:#5fcde4]GARRYMOD[color:reset]\" crossover!\nMods included!)")

        cutscene:text("* (Want to play some games? Check out the newly opened \"[color:blue]DARKCADE[color:white]\"!)")

        cutscene:text("* (Visit the Wild East in \"[color:ff7800]WILDEAST[color:reset]\"!)")

        cutscene:text("* (Hello! Go to \"[color:red]SLIDER[color:reset]\" for lotsa fun!)")

        cutscene:text("* It looks like until someone posts another ad,[wait:10] that's all there is here.")
    end,

    katana0 = function (cutscene, event)
        cutscene:text("* The door is unlocked.[wait:10] Go inside?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            cutscene:text("* Lucy put the warp here please")
        end
    end
}

