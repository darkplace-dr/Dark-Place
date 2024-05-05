local TwoPython, super = Class(LightEncounter)

function TwoPython:init()
    super:init(self)

    self.text = "* Pythons stop your way!"

    self.music = "beasts"

    self:addEnemy("python", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("python", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0
end

return TwoPython