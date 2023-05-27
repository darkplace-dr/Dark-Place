local TwoHaunt, super = Class(Encounter)

function TwoHaunt:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* A H.Haunt team appears!"

    -- Battle music ("battle" is rude buster)
    self.music = "spookybattle"
    -- Enables the purple grid battle background
    self.background = true
	self.hide_world = true

    -- Add the enemy to the encounter
    self:addEnemy("hhaunt")
	self:addEnemy("hhaunt")

end

return TwoHaunt