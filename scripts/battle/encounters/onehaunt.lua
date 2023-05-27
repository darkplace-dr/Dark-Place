local OneHaunt, super = Class(Encounter)

function OneHaunt:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* H.Haunt appears!"

    -- Battle music ("battle" is rude buster)
    self.music = "spookybattle"
    -- Enables the purple grid battle background
    self.background = true
	self.hide_world = true

    -- Add the enemy to the encounter
    self:addEnemy("hhaunt")

end

return OneHaunt