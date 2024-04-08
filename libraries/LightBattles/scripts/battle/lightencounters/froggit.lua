local encounter, super = Class(LightEncounter)

function encounter:init()
    super:init(self)

    self.text = "* Froggit hopped close!"

    self.music = "battleut"

    self:addEnemy("froggit", SCREEN_WIDTH/2 - 49, 246)
end

return encounter