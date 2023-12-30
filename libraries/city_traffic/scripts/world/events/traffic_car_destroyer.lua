---@class TrafficCarDestroyer : Event
---@overload fun(...) : TrafficCarDestroyer
local TrafficCarDestroyer, super = Class(Event)

function TrafficCarDestroyer:init(data)
    super.init(self, data)
    data.properties = data.properties or {}
end


function TrafficCarDestroyer:update()
    Object.startCache()
    for _, car in ipairs(Game.world.cars) do
        if car:collidesWith(self) then
            car:remove()
            break
        end
    end
    Object.endCache()

    super.update(self)
end


return TrafficCarDestroyer