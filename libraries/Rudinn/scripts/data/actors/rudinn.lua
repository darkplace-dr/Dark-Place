local actor, super = Class(Actor, "rudinn")

function actor:init()
    super.init(self)

    self.name = "Rudinn"

    self.width = 35
    self.height = 40

    self.hitbox = {3, 24, 24, 16}

    self.flip = "right"

    self.path = "enemies/rudinn"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", 0.25, true},
        ["tired"] = {"tired", 0.25, true},
        ["spared"] = {"spared", 0.25, true},
        ["hurt"] = {"hurt", 0, false}
    }

    self.offsets = {
        ["idle"] = {-6, 5},
        ["tired"] = {-6, 5},
        ["spared"] = {-4, 5},
        ["hurt"] = {-1, -1},
    }
end

return actor