local UfoEncounter, super = Class(Encounter)

function UfoEncounter:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* HOLY SHIT"

    -- Battle music ("battle" is rude buster)
    self.music = "batterup"

    -- Enables the purple grid battle background
    self.background = false
	self.hide_world = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("ufoofdoom")
	self:addEnemy("ufoofdoom")

end

function UfoEncounter:onBattleInit()
	self.bg = StarsBG({1, 1, 1})
	Game.battle:addChild(self.bg)
end

function UfoEncounter:onReturnToWorld(events)
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

return UfoEncounter