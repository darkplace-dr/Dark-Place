local Rodenteer, super = Class(LightEncounter)

function Rodenteer:init()
    super:init(self)

    self.text = "* Rodenteer blocks your path."

    self.music = "beasts"

    self:addEnemy("rodenteer")

    self.offset = 0

    self.cheese_count = 0
end

function Rodenteer:onReturnToWorld(events)
    if Game.battle.xp > 0 then
        for _,event in ipairs(events) do
            for _,event in ipairs(event:getGroupedEnemies(true)) do
                if event:getFlag("killed_count") == nil then
                    event:setFlag("killed_count", 1)
                elseif event:getFlag("killed_count") == 1 then
                    event:setFlag("killed_count", 2)
                elseif event:getFlag("killed_count") == 2 then
                    event:setFlag("dont_load", true)
                    Assets.stopAndPlaySound("ominous")
                end
            end
        end
    end
end

return Rodenteer