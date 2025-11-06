local Jandroid, super = Class(LightEncounter)

function Jandroid:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Jandroid strolls up, whistling\na pitchy tune."

    if Game:getFlag("steamworks_kills") == nil then
        Game:setFlag("steamworks_kills", 0)
    end

    if Game:getFlag("steamworks_kills") >= 13 then
        self.music = "undertale_yellow/genobattle_yellow"
    else
        self.music = "undertale_yellow/heatwave_approaching"
    end
    
    -- Add the dummy enemy to the encounter
    self:addEnemy("jandroid")

    self.background_image = "ui/lightbattle/backgrounds/battle_steamworks"

    self.offset = 0

    self.can_flee = false

end

return Jandroid