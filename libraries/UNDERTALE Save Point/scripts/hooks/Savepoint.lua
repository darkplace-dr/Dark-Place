---@class Savepoint : Event
---@overload fun(...) : Savepoint
local Savepoint, super = Class("Savepoint", true)

function Savepoint:init(x, y, properties)
    super.init(self, x, y, properties)

    local light = properties["light"] or Game:isLight()
    if light then
        self:setSprite("world/events/savepointut", 1/2)
    end
end

return Savepoint