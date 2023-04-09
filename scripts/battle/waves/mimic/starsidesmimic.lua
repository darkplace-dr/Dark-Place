local Basic, super = Class(Wave)

function Basic:onStart()
    local mimic = Game.battle:getEnemyBattler("mimic")
    if mimic.current_actor ~= "ufoofdoom" then
        mimic.current_actor = "ufoofdoom"
        self.timer:script(function(wait)
			mimic:fadeTo(0.2, 0.05)
			wait(0.1)
			mimic:setActor("ufoofdoom")
			mimic:fadeTo(0.2, 0)
			mimic:fadeTo(1, 0.05)
		end)
    end

	self.time = 10
	
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
        local bullet = self:spawnBullet("starbullet", x, y, math.rad(direction), 2, 0.7)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = true
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic