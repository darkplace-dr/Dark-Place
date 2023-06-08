local actor, super = Class(Actor, "frisk2")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Frisk"

    --[[
    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 41

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 21, 15}
    ]]

    -- Width and height for this actor, used to determine its center
    self.width = 32
    self.height = 47

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 26, 32, 23}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/frisk2/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "frisk"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/frisk"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-15, -7}

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

        ["battle/act_end"]      = {"battle/idle", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"battle/idle", 0.2, true},
        ["battle/intro"]        = {"battle/idle", 1/15, true},
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

        ["battle/attack"] = {-16, 3},
        ["battle/attackready"] = {-16, 3},
        ["battle/act"] = {-7, 10},
        ["battle/actready"] = {-7, 10},
        ["battle/actend"] = {-7, 10},
        ["battle/item"] = {-12, -5},
        ["battle/itemready"] = {-12, -5},
        ["battle/defend"] = {-5, 7},

        ["battle/defeat"] = {-8, 20},
        ["battle/hurt"] = {-5, 11},

        ["battle/intro"] = {-8, -9},
        ["battle/victory"] = {-3, 0}
    }
end

return actor