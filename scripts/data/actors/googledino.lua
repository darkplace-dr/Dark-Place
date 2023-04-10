local actor, super = Class(Actor, "googledino")

function actor:init()
    super.init(self)

    self.name = "Google Dino"

    self.width = 30
    self.height = 32

    self.hitbox = {0, 25, 30, 10}

    self.color = {1, 0, 0}

    self.flip = "right"

    self.path = "world/npcs/googledino"
    self.default = "idle"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["idle"] = {"idle", 0.5, true},
        ["hurt"] = {"hurt", 1, false},
        ["static"] = {"static", 1, true},
    }

end

return actor