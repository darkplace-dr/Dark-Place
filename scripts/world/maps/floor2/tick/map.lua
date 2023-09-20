local Tick, super = Class(Map)

function Tick:onEnter()
    if Game:getFlag("gone_tick") then
        Game.world:startCutscene("tick_cutscenes", "removetick")
    end
end

return Tick