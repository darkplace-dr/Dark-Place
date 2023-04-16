local BlackHole, super = Class(Wave)

function BlackHole:onStart()
    self:spawnBullet("blackhole", SCREEN_WIDTH/2, 40, 0, 0)
    self.timer:every(1/2, function()
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local y = SCREEN_HEIGHT + 20

        local angle = Utils.angle(x, y, SCREEN_WIDTH/2, 50)

        local bullet = self:spawnBullet("smallbullet_bh", x, y, angle, 6)
        bullet.remove_offscreen = false
    end)
end

function BlackHole:update()
    -- Code here gets called every frame
    Game.battle.soul.y = Game.battle.soul.y - (2 * DTMULT)
    if Game.battle.soul.x > SCREEN_WIDTH/2 then
        Game.battle.soul.x = Game.battle.soul.x - (2 * DTMULT)
    else
        Game.battle.soul.x = Game.battle.soul.x + (2 * DTMULT)
    end

    super.update(self)
end

return BlackHole