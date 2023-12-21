local actor, super = Class(Actor, "diamond_giant")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Diamond"
    self.voice = nil
    -- Width and height for this actor, used to determine its center
    self.width = 36
    self.height = 74

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 0, 36, 74}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = 0

    -- Path to this actor's sprites (defaults to "")
    self.path = "shopkeepers/diamond_giant"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "ow_idle"

    -- Table of sprite animations
    self.animations = {
        ["idle"]               = {"ow_idle", 1/5, false},
    }
    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end
return actor