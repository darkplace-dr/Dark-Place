local actor, super = Class(Actor, "noel_master")

function actor:init(chara)
    super.init(self)
    self.name = "noel_master"
    self.width = 34
    self.height = 34
    self.hitbox = {0, 0, 0, 0}
    self.color = {1, 1, 1}
    self.path = ""
    self.default = "idle"
    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.offsets = {
    }
end

return actor