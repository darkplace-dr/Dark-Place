local actor, super = Class(Actor, "alternatespam")

function actor:init(x, y)
    super.init(self, x, y)

    -- Display name (optional)
    self.name = "Alternate Spamton"

    -- Width and height for this actor, used to determine its center
    self.width = 29
    self.height = 50

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {4, 36, 21, 12}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = 0

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/alternatespam"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = ""

    -- Sound to play when this actor speaks (optional)
    self.voice = "altspamton"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        [""] = 0.2
    }

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor