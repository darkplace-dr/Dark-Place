---@class SavepointUT : Savepoint
---@overload fun(...) : SavepointUT
local SavepointUT, super = Class(Savepoint)

function SavepointUT:init(data)
    super.init(self, data.center_x, data.center_y, Utils.merge(data.properties, { light = true }))
end

return SavepointUT