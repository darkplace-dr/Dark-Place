local Dummy, super = Class(PincerEncounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The pincer tutorial begins...?"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("dummy", false)
    self:addEnemy("dummy", true)

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Dummy