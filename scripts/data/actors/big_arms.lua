local actor, super = Class(Actor, "big_arms")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Big Arms"

    -- Width and height for this actor, used to determine its center
    self.width = 64
    self.height = 56

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "battle/enemies/eggman/phase_2"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
		-- Battle animations
        ["idle"]         = {"idle", 0.2, true},
        ["hurt"]         = {"hurt", 0.2, true},
        ["defeat"]         = {"defeat", 0.2, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
		["idle"] = {-60, 0},
		["hurt"] = {-60, 0},
		["defeat"] = {-60, 0},
	}
end

return actor