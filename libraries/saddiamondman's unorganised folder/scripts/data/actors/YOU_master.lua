local actor, super = Class(Actor, "YOU_master")


function actor:init(chara)
    super.init(self)
    self.name = "YOU_master"
    self.width = 34
    self.height = 34
    self.hitbox = {0, 24.5, 34, 9.5}
    self.color = {1, 1, 1}
    self.path = "tutorial_masters"
    self.default = "YOU_master"
    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.animations = {
    }

    self.offsets = {
    }



end


return actor