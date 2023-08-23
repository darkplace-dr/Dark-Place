local chevelour, super = Class(Encounter)

function chevelour:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Chevelour wants to battle!"

    -- Battle music ("battle" is rude buster)
    self.music = "vs_chevelour"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("chevelour")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return chevelour