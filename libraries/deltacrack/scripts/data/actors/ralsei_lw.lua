local actor, super = Class(Actor, "ralsei_lw")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Ralsei"

    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 40

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {1, 28, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {114/255, 0, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/ralsei/light"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "ralsei"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/ralsei_light"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-15, -10}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Cutscene animations
        ["jump_fall"]           = {"fall", 1/5, true},
        ["jump_ball"]           = {"ball", 1/15, true},

        ["laugh"]               = {"laugh", 4/30, true},
        
        ["sit"]                 = {"sit", 0.1, false},
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",

        ["walk_unhappy/down"] = "walk_unhappy/up",
        ["walk_unhappy/up"] = "walk_unhappy/down",
        ["walk_unhappy/left"] = "walk_unhappy/left",
        ["walk_unhappy/right"] = "walk_unhappy/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},

        ["walk_unhappy/down"] = {0, 0},
        ["walk_unhappy/left"] = {0, 0},
        ["walk_unhappy/right"] = {0, 0},
        ["walk_unhappy/up"] = {0, 0},

        ["slide"] = {-2, 2},

        -- Cutscene offsets
        ["pose"] = {-1, -1},

        ["fall"] = {-10, 0},
        ["ball"] = {0, 9},

        ["laugh"] = {-1, 0},

        ["sit"] = {0,0},

        ["shocked_behind"] = {-9, 3},
        ["surprised_down"] = {-5, -1},

        ["splat"] = {-15, 21},
        ["stool"] = {-11, 18},
        
        ["fallen"] = {-12, 20}
    }
end

function actor:getDefault()
    if Game:getFlag("r_default", "normal") == "unhappy" then
        return "walk_unhappy"
    end
    return "walk"
end

return actor