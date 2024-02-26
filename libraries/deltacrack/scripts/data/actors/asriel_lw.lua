local actor, super = Class(Actor, "asriel_lw")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Asriel"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 40

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 19, 20, 21}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/asriel/light"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "asriel"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/asriel_light"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-14, -4}

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
end

return actor