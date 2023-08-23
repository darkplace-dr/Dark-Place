local actor, super = Class(Actor, "marispam")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Mariton"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 35

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {-12, 24, 42, 12}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/marispam"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "omori"

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", 1, true},
        ["lean_left"] = {"lean_left", 1, true},
        ["lean_right"] = {"lean_right", 1, true}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor