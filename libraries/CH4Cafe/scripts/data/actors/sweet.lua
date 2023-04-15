local actor, super = Class(Actor, "sweet")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Sweet"

    -- Width and height for this actor, used to determine its center
    self.width = 34
    self.height = 43

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {8, 24, 20, 20}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/sweet"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "sing"
	
	self.animations = {
        ["sing"] = {"sing", 10/30, true}
	}
end

return actor