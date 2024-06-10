local actor, super = Class(Actor, "blackjack")

function actor:init()
    super.init(self)

    self.name = "Blackjack"

    self.width = 320
    self.height = 240

    self.hitbox = nil

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "shopkeepers/blackjack"
    self.default = "idle"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.talk_sprites = {}

    self.animations = {}

    self.offsets = {
        ["idle"]        = {0, 0},
    }
end

return actor
