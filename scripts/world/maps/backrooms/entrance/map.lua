local Entrance, super = Class(Map)

function Entrance:onEnter()
    Game.stage:addFX(VHSFilter(), "vhs")
end

function Entrance:onExit()
    Game.stage:removeFX("vhs")
end

return Entrance