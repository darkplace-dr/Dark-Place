local actor, super = Class(Actor, "doobie")

function actor:init(x, y)
    super.init(self, x, y)

    -- Display name (optional)
    self.name = "Ralsei?"

    -- Width and height for this actor, used to determine its center
    self.width = 50
    self.height = 58

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {26, 38, 22, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/doobie"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "ralsei"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/doobie"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-15, -10}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["dance"] = {"dance", 0.01, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["dance"] = {23, 15},
    }
end

return actor