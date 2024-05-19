local actor, super = Class(Actor, "tellyvis")

function actor:init()
    super.init(self)

    self.name = "Telly-Vis"

    self.width = 52
    self.height = 53

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/tellyvis"
    self.default = "npc_1"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["talk"] = {"npc", 1/2, true},
    }

    self.offsets = {
        ["npc"]  = {0, 0},
    }

end

return actor