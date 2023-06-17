local Start, super = Class(Map)

function Start:onEnter()
    Game.stage:addFX(VHSFilter(), "vhs")
end

function Start:onExit()
    Game.stage:removeFX("vhs")
end

return Start