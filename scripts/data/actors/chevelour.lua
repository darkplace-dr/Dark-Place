local actor, super = Class(Actor, "chevelour")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "chevelour"

    -- Width and height for this actor, used to determine its center
    self.width = 57
    self.height = 47

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 32, 31, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/chevelour"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "stand"

    -- Sound to play when this actor speaks (optional)
    self.voice = "chevelour"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["stand"] = {"stand", 1, true},
        ["idle"] = {"idle", 1, true},
        ["skate"] = {"skate", 0.1, true},
        ["hurt"] = {"hurt", 0.2, true},
        ["warning"] = {"warning", 1, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
    }
end

return actor