local Hathy, super = Class(Encounter)

function Hathy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Hathy blocked the way!"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("hathy")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Hathy