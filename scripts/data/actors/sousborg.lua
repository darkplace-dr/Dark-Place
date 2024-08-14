local actor, super = Class(Actor, "sousborg")

function actor:init()
    super.init(self)

    self.name = "Sousborg"

    self.width = 45
    self.height = 84

    self.use_light_battler_sprite = true

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/sousborg"
    self.default = "npc"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {
        ["npc"] = 0.2,
    }

    self.animations = {
        ["npc"] = {"npc", 0.2, true},
    }

    self.offsets = {
        ["npc"]  = {0, 0},
    }

end

return actor