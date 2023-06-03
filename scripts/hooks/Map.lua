---@class Map_override : Map
---@overload fun(...) : Map
local Map, super = Class(Map)

function Map:init(world, data)
    super.init(self, world, data)

    self.omori = data and data.properties and data.properties["omori"] or false
end

return Map