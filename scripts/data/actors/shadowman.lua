local actor, super = Class(Actor, "shadowman")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Shadowman"

    -- Width and height for this actor, used to determine its center
    self.width = 54
    self.height = 56

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 40, 60, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/shadowman"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

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