local Rodenteer, super = Class(LightEncounter)

function Rodenteer:init()
    super:init(self)

    self.text = "* Rodenteer blocks your path."

    self.music = "beasts"

    self:addEnemy("rodenteer")

    self.offset = 0

    self.cheese_count = 0
end

function Rodenteer:onReturnToWorld(events) -- Doesn't fuckin work for a reason only God Himself knows
    if self.xp > 0 then -- HOW TF DO I MAKE THIS SHIT WORK
        for _,event in ipairs(events) do
            for _,event in ipairs(event:getGroupedEnemies(true)) do
                if not event:getFlag("killed_count") then
                    event:setFlag("killed_count", 0)
                end
                event:addFlag("killed_count", 1)
                if event:getFlag("killed_count") >= 3 then
                    event:setFlag("dont_load", true)
                    Assets.stopAndPlaySound("ominous")
                end
            end
        end
    end
end

return Rodenteer