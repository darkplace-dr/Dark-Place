---@class DarkDoor : Event
---@overload fun(...) : DarkDoor
local DarkDoor, super = Class(Event)

function DarkDoor:init(data)
    super.init(self, data)

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/darkdoor_closed")
end

return DarkDoor