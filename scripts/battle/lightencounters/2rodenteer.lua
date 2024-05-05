local TwoRodenteer, super = Class(LightEncounter)

function TwoRodenteer:init()
    super:init(self)

    self.text = "* Rodenteers block your path."

    self.music = "beasts"

    self:addEnemy("rodenteer", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("rodenteer", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0

    self.cheese_count = 0
end

return TwoRodenteer