local actor, super = Class(Actor, "goob_lw")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Goob"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 38

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 24, 20, 13}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/goob/light"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/goob_light"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-6,0}
    
    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        ["fallen"] = {"fallen", 0.25, false},
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["fallen"] = {-8, 22},
        ["familyguy_death"] = {-8, 24},
        ["fallen_b"] = {-8, 20},
    }
end

return actor