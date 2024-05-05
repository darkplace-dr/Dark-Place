local Python, super = Class(LightEncounter)

function Python:init()
    super:init(self)

    self.text = "* Python slithers down the wall."

    self.music = "beasts"

    self:addEnemy("python")

    self.offset = 0
end

return Python