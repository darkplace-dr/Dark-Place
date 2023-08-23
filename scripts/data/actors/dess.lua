local actor, super = Class(Actor, "dess")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Dess"

    -- Width and height for this actor, used to determine its center
    self.width = 23
    self.height = 46

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {2, 33, 18, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/dess"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "dess"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/dess"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-12, -10}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Battle animations
        ["battle/idle"]          = {"battle/idle", 0.2, true},

        ["battle/attack"]        = {"battle/attack", 1/23, false},
        ["battle/act"]           = {"battle/act", 1/15, false},
        ["battle/spell"]         = {"battle/spell", 1/10, false, next="battle/idle"},
        ["battle/item"]          = {"battle/item", 1/18, false, next="battle/idle"},
        ["battle/spare"]         = {"battle/spell", 1/10, false, next="battle/idle"},

        ["battle/attack_ready"]  = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]     = {"battle/actready", 0.2, true, },
        ["battle/spell_ready"]   = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]    = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"]  = {"battle/defend", 1/15, false},

        ["battle/actend"]        = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]          = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]        = {"battle/defeat", 1/15, false},
		
		["battle/transition"]    = {"battle/transition", 1/15, false},
        ["battle/intro"]   		 = {"battle/intro", 1/15, false},
        ["battle/victory"]       = {"battle/victory", 1/10, false},
		
		["battle/snap"]          = {"battle/snap", 2/30, false, next="battle/idle"},
		["battle/spellsuper"]    = {"battle/spellsuper", 2/30, false, next="battle/spellsuperend"},
		["battle/spellsuperend"] = {"battle/spellsuperend", 2/30, true},

        -- Cutscene animations
        --["laugh"]               = {"laugh", 4/30, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {-4, 0},
        ["walk/right"] = {-4, 0},
        ["walk/left"] = {-4, 0},
        ["walk/up"] = {-4, 0},

        -- Battle offsets
        ["battle/idle"] = {-3, 0},

        ["battle/attack"] = {-4, 0},
        ["battle/attack_ready"] = {-4, 0},
        ["battle/act"] = {0, 0},
        ["battle/actend"] = {0, 0},
        ["battle/act_ready"] = {0, 0},
        ["battle/spell"] = {-3, 0},
        ["battle/spell_ready"] = {0, 0},
        ["battle/item"] = {-2, 0},
        ["battle/item_ready"] = {-2, 0},
        ["battle/defend"] = {-9, 0},

        ["battle/defeat"] = {0, 0},
        ["battle/hurt"] = {-9, 0},

        ["battle/transition"] = {-4, 0},
        ["battle/intro"] = {-4, 0},
        ["battle/victory"] = {-8, 0},
		
        ["battle/snap"] = {0, 0},
        ["battle/spellsuper"] = {0, 0},
        
        ["reddit_gold"] = {-20, -20},
        ["sonic_adventure"] = {-20, -10},
        ["bup"] = {-20, -10},
        ["beatbox"] = {-20, -10},
        ["angreh"] = {-20, -10},
        ["oc"] = {-20, -10},
        ["paneton"] = {-20, -10},
    }

    self.taunt_sprites = {"reddit_gold", "sonic_adventure", "bup", "beatbox", "angreh", "oc", "paneton"}
end

return actor
