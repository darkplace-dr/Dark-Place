local actor, super = Class(Actor, "ceroba_dark_transition")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Ceroba"

    -- Width and height for this actor, used to determine its center
    self.width = 26
    self.height = 54

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/ceroba/dark_transition"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "run"
end

return actor