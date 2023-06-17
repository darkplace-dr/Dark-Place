---@class DarkDoor : Event
---@overload fun(...) : DarkDoor
local DarkDoor, super = Class(Event)

function DarkDoor:init(data)
    super.init(self, data)

    self:setSprite("world/events/darkdoor_closed")
end

return DarkDoor
