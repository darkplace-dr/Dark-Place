local actor, super = Class(Actor, "pk")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "PK"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 34

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	self.hitbox = {0, 16, 18, 20}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {38/255, 27/255, 30/255}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/pk"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "pk"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-12, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
	}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},
    }
end

return actor