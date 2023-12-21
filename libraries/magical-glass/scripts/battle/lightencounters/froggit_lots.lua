local encounter, super = Class(LightEncounter)

function encounter:init()
    super:init(self)

    self.text = "* Holy FUCK 2.0"

    self.music = "battle2ut"

    -- self:addEnemy("froggit", SCREEN_WIDTH/2 - 149, 246)
    -- self:addEnemy("froggit", SCREEN_WIDTH/2 + 55, 246)
    
    for i = 1, 100 do
        local frog = self:addEnemy("froggit", Utils.random(SCREEN_WIDTH), Utils.random(SCREEN_HEIGHT/2) + 50)
        frog:addFX(ColorMaskFX({math.random(),math.random(),math.random()},0.9))
    end

end

return encounter