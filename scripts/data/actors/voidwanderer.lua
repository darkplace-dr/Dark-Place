local actor, super = Class(Actor, "voidwanderer")

function actor:init()
    super.init(self)

    self.name = "Void Wanderer"

    self.width = 48
    self.height = 48

    self.hitbox = {10, 30, 27, 20}

    self.color = {1, 0, 0}

    self.flip = "right"

    self.path = "battle/enemies/voidwanderer"
    self.default = "idle"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["idle"] = {"idle", 0.5, true},
        ["battle"] = {"battle", 0.5, true},
        ["tired"] = {"tired", 0.5, true},
    }

    self.offsets = {
    }
end

return actor