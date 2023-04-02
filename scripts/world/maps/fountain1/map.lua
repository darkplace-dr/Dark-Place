local Fountain1, super = Class(Map)

function Fountain1:onEnter()
    Game.world:startCutscene("room_prefountain.fountain1")
end

return Fountain1