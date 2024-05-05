local WasponArchMonkWaspon, super = Class(LightEncounter)

function WasponArchMonkWaspon:init()
    super:init(self)

    self.text = "* Bug and monkey.[wait:5]\n* An unlikely alliance."

    self.music = "beasts"

    self:addEnemy("waspon", SCREEN_WIDTH/2 - 200, 230)
    self:addEnemy("arch_monk", SCREEN_WIDTH/2, 230)
    self:addEnemy("waspon", SCREEN_WIDTH/2 + 200, 230)

    self.offset = 0
end

return WasponArchMonkWaspon