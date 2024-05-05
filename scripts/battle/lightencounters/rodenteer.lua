local Rodenteer, super = Class(LightEncounter)

function Rodenteer:init()
    super:init(self)

    self.text = "* Rodenteer blocks your path."

    self.music = "beasts"

    self:addEnemy("rodenteer", -20, 0)

    self.offset = 0

    self.cheese_count = 0
end

return Rodenteer