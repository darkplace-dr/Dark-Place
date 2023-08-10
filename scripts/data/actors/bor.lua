local actor, super = Class("bor", true)

function actor:init()
    super.init(self)

    self.taunt_sprites = {"pizza", "pizza_b", "kirby"}
end

return actor