local actor, super = Class(Actor, "alseri")

function actor:init()
    super.init(self)
    
    -- Display name (optional)
    self.name = "Alseri"

    -- Width and height for this actor, used to determine its center
    self.width = 23
    self.height = 43

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {2, 31, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/alseri/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "ralsei"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/alseri"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-15, -10}

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
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/spell", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        --["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"walk/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

         -- Cutscene animations
         ["jump_fall"]           = {"fall", 1/5, true},
         ["jump_ball"]           = {"ball", 1/15, true},
 
         ["laugh"]               = {"laugh", 4/30, true},
 
    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",

        ["walk_unhappy/down"] = "walk_unhappy/up",
        ["walk_unhappy/up"] = "walk_unhappy/down",
        ["walk_unhappy/left"] = "walk_unhappy/left",
        ["walk_unhappy/right"] = "walk_unhappy/right",
        
        ["walk_angry/down"] = "walk_angry/up",
        ["walk_angry/up"] = "walk_angry/down",
        ["walk_angry/left"] = "walk_angry/left",
        ["walk_angry/right"] = "walk_angry/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
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
        ["battle/defend"] = {-3, -2},

        ["battle/defeat"] = {-3, -2},
        --["battle/hurt"] = {-13, -2}, -- does this exist?

        ["battle/intro"] = {-3, -2},
        ["battle/victory"] = {-3, -2},

        -- Cutscene offsets
        ["pose"] = {-1, -1},

        ["ball"] = {0, 9},
        ["landed"] = {-2, 0},

        ["laugh"] = {-1, 0},

        ["shocked_behind"] = {-9, 3},
        ["surprised_down"] = {-5, -1},

        ["splat"] = {-15, 21},
        ["stool"] = {-11, 18},
        
        ["slide"] = {-2, 2}
    }
end


return actor