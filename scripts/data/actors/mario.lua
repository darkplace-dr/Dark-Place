local actor, super = Class(Actor, "mario")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "SMG4 Mario"

    -- Width and height for this actor, used to determine its center
    self.width = 16
    self.height = 32

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {1, 23, 14, 9}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/mario"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "mario"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/mario"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-19,-3}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Movement animations
        ["slide"]               = {"slide", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.1, true},
        ["battle/low_health"]   = {"battle/low_hp", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/30, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false},
        ["battle/item"]         = {"battle/item", 1/15, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/spare", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 0.5, true},

        ["battle/transition"]   = {"walk/right", 0.2, true},
        ["battle/intro"]        = {"battle/attack", 1/15, true},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},

        ["slide"] = {6, 2},

        -- Battle offsets
        ["battle/idle"] = {0, 0},
        ["battle/low_health"] = {0, 0},

        ["battle/attack"] = {-19, -19},
        ["battle/attackready"] = {-17, 2},
        ["battle/act"] = {0, 0},
        ["battle/item"] = {0, 0},
        ["battle/itemready"] = {0, 0},
        ["battle/defend"] = {0, 0},

        ["battle/defeat"] = {-7, 13},
        ["battle/hurt"] = {-1, 1},

        ["battle/intro"] = {-19, -19},
        ["battle/victory"] = {1, 0},
    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }
	
	self.taunt_sprites = {"pose_ready", "pose_star", "pose_t"}

        -- Walk Speed (optional)
        self.walk_speed_override = 16
end

return actor