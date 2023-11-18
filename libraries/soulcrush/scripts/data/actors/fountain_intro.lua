local actor, super = Class(Actor, "fountain_intro")


function actor:init(chara)
    super.init(self)
    self.name = "fountain-intro"
    self.width = 80
    self.height = 170
    self.color = {1, 1, 1}
    self.path = "effects/fountain"
    self.default = "appear"
    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.animations = {
        ["loop"] = {"loop", 1/8, true},
        ["appear"] = {"appear", 1/15, false, next="loop"},
        ["vanish"] = {"vanish", 1/2, false},
    }

    self.offsets = {
    }



end


return actor