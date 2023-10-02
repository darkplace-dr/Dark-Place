local actor, super = Class(Actor, "werewire_ow")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "Werewire"

    -- Width and height for this actor, used to determine its center
    self.width = 0
    self.height = 0

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {-13, -32, 27, 35}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = "right"

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/werewire"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "overworld"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["overworld"] = {"overworld", 5/30, true}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["overworld"]  = {-16, -267},
    }
end

return actor