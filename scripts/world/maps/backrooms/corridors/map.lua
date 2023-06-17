local Corridors, super = Class(Map)

function Corridors:onEnter()
    Game.stage:addFX(VHSFilter(), "vhs")
end

function Corridors:onExit()
    Game.stage:removeFX("vhs")
end

return Corridors