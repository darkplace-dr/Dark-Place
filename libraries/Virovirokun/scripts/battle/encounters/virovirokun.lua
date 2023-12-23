local Virovirokun, super = Class(Encounter)

function Virovirokun:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Virovirokun floated in!"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add enemies to the battle
    self:addEnemy("virovirokun", 530, 148)
    self:addEnemy("virovirokun", 560, 262)
end

return Virovirokun