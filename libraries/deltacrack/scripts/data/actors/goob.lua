local actor, super = Class(Actor, "goob")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Goob"

    self.bench_sprite = "goob_dark"
    self.bench_x = 0
    self.bench_y = 0

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 38

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 24, 20, 13}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {184/255, 63/255, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/goob/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/goob"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-6,0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Movement animations
        ["slide"]               = {"slide", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/act", 1/15, false},
        ["battle/item"]         = {"battle/act", 1/15, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attack_ready", 0.2, true},
        ["battle/act_ready"]    = {"battle/idle", 0.2, true},
        ["battle/spell_ready"]  = {"battle/idle", 0.2, true},
        ["battle/item_ready"]   = {"battle/idle", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/idle", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"battle/transition", 0.2, true},
        ["battle/intro"]        = {"battle/intro", 0.1, false},
        ["battle/victory"]      = {"battle/victory", 1/10, true},

        -- Cutscene animations
        ["jump_fall"]           = {"fall", 1/5, true},
        ["jump_ball"]           = {"ball", 1/15, true},
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
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},

        ["walk_blush/down"] = {0, 0},

        ["slide"] = {0, 0},

        -- Battle offsets
        ["battle/idle"] = {0, 0},
        ["battle/act"] = {-7, -5},
        ["battle/attack"] = {-7, -5},
        ["battle/attack_ready"] = {-7, -5},

        ["battle/defeat"] = {-6, -5},
        ["battle/hurt"] = {-16, -5},

        ["battle/intro"] = {0, 0},
        ["battle/victory"] = {0, 0},

        -- Cutscene offsets
        ["pose"] = {-4, -2},

        ["fall"] = {-5, -6},
        ["ball"] = {0, 0},
        ["landed"] = {-4, -2},

        ["fell"] = {-14, 1},

        ["sword_jump_down"] = {-19, -5},
        ["sword_jump_settle"] = {-27, 4},
        ["sword_jump_up"] = {-17, 2},

        ["hug_left"] = {-4, -1},
        ["hug_right"] = {-2, -1},

        ["peace"] = {0, 0},
        ["rude_gesture"] = {0, 0},

        ["reach"] = {-3, -1},

        ["sit"] = {-3, 0},

        ["t_pose"] = {-4, 0},
    }
end

return actor