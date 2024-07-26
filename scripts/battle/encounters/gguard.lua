local GGuard, super = Class(Encounter)

function GGuard:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* [C] in function 'pcall'\nmain.lua:405: in function <main.lua:403>\n[C] in function 'error'\nsrc/engine/registry.lua:166: in function 'createActor'\n\n\n\n"

    -- Battle music ("battle" is rude buster)
    self.music = "letter_to_the_black_world"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("gguard")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return GGuard
