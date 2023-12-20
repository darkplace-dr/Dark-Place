local actor, super = Class(Actor, "addisonsoda")

function actor:init()
    super.init(self)

    self.name = "Soda Addison"

    self.width = 59
    self.height = 83

    self.hitbox = {0, 50, 59, 33}

    self.color = {0, 0, 0}

    self.flip = nil

    self.path = "world/npcs/addisons"
    self.default = "yellow_stall"

    self.voice = nil

    self.portrait_path = nil
    self.portrait_offset = {-22, -6}

    self.animations = {}

    self.talk_sprites = {}

    self.offsets = {}
end

return actor