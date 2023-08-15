if not Kristal.getLibConfig("ribbit", "addCheckSound") then
    return EnemyBattler
end

---@class EnemyBattler
local EnemyBattler, super = Class("EnemyBattler", true)

function EnemyBattler:onAct(battler, name)
    if name == "Check" and Game.party[1].actor.id == "YOU" then
        Assets.playSound("check")
    end
    return super.onAct(self, battler, name)
end

return EnemyBattler