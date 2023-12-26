local actor, super = Class(Actor, "betaspam")

function actor:init()
    super.init(self)

    self.name = "Beta Spamton"

    self.width = 37
    self.height = 28

    self.hitbox = {9, 15, 22, 13}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/beta_spamton"
    self.default = ""

    self.voice = "spamton"
end

return actor