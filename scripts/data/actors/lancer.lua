local actor, super = Class(Actor, "lancer")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Lancer"

    -- Width and height for this actor, used to determine its center
    self.width = 36
    self.height = 35

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {7, 20, 22, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}
	
    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/lancer"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "lancer"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/lancer"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-10, -5}

    -- Table of sprite animations
    self.animations = {
        ["wave"] = {"wave", 0.05, false},
        ["up_flip"] = {"up_flip", 0.1, true},
        ["sleep"] = {"sleep", 0.25, true},
        ["stone"] = {"stone", 0, true},
        ["highfive"] = {"highfive", 0.08, false},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
		
        ["highfive"] = {-8, -23},
        ["wave"] = {-2, -3},
        ["sleep"] = {-2, 6},
    }
end

return actor