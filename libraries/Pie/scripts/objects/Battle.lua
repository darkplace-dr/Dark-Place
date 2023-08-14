---
---@class Battle
---
---@overload fun(...) : Battle
local Battle, super = Class("Battle")

function Battle:checkGameOver()
    for _,battler in ipairs(self.party) do
        if not battler.is_down then
            return
        end
    end
    -- New callback - runs before the wave ends for a
    -- bit more versatility.
    if self.encounter:beforeGameOver() then
        return
    end
    self.music:stop()
    if self:getState() == "DEFENDING" then
        for _,wave in ipairs(self.waves) do
            wave:onEnd(true)
        end
    end
    if self.encounter:onGameOver() then
        return
    end
    Game:gameOver(self:getSoulLocation())
end

return Battle