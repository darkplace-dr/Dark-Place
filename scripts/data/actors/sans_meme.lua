local actor, super = Class(Actor, "sans_meme")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "sans?"

    -- Width and height for this actor, used to determine its center
    self.width = 25
    self.height = 32

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 16, 25, 16}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/sans_meme"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "sans"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/sans"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {}
    

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["neutrals"] = {0, 0},
        ["pacifists"] = {0, 0},
        ["non_binary"] = {0, 0},
        ["transgender"] = {0, 0},
        ["forgor"] = {1, 0},
        ["lich"] = {0, -4},
    }
end

return actor