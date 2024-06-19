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
    self.default = "talk_1"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["talk"] = {"talk", 1/8, true},
    }

    self.offsets = {
        ["npc"]  = {0, 0}
    }

end

return actor