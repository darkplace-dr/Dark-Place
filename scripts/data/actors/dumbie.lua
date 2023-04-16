local actor, super = Class(Actor, "dumbie")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Dumbie"

    -- Width and height for this actor, used to determine its center
    self.width = 17
    self.height = 28

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {5, 17, 12, 11}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/dumbie"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "dumbie"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/dumbie"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor