local actor, super = Class(Actor, "soapton")

function actor:init(x, y)
    super.init(self, x, y)

    -- Display name (optional)
    self.name = "Soapton"

    -- Width and height for this actor, used to determine its center
    self.width = 22
    self.height = 20

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 6, 22, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = 0

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/soapton"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = ""

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor