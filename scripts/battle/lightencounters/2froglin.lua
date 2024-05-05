local TwoFroglin, super = Class(LightEncounter)

function TwoFroglin:init()
    super:init(self)

    self.text = "* Talk about a double-decker slime sandwich!"

    self.music = "beasts"

    self:addEnemy("froglin", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("froglin", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0
end

return TwoFroglin