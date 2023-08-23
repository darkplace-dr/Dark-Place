local actor, super = Class(Actor, "queen_speakers")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Queen"

    -- Width and height for this actor, used to determine its center
    self.width = 153
    self.height = 102

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 33, 153, 60}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/queen"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "speakers"

    -- Sound to play when this actor speaks (optional)
    self.voice = "queen"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/queen"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {0, 0}

    self.animations = {
        -- Cutscene animations
        ["speakers"]               = {"speakers", 0.2, true},
    }
	
    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor