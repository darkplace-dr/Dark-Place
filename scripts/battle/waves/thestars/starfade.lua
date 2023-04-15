local Basic, super = Class(Wave)

function Basic:onStart()
	self.time = 7

    -- Every 1/7 seconds...
    self.timer:every(1/7, function()
        -- Get a random side
		local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("starbulletfade", x, y)
        -- Dont remove the bullet offscreen, because we spawn it offscreen
        --bullet.remove_offscreen = true
    end)
end

return Basic