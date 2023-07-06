---@class Map
local Map, super = Class("Map", true)

function Map:onExit()
    super.onExit(self)

    Mod.lastMap = self.id
end

return Map