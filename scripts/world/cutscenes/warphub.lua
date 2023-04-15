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
    end
}
