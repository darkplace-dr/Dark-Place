return {
    spamgolor = function(cutscene, event)
        if Game:getFlag("spamgolor_defeated") ~= true then
            cutscene:text("* There appears to be a note here...")
            cutscene:text("* CURRENTLY OUT IN\n[[A room between]].", "", "spamgolor")
            cutscene:text("* COME CHECK BACK\n[[Coming soon]].", "", "spamgolor")
        else
            cutscene:text("* There appears to be a note here...")
            cutscene:text("* CURRENTLY [[Setting up wares]].", "", "spamgolor")
            cutscene:text("* WILL [[Open for business]] ON-", "", "spamgolor")
            cutscene:text("* The rest of the note is torn off.")
        end
    end
}
