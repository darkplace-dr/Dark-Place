local NEOPonmen, super = Class(Encounter)

function NEOPonmen:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* A set of NEO Ponmen ambush you!"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("neo_ponman")
    self:addEnemy("neo_ponman")
end

function NEOPonmen:onStateChange(old, new)
    if old == "INTRO" then
        Game.battle.music:setPitch(0.7)
    end
end

function NEOPonmen:onReturnToWorld(events)
    -- check whether the enemies were killed
    if Game.battle.killed then
        -- run this code for each event in the table
        for _,event in ipairs(events) do
            for _,event in ipairs(event:getGroupedEnemies(true)) do
                -- set a 'dont_load' flag to true for the event,
                -- which is a special flag that will prevent the event from loading
                event:setFlag("dont_load", true)
            end
        end
    end
end

return NEOPonmen