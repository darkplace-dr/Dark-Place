local actor, super = Class(Actor, "queen")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Queen"

    -- Width and height for this actor, used to determine its center
    self.width = 16
    self.height = 63

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {-1, 51, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/queen"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "queen"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/queen"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {0, 0}

    -- Table of sprite animations
    self.animations = {
        -- Cutscene animations
        ["laugh"]               = {"laugh", 4/30, true},

        ["climb"]               = {"climb", 4/30, true},

        ["point_left"]          = {"point_left", 2/30, false},
        ["point_right"]         = {"point_right", 2/30, false},

        ["stupid_run_left"]     = {"stupid_run_left", 1/9, true},
        ["stupid_run_right"]    = {"stupid_run_right", 1/9, true},

        ["drunk_laugh"]         = {"drunk_laugh", 4/30, true},
        ["drunk_laugh_noglass"] = {"drunk_laugh_noglass", 4/30, true},

        ["drunk_smash"]         = {"drunk_smash", 4/30, false},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {-8, -1},
        ["walk/left"] = {-5, 0},
        ["walk/right"] = {-12, 0},
        ["walk/up"] = {-11, 0},

        ["walk_unhappy/down"] = {-8, -1},
        ["walk_unhappy/left"] = {-5, 0},
        ["walk_unhappy/right"] = {-12, 0},
        ["walk_unhappy/up"] = {-11, 0},

        ["walk_drunk/down"] = {-18, -1},
        ["walk_drunk/left"] = {-13, 0},
        ["walk_drunk/right"] = {-12, 0},
        ["walk_drunk/up"] = {-11, 0},

        -- Cutscene offsets
        ["laugh"] = {-11, -6},

        ["shocked"] = {-11, -2},

        ["stealth"] = {-22, -4},
        ["stealth_mad"] = {-22, -4},

        ["climb"] = {-12, -8},

        ["point_left"] = {-19, 0},
        ["point_right"] = {-12, 0},

        ["stupid_run_right"] = {-25, -7},
        ["stupid_run_left"] = {-24, -7},

        ["drunk_left"] = {-12, 0},
        ["drunk_right"] = {-12, 0},
        ["drunk_down"] = {-19, 1},

        ["drunk_laugh"] = {-10, -4},
        ["drunk_laugh_noglass"] = {-10, -4},

        ["drunk_smash"] = {-39, -17}
    }
end

return actor