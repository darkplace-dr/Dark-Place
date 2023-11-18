local actor, super = Class(Actor, "noel")

function actor:init()
    super.init(self)
    self.name = "Noel"
    self.width = 29
    self.height = 40
    self.hitbox = {0, 25, 19, 14}
    self.color = {1, 1, 1}
    self.path = "party/noel"
    self.default = "walk"

    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.animations = {}

    --reverse
    --basic convo reverb

    --these have nothing to do with kristal btw.

    self.animations = {
        ["sitting"] = {"sitting"},
    }

    self.offsets = {
        ["sitting"] = {0, 13},
    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    self.offsets = {}
end

return actor