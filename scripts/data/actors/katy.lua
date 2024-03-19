local actor, super = Class(Actor, "katy")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "Katy"

    -- Width and height for this actor, used to determine its center
    self.width = 18
    self.height = 37

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	self.hitbox = {0, 16, 18, 20}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {38/255, 27/255, 30/255}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/katy"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "kat"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/katy"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-12, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
		["down"]               = {"down", 4/30, true},
		["jump"]               = {"jump", 4/30, true},
		["land"]               = {"land", 4/30, true},
		
		["hand_shoulder"]      = {"hand_shoulder", 4/30, false},
		
		["slide"]      		   = {"slide", 4/30, false},
		
		["sit_look_left"] 	    = {"sit_look_left", 1/8, false},
		["sit_look_right"] 	    = {"sit_look_right", 1/8, false},
	}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},
		
        ["down"] = {0, 10},
        ["jump"] = {0, 0},
        ["land"] = {0, 0},
		
        ["hand_shoulder"] = {0, 0},
		
        ["slide"] = {0, 0},
		
        ["sit_look_left"] = {0, 9},
        ["sit_look_right"] = {0, 9},
    }
end

return actor