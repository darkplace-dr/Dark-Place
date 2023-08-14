---
---@class EnemyBattler
---
---@overload fun(...) : EnemyBattler
local EnemyBattler, super = Class("EnemyBattler")

function EnemyBattler:onHurt(damage, battler)
    super:onHurt(self, damage, battler)

    if battler then
        for _, item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onEnemyHit(battler, self, damage)
            end
        end
    end
end

return EnemyBattler