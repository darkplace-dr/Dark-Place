local Jandroid, super = Class(LightEncounter)

function Jandroid:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Jandroid strolls up, whistling\na pitchy tune."

    -- Battle music ("battleut" is undertale)
    self.music = "heatwave_approaching"

    -- Add the dummy enemy to the encounter
    self:addEnemy("jandroid")

    self.background_image = "ui/lightbattle/backgrounds/battle_steamworks"

    self.offset = 0

    self.can_flee = false

end

return Jandroid