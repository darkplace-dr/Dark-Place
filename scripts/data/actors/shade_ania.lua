local actor, super = Class(Actor, "shade_ania")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Ania???"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 39

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "battle/enemies/shade_ania"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "jamm"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/jamm"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-19,-3}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
		-- Battle animations
        ["idle"]         = {"idle", 0.2, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["idle"] = {-5, -1},
    }
end

return actor