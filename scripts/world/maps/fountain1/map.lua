local Fountain1, super = Class(Map)

function Fountain1:onEnter()
    Game.world:startCutscene("fountain1")
end

return Fountain1