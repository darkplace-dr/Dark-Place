local actor, super = Class(Actor, "fun_fax")

function actor:onSpriteInit(sprite)
    sprite:setScale(0.5)
end

function actor:init()
    super.init(self)
    self.name = "fun_fax"
    self.width = 210
    self.height = 325
    self.color = {1, 1, 1}
    self.path = "npcs/fun_fax"
    self.default = "searching"

    self.can_blush = false

    self.animations = {}

    self.offsets = {
    }
end

return actor