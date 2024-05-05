local TwoWaspon, super = Class(LightEncounter)

function TwoWaspon:init()
    super:init(self)

    self.text = "* Waspon swarm the area."

    self.music = "beasts"

    self:addEnemy("waspon", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("waspon", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0
end

return TwoWaspon