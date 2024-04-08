local actor, super = Class(Actor, "dina")

function actor:init()
    super.init(self)

    self.name = "Dina"

    self.width = 32
    self.height = 39

    self.hitbox = nil

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "shopkeepers/dina"
    self.default = "idle"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["idle"] = {"npc_idle", 1/10, true}
    }

    self.offsets = {
        ["npc_idle"] = {0, 0},
        ["npc_stand"] = {0, 0},
    }
end

return actor
