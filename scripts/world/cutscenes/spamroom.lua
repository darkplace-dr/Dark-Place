return {
    amogus = function(cutscene, event)
    local sus = cutscene:getCharacter("spamongus")
        if sus.interacted then
            cutscene:text("* Spamongus was the imposter.")
        end
        if not sus.interacted then
            sus:setAnimation("dead")
            Assets.playSound("amoguskill", 0.7, 1)
            sus.interacted = true
        end
    end,
    mandela = function(cutscene, event)
        cutscene:showNametag("Alternate Spamton")
        cutscene:text("* REMEMB3R TO FOLLOW THE [T.H.I.N.K] PRINCIPLE, YOU [Little Sponge]!!", "", "alternatespam")
        cutscene:hideNametag()
    end,
    poster = function(cutscene, event)
        cutscene:text("* (The poster is torn,[wait:5] revealing\na faded one underneath.)")
        cutscene:text("* BIG SHOT AUTOS![wait:5] TAKE A RIDE\nAROUND TOWN IN OUR SPECIAL")
        cutscene:text("* (The rest is cut off.)")
    end,
}