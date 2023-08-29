local actor, super = Class(Actor, "swatch")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Swatch"

    -- Width and height for this actor, used to determine its center
    self.width = 45
    self.height = 40

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {5, 24, 35, 16}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/swatch"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = ""
	
	self.animations = {
        [""] = {"", 1, true}
	}
end

return actor