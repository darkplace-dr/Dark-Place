local actor, super = Class(Actor, "steamworks_clock")

function actor:init()
    super.init(self)

    self.name = "Grandfather Clock"

    self.width = 122
    self.height = 237

    self.hitbox = {0, 230, 122, 7}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/steamworks"
    self.default = "clock"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {}

    self.talk_sprites = {
        ["clock"] = 0.2,
    }

    self.offsets = {}

end

return actor