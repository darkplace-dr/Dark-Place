local actor, super = Class(Actor, "jamm_lw_hurt")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Jamm"

    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 41

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {3, 28, 13, 10}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/jamm/light"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk_shadowed"

    -- Sound to play when this actor speaks (optional)
    self.voice = "jamm"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/jamm"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-19,-3}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Movement animations
        ["slide"]               = {"slide", 4/30, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk_shadowed/left"] = {0, 0},
        ["walk_shadowed/right"] = {0, 0},
        ["walk_shadowed/up"] = {0, 0},
        ["walk_shadowed/down"] = {0, 0},

        ["slide"] = {0, 0},
    }

    self.mirror_sprites = {
        ["walk_shadowed/down"] = "walk_shadowed/up",
        ["walk_shadowed/up"] = "walk_shadowed/down",
        ["walk_shadowed/left"] = "walk_shadowed/left",
        ["walk_shadowed/right"] = "walk_shadowed/right",
    }
end

return actor