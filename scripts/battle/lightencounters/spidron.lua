local Spidron, super = Class(LightEncounter)

function Spidron:init()
    super:init(self)

    self.text = "* Spidron blocks your way."

    self.music = "beasts"

    self:addEnemy("spidron")

    self.offset = 0
end

return Spidron