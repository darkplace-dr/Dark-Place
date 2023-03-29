return {
    spamgolor = function(cutscene, event)
        if Game:getFlag("spamgolor_defeated") ~= true then
            cutscene:text("* There appears to be a note here...")
            cutscene:text("* CURRENTLY OUT IN\n[[A room between]].", "", "spamgolor")
            cutscene:text("* COME CHECK BACK\n[[Coming soon]].", "", "spamgolor")
        else
            cutscene:text("* The door appears to be unlocked.")
            cutscene:text("* Will you go inside?")
            local opinion = cutscene:choicer({"Yes", "No"}, options)
            if opinion == 1 then
                cutscene:text("aaaaaaaa it's late i'll actually add this tomorrow")
                cutscene:text("just use the debug menu to open the shop")
            end
        end
    end
}
