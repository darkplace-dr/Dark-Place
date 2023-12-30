local Poseur, super = Class(Encounter)

function Poseur:init()
    super.init(self)

    self.text = "* Poseur strikes a pose!"

    self.music = "battleut"
    self.background = true

    self:addEnemy("poseur")
end

return Poseur