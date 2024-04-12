local wave, super = Class(Wave)

function wave:init()
    super.init(self)
    self.time = 3.3
end

function wave:onStart()
    local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)

    local bullet = self:spawnBullet("fly", x, Game.battle.arena.top)

    local time = 20/30
    if #Game.battle.enemies == 2 then
        time = 25/30
    elseif #Game.battle.enemies == 3 then
        time = 1
    end

    self.timer:every(time, function()
        local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)

        local bullet = self:spawnBullet("fly", x, Game.battle.arena.top)
    end)
end

return wave