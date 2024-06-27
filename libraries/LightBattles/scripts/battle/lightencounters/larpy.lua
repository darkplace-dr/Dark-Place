local encounter, super = Class(LightEncounter)

function encounter:init()
    super.init(self)

    self.text = "* Larpy flew into battle!"

    self.music = "battle2ut"

    self:addEnemy("larpy", SCREEN_WIDTH/2 - 16, 180)
end

return encounter