local encounter, super = Class(LightEncounter)

function encounter:init()
    super.init(self)

    self.text = "* Final Froggit hopped in...?"

    self.music = "battle2ut"

    self:addEnemy("finalfroggit", SCREEN_WIDTH/2 - 4, 246)
end

return encounter