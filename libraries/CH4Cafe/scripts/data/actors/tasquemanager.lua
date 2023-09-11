local actor, super = Class(Actor, "tasquemanager")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Tasque Manager"

    -- Width and height for this actor, used to determine its center
    self.width = 44
    self.height = 70

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {11, 41, 30, 28}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0.6}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/tasquemanager"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "sing"
	
	self.animations = {
	        ["sing"]               = {"sing", 4/30, true}
	}
end

return actor