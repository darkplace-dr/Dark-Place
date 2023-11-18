local actor, super = Class(Actor, "YOU_alchemy")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "YOU"

    -- Width and height for this actor, used to determine its center
    self.width = 28
    self.height = 41

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {7, 30, 14, 12}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/you/alchemy"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/act", 1/15, false},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 1/15, false},
        ["battle/spell_ready"]  = {"battle/actready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"walk/right", 0, true},
        ["battle/intro"]        = {"battle/intro", 1/18, true},
        ["battle/victory"]      = {"battle/victory", 1/10, false, duration=4, next="battle/victoryconcern"},
        ["battle/victoryconcern"] = {"battle/victoryconcern", 1/10, false},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {

        -- Battle offsets
        ["battle/idle"] = {-4, 3},

        ["battle/attack"] = {-8, -4},
        ["battle/attackready"] = {-8, -4},
        ["battle/act"] = {-10, -4},
        ["battle/actend"] = {-10, -4},
        ["battle/actready"] = {-10, -4},
        ["battle/item"] = {-15, 1},
        ["battle/itemready"] = {-15, 1},
        ["battle/defend"] = {-20, -10},

        ["battle/defeat"] = {-8, -5},
        ["battle/hurt"] = {-3, -4},

        ["battle/intro"] = {-8, -8},
        ["battle/victory"] = {-8, -6},
        ["battle/victoryconcern"] = {-8, 0},
    }
end

return actor