---@class billboard : Event
---@overload fun(...) : billboard
local billboard, super = Class(Event)

function billboard:init(data)
    super.init(self, data)

    self:setOrigin(0.5, 0.5)
    self:setSprite("objects/billboard", 1/4)

    self.solid = true
end


return billboard