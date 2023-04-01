local actor, super = Class(Actor, "spamgolor")

function actor:init()
    super.init(self)

    self.name = "Spamgolor"

    self.width = 30
    self.height = 32

    self.hitbox = {0, 25, 30, 10}

    self.color = {1, 0, 0}

    self.flip = "right"

    self.path = "world/npcs/spamgolor"
    self.default = "idle"

    self.voice = "spamgolor"
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["glitch"] = {"glitch", 0.25, true},
        ["hurt"] = {"hurt", 0, false}
    }

    self.offsets = {
        ["glitch"] = {0, 0},
        ["hurt"] = {0, 0}
    }
end

return actor