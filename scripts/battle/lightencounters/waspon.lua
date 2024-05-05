local Waspon, super = Class(LightEncounter)

function Waspon:init()
    super:init(self)

    self.text = "* Waspon gets in your face."

    self.music = "beasts"

    self:addEnemy("waspon")

    self.offset = 0
end

return Waspon