local actor, super = Class(Actor, "lancer")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Lancer"

    -- Width and height for this actor, used to determine its center
    self.width = 30
    self.height = 34

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {2, 20, 30, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 0, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/lancer/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "lancer"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/lancer"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Movement animations
        ["fall"]               = {"fall", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 0.06, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 0.05, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"battle/transition", 0.2, true},
        ["battle/intro"]        = {"battle/act", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

        ["battle/pray"]        = {"battle/pray", 1, true},
        ["battle/spell_special"]      = {"battle/spell_special", 0.07, true},

        -- Cutscene animations
        ["jump_ball"]           = {"ball", 1/15, true},
        ["wave"]                = {"wave", 0.07, false},
        ["laugh_left"]          = {"laugh_left", 0.07, true},
        ["laugh_right"]         = {"laugh_right", 0.07, true},
        ["laughmustache_left"]  = {"laughmustache_left", 0.07, true},
        ["laughmustache_right"] = {"laughmustache_right", 0.07, true},
        ["sleep"]               = {"sleep", 0.8, true},
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",

        ["walk_mustache/down"] = "walk/up",
        ["walk_mustache/up"] = "walk/down",
        ["walk_mustache/left"] = "walk/left",
        ["walk_mustache/right"] = "walk/right",

        ["walk_unhappy/down"] = "walk_unhappy/up",
        ["walk_unhappy/up"] = "walk_unhappy/down",
        ["walk_unhappy/left"] = "walk_unhappy/left",
        ["walk_unhappy/right"] = "walk_unhappy/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/left"] = {1, 0},
        ["walk/right"] = {-6, 0},
        ["walk/up"] = {0, -4},
        ["walk/down"] = {0, -5},

        ["walk_unhappy/left"] = {1, 0},
        ["walk_unhappy/right"] = {-6, 0},
        ["walk_unhappy/up"] = {0, -4},
        ["walk_unhappy/down"] = {0, -5},


        ["slide"] = {0, 0},

        -- Battle offsets
        ["battle/idle"] = {-5, 1},

        ["battle/attack"] = {-5, -20},
        ["battle/attackready"] = {-5, -20},
        ["battle/act"] = {-6, -6},
        ["battle/actend"] = {-6, -6},
        ["battle/actready"] = {-6, -6},
        --["battle/spell"] = {-30, -23},
        ["battle/spell"] = {-27, -33},
        ["battle/spellready"] = {-27, -33},
        ["battle/item"] = {-20, -10},
        ["battle/itemready"] = {-20, -10},
        ["battle/defend"] = {-24, -14},

        ["battle/defeat"] = {-14, 1},
        ["battle/hurt"] = {-3, -2},

        ["battle/intro"] = {-35, -35},
        ["battle/victory"] = {-6, -6},

        ["battle/pray"] = {-2, -5},
        ["battle/spell_special"] = {-6, -12},

        -- Cutscene offsets

        ["pose"] = {4, 0},
        ["wave"] = {-4, -4},
        ["sleep"] = {0, 3},
        ["laugh_left"] = {-1, -1},
        ["laugh_right"] = {-1, -1},
        ["laughmustache_left"] = {-1, -1},
        ["laughmustache_right"] = {-1, -1},

    }
end

return actor