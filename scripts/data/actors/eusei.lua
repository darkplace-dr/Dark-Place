local actor, super = Class(Actor, "eusei")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Eusei"

    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 44

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {2, 31, 17, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/eusei/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "eusei"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/eusei"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-15, -10}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/spell", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"walk/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

        -- Cutscene animations
        ["hood"]                = {"hood", 0.25, true},
        ["pullhat"]             = {"pullhat", 0.25, true},
        ["removehood"]          = {"removehood", 0.25, false, next="walk/down"},
        ["reveal"]              = {"reveal", 0.3, false},
        ["sing"]                = {"sing", 0.4, true},
        ["sit"]                 = {"sit", 0.1, false},

    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",

        ["walk_blush/down"] = "walk_blush/up",
        ["walk_blush/up"] = "walk_blush/down",
        ["walk_blush/left"] = "walk_blush/left",
        ["walk_blush/right"] = "walk_blush/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},

        ["walk_blush/down"] = {0, 0},
        ["walk_blush/left"] = {0, 0},
        ["walk_blush/right"] = {0, 0},
        ["walk_blush/up"] = {0, 0},

        -- Battle offsets
        ["battle/idle"] = {-7, -2},

        ["battle/attack"] = {-11, -3},
        ["battle/attackready"] = {-11, -3},
        ["battle/act"] = {-3, -2},
        ["battle/actend"] = {-3, -2},
        ["battle/actready"] = {-3, -2},
        ["battle/spell"] = {-12, -2},
        ["battle/spellready"] = {-12, -2},
        ["battle/item"] = {-8, -10},
        ["battle/itemready"] = {-8, -10},
        ["battle/defend"] = {0, -2},

        ["battle/defeat"] = {-3, -2},
        ["battle/hurt"] = {-13, -2},

        ["battle/intro"] = {-7, -4},
        ["battle/victory"] = {-3, -2},

        -- Cutscene offsets
        ["hood"] = {-2, -1},
        ["pullhat"] = {-1, -2},
        ["removehood"] = {-2, -1},
        ["reveal"] = {-2, -2},
        ["sing"] = {-10, -2},
        ["sit"] = {0, 0},
        ["shock"] = {-17, -4}
    }
end

return actor