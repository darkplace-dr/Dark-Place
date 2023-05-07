---@class Encounter
---@overload fun(...) : Encounter
local Encounter = Class("Encounter", true)

function Encounter:createSoul(x, y, color)
    local player = Game.party[1]
    if player:checkArmor("pizza_toque") then
        return ParrySoul(x, y, color)
    else
        return Soul(x, y, color)
    end
end

return Encounter