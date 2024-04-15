local ThreeVoidWanderer, super = Class(Encounter)

function ThreeVoidWanderer:init()
    super.init(self)

    self.text = "* The Void Encroaches."

    self.music = "battle2ut"
    self.background = true

    self:addEnemy("voidwanderer")
    self:addEnemy("voidwanderer")
    self:addEnemy("voidwanderer")
end

function ThreeVoidWanderer:onReturnToWorld(events)
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

return ThreeVoidWanderer