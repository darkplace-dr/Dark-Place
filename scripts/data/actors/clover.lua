local actor, super = Class(Actor, "clover")

function actor:init()
    super.init(self)
	
    -- Display name (optional)
    self.name = "Clover"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 31

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = {10, 24}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {255, 255, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/clover"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false
end

return actor