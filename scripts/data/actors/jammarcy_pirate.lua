local actor, super = Class(Actor, "jammarcy_pirate")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "J+M"

    -- Width and height for this actor, used to determine its center
    self.width = 28
    self.height = 40

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {6, 32, 14, 8}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/jamm/withmarcy/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk_pirate"

    -- Sound to play when this actor speaks (optional)
    self.voice = "jamm"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/jamm"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-19,-3}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Movement animations
        ["slide"]               = {"slide_pirate", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle_pirate/idle", 0.2, true},
        ["battle/low_health"]   = {"battle_pirate/low_hp", 0.2, true},

        ["battle/attack"]       = {"battle_pirate/attack", 1/15, false},
        ["battle/act"]          = {"battle_pirate/act", 1/15, false},
        ["battle/spell"]        = {"battle_pirate/spell", 1/15, false},
        ["battle/item"]         = {"battle_pirate/item", 1/15, false, next="battle/idle"},
        ["battle/spare"]        = {"battle_pirate/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle_pirate/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle_pirate/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle_pirate/actready", 0.2, true},
        ["battle/item_ready"]   = {"battle_pirate/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle_pirate/defend", 1/15, false},

        ["battle/act_end"]      = {"battle_pirate/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle_pirate/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle_pirate/defeat", 0.5, true},

        ["battle/transition"]   = {"walk_pirate/right", 0.2, true},
        ["battle/intro"]        = {"battle_pirate/attack", 1/15, true},
        ["battle/victory"]      = {"battle_pirate/victory", 1/10, false},
		
		-- Cutscene animations
		["sit"]               	= {"sit", 4/30, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},

        ["slide_pirate"] = {0, -27},

        -- Battle offsets
        ["battle_pirate/idle"] = {-14, -15},
        ["battle_pirate/low_health"] = {-14, -15},

        ["battle_pirate/attack"] = {-14, -15},
        ["battle_pirate/attackready"] = {-14, -15},
        ["battle_pirate/act"] = {-14, -15},
        ["battle_pirate/actend"] = {-14, -15},
        ["battle_pirate/actready"] = {-14, -15},
        ["battle/spell"] = {-14, -15},
        ["battle_pirate/item"] = {-14, -15},
        ["battle_pirate/itemready"] = {-14, -15},
        ["battle_pirate/defend"] = {-14, -15},

        ["battle_pirate/defeat"] = {-14, -15},
        ["battle_pirate/hurt"] = {-14, -15},

        ["battle_pirate/intro"] = {-14, -15},
        ["battle_pirate/victory"] = {-14, -15},
		
		["sit"] = {4, -8},
    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    self.taunt_sprites = nil
end

function actor:getSoulOffset()
	return 13, 22
end

return actor