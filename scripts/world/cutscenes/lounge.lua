return {
   rightsign = function(cutscene, event)
        if Game:getFlag("rightsign_read") then
            cutscene:text("* Never again.")
            return
        end
        Game:setFlag("rightsign_read", true)
        cutscene:text("* The sign reads: 'i have a gun and im gonna shoot you lol'.")
        if cutscene:getCharacter("dess") then
            cutscene:showNametag("Dess")
            cutscene:text("* bro what", "wtf_b", "dess")
        end
        if cutscene:getCharacter("susie") then
            cutscene:showNametag("Susie")
            cutscene:text("* Wait, what?", "sus_nervous", "susie")
        end
		if cutscene:getCharacter("jamm") then
			cutscene:showNametag("Jamm")
            cutscene:text("* How would a sign have a gun?", "neutral", "jamm")
		end
        if cutscene:getCharacter("brenda") then
            cutscene:showNametag("Brenda")
            cutscene:text("* I don't think it means anything.", "frown_side", "brenda")
        end
        if cutscene:getCharacter("dess") then
            cutscene:showNametag("Dess")
            cutscene:text("* OH SHIT BEHIND US", "wtf_b", "dess")
            cutscene:hideNametag()
            cutscene:startEncounter("gunman", true)
            return
        end
        if cutscene:getCharacter("brenda") then
            cutscene:showNametag("Brenda")
            cutscene:text("* TURN AROUND", "shock", "brenda")
        end
        cutscene:hideNametag()
        cutscene:startEncounter("gunman", true)
    end
}
