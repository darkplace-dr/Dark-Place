local actor, super = Class(Actor, "sam")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Sam"

    -- Width and height for this actor, used to determine its center
    self.width = 39
    self.height = 38

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 0, 39, 38}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/sam"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "sam"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/sam"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-10, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false
end

return actor