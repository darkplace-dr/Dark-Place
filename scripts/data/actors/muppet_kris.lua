local actor, super = Class(Actor, "muppet_kris")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Kris"
    self.voice = "muppet_kris"
    -- Width and height for this actor, used to determine its center
    self.width = 30
    self.height = 36

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 0, 30, 36}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = 0

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/muppet_kris"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Table of sprite animations
    self.animations = {
        ["idle"]               = {"idle", 1/5, false},
        ["talk"]                = {"talk", 1/5, true},
    }
    self.talk_sprites = {
        ["talk"] = 1/5,
    }
    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor