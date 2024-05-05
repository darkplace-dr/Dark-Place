local TwoSpidron, super = Class(LightEncounter)

function TwoSpidron:init()
    super:init(self)

    self.text = "* Spidrons block your way."

    self.music = "beasts"

    self:addEnemy("spidron", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("spidron", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0
end

return TwoSpidron