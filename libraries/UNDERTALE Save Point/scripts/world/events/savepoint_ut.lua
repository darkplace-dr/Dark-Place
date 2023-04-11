---@class SavepointUT : Savepoint
---@overload fun(...) : SavepointUT
local SavepointUT, super = Class(Savepoint)

function SavepointUT:init(data)
    super.init(self, data.x, data.y, data.properties)

    self:setSprite("world/events/savepointut", 1/2)
end

return SavepointUT