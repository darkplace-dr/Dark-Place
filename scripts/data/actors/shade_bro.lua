local actor, super = Class(Actor, "shade_bro")

function actor:init()
    super.init(self)

    self.name = "Shade Bro"

    self.width = 41
    self.height = 38

    self.hitbox = {11, 23, 28, 15}

    self.flip = "right"

    self.path = "battle/enemies/shade_bro"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", 0.1, true},
        ["hurt"] = {"hurt", 0, false}
    }

    self.offsets = {
        ["idle"] = {0, 0},
        ["hurt"] = {0, -5},
    }
end

return actor