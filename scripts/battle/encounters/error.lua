local Error, super = Class(Encounter)

function Error:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The game is broken."

    -- Battle music ("battle" is rude buster)
    self.music = "GM_Construct"
    -- Enables the purple grid battle background
    self.background = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("error")

    --- Uncomment this line to add another!
    --self:addEnemy("error")
end

return Error