local actor, super = Class(Actor, "dina_shop")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Dina"

    -- Width and height for this actor, used to determine its center
    self.width = 113
    self.height = 104

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = nil

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "shopkeepers/dina"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "body"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["body"] =            {"body", 1/6, true},
        ["face"] =            {"face", 0.8, true},
        ["face_eyesclosed"] = {"face_eyesclosed", 0.8, true},
        ["face_pout"] =       {"face_pout", 0.8, true},
        ["face_smirk"] =      {"face_smirk", 0.8, true},
        ["face_wink"] =       {"face_wink", 0.8, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["body"] = {0, 0},
        ["face"] = {0, 0},
        ["face_eyesclosed"] = {0, 0},
        ["face_pout"] = {0, 0},
        ["face_smirk"] = {0, 0},
        ["face_wink"] = {0, 0},
    }
end

return actor
