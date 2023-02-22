local actor, super = Class(Actor, "grounder")

function actor:init()
    super.init(self)

    self.name = "Grounder"

    self.width = 35
    self.height = 40

    self.hitbox = {3, 24, 24, 16}

    self.flip = "right"

    self.path = "enemies/grounder"
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
        ["spared"] = {-6, 5},
        ["hurt"] = {-8, -2},
    }
end

return actor