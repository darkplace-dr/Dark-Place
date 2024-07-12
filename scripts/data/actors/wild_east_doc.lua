local actor, super = Class(Actor, "wild_east_doc")

function actor:init()
    super.init(self)

    self.name = "The Doc"

    self.width = 31
    self.height = 45

    self.hitbox = {12, 35, 16, 10}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/dunes/doc"
    self.default = "talk"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {}

    self.talk_sprites = {
        ["talk"] = 0.2,
    }

    self.offsets = {}

end

return actor