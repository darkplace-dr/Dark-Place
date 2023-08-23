local Slides, super = Class(Map)

function Slides:onEnter()
    Game.stage:addFX(VHSFilter(), "vhs")
end

function Slides:onExit()
    Game.stage:removeFX("vhs")
end

return Slides