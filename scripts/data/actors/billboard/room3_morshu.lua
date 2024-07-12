local actor, super = Class(Actor)

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Morshu (room3 full-screen animations)"

    -- Width and height for this actor, used to determine its center
    self.width = 320
    self.height = 240

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/cutscenes/room3_morshu/morshu"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "rubies"

    -- Table of sprite animations
    self.animations = {
        ["rubies"] = {"rubies", 0.095, false},
        ["richer"] = {"richer", 0.095, false},
        ["dance"] = {"dance", 0.0001, true},
        ["dance_svfx"] = {"dance", 0.05, true},
        ["menacing"] = {"menacing", 1, false},
    }
end

return actor