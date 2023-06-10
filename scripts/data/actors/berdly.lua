local actor, super = Class("berdly", true)

function actor:init()
    super.init(self)

    self.taunt_sprites = {"fall", "nerd", "drama", "shocked", "fell"}
end

return actor