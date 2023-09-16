local Gunman, super = Class(Encounter)

function Gunman:init()
    super.init(self)
    self.music = "battle"
    self.background = true
    self:addEnemy("gunman")
    self.text = "* your gonna die lol"
	
	self.flee = false
end

return Gunman
