local actor, super = Class(Actor, "jandroid")

function actor:init()
    super.init(self)

    self.name = "Jandroid"

    self.width = 40
    self.height = 41

    self.hitbox = {0, 26, 40, 18}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/jandroid"
    self.default = "npc_1"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["talk"] = {"npc", 1/8, true},
    }

    self.offsets = {
        ["npc"]  = {0, 0}
    }

end

return actor