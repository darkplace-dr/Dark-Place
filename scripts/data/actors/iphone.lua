local actor, super = Class(Actor, "iphone")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "iPhone7P"

    -- Width and height for this actor, used to determine its center
    self.width = 27
    self.height = 52

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 29, 27, 23}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/iphone/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "iphone"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/iphone"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-12, -10}

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

        ["battle/transition"]   = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

        -- Cutscene animations
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {0, 0},
        ["walk/up"] = {0, 0},

        -- Battle offsets
        ["battle/idle"] = {0, 0},

        ["battle/attack"] = {0, 0},
        ["battle/attackready"] = {0, 0},
        ["battle/act"] = {0, 0},
        ["battle/actend"] = {0, 0},
        ["battle/actready"] = {0, 0},
        ["battle/spell"] = {0, 0},
        ["battle/spellready"] = {0, 0},
        ["battle/item"] = {0, 0},
        ["battle/itemready"] = {0, 0},
        ["battle/defend"] = {0, 0},

        ["battle/defeat"] = {0, 0},
        ["battle/hurt"] = {0, 0},

        ["battle/intro"] = {0, 0},
        ["battle/victory"] = {0, 0},

        -- Cutscene offsets
        ["peace"] = {0 + 8, 0},
    }
end

return actor