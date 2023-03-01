return {
	amogus = function(cutscene, event)
	    local sus = cutscene:getCharacter("spamongus")
        sus:setAnimation("dead")
        Assets.playSound("amoguskill", 0.7, 1)
    end,
	mandela = function(cutscene, event)
	    cutscene:text("* REMEMB3R TO FOLLOW THE [T.H.I.N.K] PRINCIPLE, YOU [Little Sponge]!!", "", "alternatespam")
    end,
	poster = function(cutscene, event)
	    cutscene:text("* (The poster is torn,[wait:5] revealing\na faded one underneath.)")
		cutscene:text("* BIG SHOT AUTOS![wait:5] TAKE A RIDE\nAROUND TOWN IN OUR SPECIAL")
		cutscene:text("* (The rest is cut off.)")
    end,
}