---@class shine : Event
---@overload fun(...) : shine
local shine, super = Class(Event)

function shine:init(data)
    super.init(self, data)

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/spr_shine", 1/4)

    self.solid = true
end


return shine