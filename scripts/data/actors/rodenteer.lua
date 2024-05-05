local actor, super = Class(Actor, "rodenteer")

function actor:init()
    super.init(self)

    self.name = "Rodenteer"

    self.width = 35
    self.height = 18

    self.hitbox = {0, 6, 16, 12}

    self.color = {1, 0, 0}

    self.flip = "right"

    self.path = "battle/lightenemies/rodenteer"
    self.default = "npc"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["hurt"] = {"hurt_npc", 1/8, true},
    }

    self.offsets = {
        ["npc"]  = {0, 0},
        ["hurt"]  = {0, 0}
    }

end

return actor