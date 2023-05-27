local actor, super = Class(Actor, "charkis")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Charkis"

    -- Width and height for this actor, used to determine its center
    self.width = 25
    self.height = 41

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {4, 23, 17, 18}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {53/255, 198/255, 148/255}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/charkis/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "charkis"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/charkis"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {0, 0}

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
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/actready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"sword_jump_down", 0.2, true},
        ["battle/intro"]        = {"battle/attack", 1/15, true},
        ["battle/victory"]      = {"battle/victory", 1/10, false}
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
        ["battle/idle"] = {-5, -1},

        ["battle/attack"] = {-8, -6},
        ["battle/attackready"] = {-8, -6},
        ["battle/act"] = {-6, -6},
        ["battle/actend"] = {-6, -6},
        ["battle/actready"] = {-6, -6},
        ["battle/item"] = {-6, -6},
        ["battle/itemready"] = {-6, -6},
        ["battle/defend"] = {-5, -3},

        ["battle/defeat"] = {-8, -5},
        ["battle/hurt"] = {-5, -6},

        ["battle/intro"] = {-8, -9},
        ["battle/victory"] = {-3, 0}
    }
end

return actor