return {
    meet_noel = function(cutscene, event)
        -- Open textbox and wait for completion
        local noel = cutscene:getCharacter("noel")
        cutscene:setSpeaker(noel)

        local player = Game.save_name
        cutscene:text("[speed:0.24] * Yello dudes.", "neutral")
	cutscene:showNametag("Noel")
        cutscene:text("[speed:0.24] * I am Noel.", "neutral")
        cutscene:text("[speed:0.24] * Are you "..player.."?", "neutral")
        cutscene:text("[speed:0.24] * ...No?", "neutral")
        cutscene:text("[speed:0.24] * Nevermind.", "neutral")
        cutscene:text("[speed:0.24] * So, can you bring me\n   some food?", "neutral")
        cutscene:text("[speed:0.24] * # ' # ' # ' #", "neutral")
    end,
}
