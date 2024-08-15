local actor, super = Class(Actor, "steamworks_boba_npc")

function actor:init()
    super.init(self)

    self.name = "Boba Npc"

    self.width = 65
    self.height = 84

    self.hitbox = {0, 30, 30, 20}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/steamworks"
    self.default = "boba_npc"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {}

    self.talk_sprites = {
        ["boba_npc"] = 0.2,
    }

    self.offsets = {}

end

return actor