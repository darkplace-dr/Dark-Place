local actor, super = Class(Actor, "shadowman_player")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Shadowman"

    -- Width and height for this actor, used to determine its center
    self.width = 56
    self.height = 57

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {14, 26, 40, 30}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/shadowman_player"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "saxophone"
	
	self.animations = {
        ["saxophone"] = {"saxophone", 6/40, true}
	}
end

return actor