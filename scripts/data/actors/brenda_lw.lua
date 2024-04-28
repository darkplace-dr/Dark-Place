local actor, super = Class(Actor, "brenda_lw")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Brenda"

    -- Width and height for this actor, used to determine its center
    self.width = 26
    self.height = 46

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {4, 34, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/brenda/light"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "brenda"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/brenda"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-30, -15}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {}

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}

    self.taunt_sprites = {"box"}
end

return actor