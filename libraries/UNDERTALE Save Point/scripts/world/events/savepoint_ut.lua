---@class SavepointUT : Savepoint
---@overload fun(...) : SavepointUT
local SavepointUT, super = Class(Savepoint)

function SavepointUT:init(x, y, properties)
    super.init(self, x, y, properties)

    self:setSprite("world/events/savepointut", 1/2)
end

return SavepointUT