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
    self.color = {1, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/dumbie"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/dumbie"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-12, -10}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/23, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/10, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/18, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/spell", 1/10, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true, },
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/actend"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},
		
		["walk/right"]   = {"walk/right", 1/15, false},
        ["battle/intro"]   		= {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {-4, 0},
        ["walk/right"] = {-4, 0},
        ["walk/left"] = {-4, 0},
        ["walk/up"] = {-4, 0},

        -- Battle offsets
        ["battle/idle"] = {-3, 0},

        ["battle/attack"] = {5, 0},
        ["battle/attack_ready"] = {50, 0},
        ["battle/act"] = {5, -14},
        ["battle/actend"] = {-3, 0},
        ["battle/act_ready"] = {-3, 0},
        ["battle/spell"] = {5, -10},
        ["battle/spell_ready"] = {9, 6},
        ["battle/item"] = {5, -6},
        ["battle/item_ready"] = {5, -6},
        ["battle/defend"] = {5, 0},

        ["battle/defeat"] = {4, 0},
        ["battle/hurt"] = {0, 0},
        ["battle/intro"] = {0, -5},
        ["battle/victory"] = {5, -13},
    }
end

return actor