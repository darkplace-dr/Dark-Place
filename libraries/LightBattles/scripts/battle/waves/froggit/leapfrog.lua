local wave, super = Class(Wave)

function wave:onStart()
    self.time = 0
    local arena = Game.battle.arena
    self.frog = self:spawnBullet("leapfrog", arena.x + 60, arena.y)

    local time = (1 + Utils.random(1))
    self.timer:after(time, function()
        self.frog:jump()
    end)
end

function wave:canEnd()
    if self.frog.x < (Game.battle.arena.x - Game.battle.arena.width / 2) + 22 then
        return true
    elseif self.frog.collided then
        return true
    end
    return false
end

return wave