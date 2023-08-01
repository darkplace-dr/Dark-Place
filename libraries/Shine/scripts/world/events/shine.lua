---@class shine : Event
---@overload fun(...) : shine
local shine, super = Class(Event)

function shine:init(x, y, width, height)
    super.init(self, x, y, width, height)

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/shine", 1/4)

    self.solid = true
end

return shine