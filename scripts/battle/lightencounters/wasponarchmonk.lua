local WasponArchMonk, super = Class(LightEncounter)

function WasponArchMonk:init()
    super:init(self)

    self.text = "* Bug and monkey.[wait:5]\n* An unlikely alliance."

    self.music = "beasts"

    self:addEnemy("waspon", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("arch_monk", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0
end

return WasponArchMonk