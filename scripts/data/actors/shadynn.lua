local actor, super = Class(Actor, "shadynn")

function actor:init()
    super.init(self)

    self.name = "Shadynn"

    self.width = 35
    self.height = 40

    self.hitbox = {3, 24, 24, 16}

    self.flip = "right"

    self.path = "battle/enemies/shadynn"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", 0.25, true},
        ["tired"] = {"tired", 0.25, true},
        ["hurt"] = {"hurt", 0, false}
    }

    self.offsets = {
        ["idle"] = {-6, 5},
        ["tired"] = {-6, 5},
        ["hurt"] = {-1, -1},
    }
end

return actor