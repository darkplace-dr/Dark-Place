local actor, super = Class(Actor, "fake_jamm")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Jamm???"

    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 41

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/jamm/dark"
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

        -- Battle animations
        ["idle"]         = {"battle_shadowed/idle", 0.2, true},

        ["hurt"]         = {"battle_shadowed/hurt", 1/15, false, temp=true, duration=0.5},
        ["attack"]       = {"battle_shadowed/attack", 1/15, false},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},

        ["slide"] = {0, 0},

        -- Battle offsets
        ["idle"] = {-5, -1},
        ["hurt"] = {-5, -6},
		["attack"] = {-22, -1},
    }

    self.mirror_sprites = {
        ["walk_shadowed/down"] = "walk/up",
        ["walk_shadowed/up"] = "walk/down",
        ["walk_shadowed/left"] = "walk/left",
        ["walk_shadowed/right"] = "walk/right",
    }

    self.taunt_sprites = {"box"}
end

return actor