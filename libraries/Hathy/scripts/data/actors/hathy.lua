local actor, super = Class(Actor, "hathy")

function actor:init()
    super.init(self)

    self.name = "Hathy"

    self.width = 49
    self.height = 48

    self.hitbox = {13, 35, 40, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "enemies/hathy"
    self.default = "idle"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["idle"] = {"idle", 0.25, true},
        ["hurt"] = {"hurt", 0, false},
        ["spared"] = {"spared", 0, false},
    }

    self.offsets = {
        ["idle_2"] = {0, 1},
        ["idle_3"] = {0, 2},
        ["idle_4"] = {0, 1},
        ["hurt"] = {0, -10},
        ["spared"] = {2, 0},
    }
end

return actor