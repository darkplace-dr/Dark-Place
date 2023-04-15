local Basic, super = Class(Wave)

function Basic:onStart()
    -- Every 1/5 seconds...
    self.timer:every(1/5, function()
        -- Get a random side
		local x = 0
		local direction = 180
		if Utils.random() < 0.5 then
			x = SCREEN_WIDTH - 16
		else
			x = 0
			direction = 0
		end
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("starbullet", x, y, math.rad(direction), 3, 0.3)
        bullet.remove_offscreen = true
    end)
end

return Basic