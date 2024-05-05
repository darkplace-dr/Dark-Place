local Froglin, super = Class(LightEncounter)

function Froglin:init()
    super:init(self)

    self.text = "* Froglin jumps in your way!"

    self.music = "beasts"

    self:addEnemy("froglin")

    self.offset = 0
end

return Froglin