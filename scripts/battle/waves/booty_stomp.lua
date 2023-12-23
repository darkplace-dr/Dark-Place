local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 90
	
	self.time = 10
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.timer:every(1.5, function()
		local ran = love.math.random(1,3)
		
		for i=1, 3 do
			-- Our X position is offscreen, to the right
			local x = Game.battle.arena:getLeft() + 15 + (i-1) * 30
			-- Get a random Y position between the top and the bottom of the arena
			local y = -60

			-- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
			local to_spawn = "boot"
			if i == ran then
				to_spawn = "boot_cs"
			end
			local bullet = self:spawnBullet(to_spawn, x, y)

			-- Dont remove the bullet offscreen, because we spawn it offscreen
			bullet.remove_offscreen = false
		end
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic