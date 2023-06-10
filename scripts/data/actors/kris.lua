local actor, super = Class("kris", true)

function actor:init()
    super.init(self)

    self.taunt_sprites = {"pose", "peace", "t_pose", "sit"}
end

return actor