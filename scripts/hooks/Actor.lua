---@class Actor_override : Actor
---@field taunt_sprites string[] A list of sprites to show when this actor taunts
local Actor, super = Class("Actor", true)

Mod:trace(1)
function Actor:init()
    super.init(self)

    Mod:trace(1)
    self.taunt_sprites = {}
end

function Actor:getTauntSprites() return self.taunt_sprites end

return Actor