local TwoRodenteer, super = Class(LightEncounter)

function TwoRodenteer:init()
    super:init(self)

    self.text = "* Rodenteers block your path."

    self.music = "beasts"

    self:addEnemy("rodenteer", SCREEN_WIDTH/2 - 120, 230)
    self:addEnemy("rodenteer", SCREEN_WIDTH/2 + 120, 230)

    self.offset = 0

    self.cheese_count = 0
end

function TwoRodenteer:onReturnToWorld(events)
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

return TwoRodenteer