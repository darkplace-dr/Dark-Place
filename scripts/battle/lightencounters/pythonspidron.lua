local PythonSpidron, super = Class(LightEncounter)

function PythonSpidron:init()
    super:init(self)

    self.text = "* Looks like web development."

    self.music = "beasts"

    self:addEnemy("python", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("spidron", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0
end

return PythonSpidron