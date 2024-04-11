local actor, super = Class(Actor, "wing_gaster")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Wing Gaster"

    -- Width and height for this actor, used to determine its center
    self.width = 21
    self.height = 52

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 42, 21, 10}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/wing_gaster"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "wingding_3"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false
	

    self.animations = {
        ["walk/down"]    = {"walk/down", 0, false},
        ["walk/up"]    = {"walk/up", 0, false},
        ["walk/left"]    = {"walk/left", 0, false},
        ["walk/right"]    = {"walk/right", 0, false},
        ["fall"]    = {"fall", 0.1, false},
    }

    self.offsets = {
    }
end

return actor