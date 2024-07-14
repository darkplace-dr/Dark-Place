local Poseur, super = Class(Encounter)

function Poseur:init()
    super.init(self)

    self.text = "* It's tutorial time."

    self.music = "cards"
    self.background = true

    self:addEnemy("tutorial_terry")
end

return Poseur