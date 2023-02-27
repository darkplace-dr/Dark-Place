return {
	chan = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local krischan = cutscene:getCharacter("krischan")
		cutscene:showNametag("Kris-Chan")
		cutscene:text("* Go! Sonichu! Go out and zap to the extreme!")
		cutscene:text("* Sonichu! Use EXPLOSION!!!")
		cutscene:hideNametag()
        krischan:explode()
        cutscene:wait(3)
		cutscene:showNametag("Susie")
        cutscene:setSpeaker(susie)
        cutscene:text("* What?", "shock")
		cutscene:hideNametag()
	end,

    poseur = function(cutscene, event)
        cutscene:text("* It's a mannequin.[wait:10] Do you want to fight it?")
        opinion = cutscene:choicer({"Yes", "No"}) == 1
        if opinion then
            local poseur = cutscene:getEvent(14)
            cutscene:startEncounter("poseur", true, {{"poseur", poseur}})
            cutscene:wait(2)
            poseur:explode()
            cutscene:wait(5)
            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "nervous_side", "susie")
                cutscene:text("* That was weird.", "nervous", "susie")
                cutscene:hideNametag()
            end
        end
    end
}
