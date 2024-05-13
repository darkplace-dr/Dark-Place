local actor, super = Class(Actor, "goosic")

function actor:init()
    super.init(self)

    self.name = "Goosic"

    self.width = 39
    self.height = 51

    self.hitbox = {10, 26, 29, 18}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/goosic"
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