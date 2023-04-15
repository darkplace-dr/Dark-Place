---@class _EnemyBattler : EnemyBattler
---@overload fun(...) : EnemyBattler
local EnemyBattler, super = Class("EnemyBattler", true)

function EnemyBattler:init(...)
    super.init(self, ...)
    self.killable = true
end

function EnemyBattler:onDefeat(...)
    if self.killable == true and Game:getFlag("can_kill") == true then
        self:onDefeatFatal(...)
    else
        if self.exit_on_defeat then
            self:onDefeatRun(...)
        else
            self.sprite:setAnimation("defeat")
        end
    end
end

return EnemyBattler