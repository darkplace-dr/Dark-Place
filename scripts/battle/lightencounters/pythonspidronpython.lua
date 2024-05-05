local PythonSpidronPython, super = Class(LightEncounter)

function PythonSpidronPython:init()
    super:init(self)

    self.text = "* Looks like web development."

    self.music = "beasts"

    self:addEnemy("python", SCREEN_WIDTH/2 - 200, 230)
    self:addEnemy("spidron", SCREEN_WIDTH/2, 230)
    self:addEnemy("python", SCREEN_WIDTH/2 + 200, 230)

    self.offset = 0
end

return PythonSpidronPython