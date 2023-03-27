local Spamgolor, super = Class(Encounter)

function Spamgolor:init()
    super.init(self)

    self.text = "* Spamgolor blocks your way."

    self.music = "spamgolor_battle"
    self.background = true

    self:addEnemy("spamgolor")
end

return Spamgolor