local VoidWanderer, super = Class(Encounter)

function VoidWanderer:init()
    super.init(self)

    self.text = "* Void Wanderer blocks your way."

    self.music = "battle2ut"
    self.background = true

    self:addEnemy("voidwanderer")
end

function VoidWanderer:onReturnToWorld(events)
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

return VoidWanderer