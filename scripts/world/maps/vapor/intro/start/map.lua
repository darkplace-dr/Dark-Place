local Start, super = Class(Map)

function Start:onEnter()
Ozymandias
end

function Start:onExit()
    Game.stage:removeFX("vhs")
end

return Start