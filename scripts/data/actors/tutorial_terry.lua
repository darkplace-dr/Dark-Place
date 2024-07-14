local actor, super = Class(Actor, "tutorial_terry")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "Tutorial Terry"

    -- Width and height for this actor, used to determine its center
    self.width = 32
    self.height = 32

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	self.hitbox = {0, 0, 32, 32}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {38/255, 27/255, 30/255}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/tutorial_terry"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-12, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
		["rocket"] 	    = {"rocket", 1/8, false},
	}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor