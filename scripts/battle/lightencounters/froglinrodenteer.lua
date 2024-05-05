local FroglinRodenteer, super = Class(LightEncounter)

function FroglinRodenteer:init()
    super:init(self)

    self.text = "* You are halted by Froglin and Rodenteer."

    self.music = "beasts"

    self:addEnemy("froglin", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("rodenteer", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0

    self.cheese_count = 0
end

return FroglinRodenteer