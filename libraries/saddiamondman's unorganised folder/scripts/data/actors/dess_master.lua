local actor, super = Class(Actor, "dess_master")


function actor:init(chara)
    super.init(self)
    self.name = "dess_master"
    self.width = 34
    self.height = 36
    self.hitbox = {0, 26.5, 34, 9.5}
    self.color = {1, 1, 1}
    self.path = "tutorial_masters"
    self.default = "dess_master"
    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.animations = {
        ["dess_master"] = {"dess_master"},
    }

    self.offsets = {
        ["dess_master"] = {0, 0},
    }



end


return actor