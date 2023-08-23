local RedHaunt, super = Class(Encounter)

function RedHaunt:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* It's a Jam!"

    -- Battle music ("battle" is rude buster)
    self.music = "spookybattle"
    -- Enables the purple grid battle background
    self.background = true
	self.hide_world = true

    -- Add the enemy to the encounter
    self:addEnemy("hhaunt")
	--self:addEnemy("dunkghoul")

end

return RedHaunt