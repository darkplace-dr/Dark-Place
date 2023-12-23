local actor, super = Class(Actor, "flaurel")

function actor:init()
    super.init(self)

    self.name = "Flaurel"

    self.width = 22
    self.height = 40

    self.hitbox = {0, 28, 22, 12}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/flaurel"
    self.default = ""
end

return actor