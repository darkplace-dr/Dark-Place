local actor, super = Class(Actor, "whale")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Whale"

    -- Width and height for this actor, used to determine its center
    self.width = 640
    self.height = 240

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {1, 23, 14, 9}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/whale"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "fucking_whale"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}

    self.mirror_sprites = {}
	
	self.taunt_sprites = {}
end

return actor