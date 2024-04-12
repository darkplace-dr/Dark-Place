local encounter, super = Class(LightEncounter)

function encounter:init()
    super:init(self)

    self.text = "* A pair of Froggits hop\ntowards you."

    self.music = "battleut"

    self:addEnemy("froggit", SCREEN_WIDTH/2 - 149, 246)
    self:addEnemy("froggit", SCREEN_WIDTH/2 + 55, 246)

end

return encounter