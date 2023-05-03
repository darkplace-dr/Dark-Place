local actor, super = Class(Actor, "ostarwalker")

function actor:init()
    -- Display name (optional)
    self.name = "Starwalker"

    -- Width and height for this actor, used to determine its center
    self.width = 29
    self.height = 40

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {4, 25, 21, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    -- APPARENTLY this is optional, but I get a crash if it's not set. sooooooo...
    self.flip = "left"

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/osw/dark"
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

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["battle/idle"]         = {"battle/idle", 0.2, true},
        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {self.default.."/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

        -- specific act animations
        ["battle/dance"]        = {"battle/actdance", 1/5, true},
        ["battle/takecare"]     = {"battle/actnurse", 0, false}

    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- walk sprites are WEIRD for this guy and I don't know why.
        ["walk/right"] = {5, 0},
        ["walk/left"] = {2, 0},
        ["battle/attackready"] = {0, -6},
        ["battle/attack"] = {0, -6},
        ["battle/spellready"] = {-14, 1},
        ["battle/spell"] = {-10, -13},
        ["battle/item"] = {0, -3},
        ["battle/defend"] = {-19, -6},
        ["battle/hurt"] = {-4, -3},
        ["battle/defeat"] = {-1, 10}
    }
end

-- Function overrides go here

return actor