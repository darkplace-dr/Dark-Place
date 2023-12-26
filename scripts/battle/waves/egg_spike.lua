local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 180
	
	self.time = 10
end

function Basic:onStart()
	for i=1, 18 do
		self:spawnObject(Solid(true, Game.battle.arena:getLeft() + 10 * (i-1), Game.battle.arena:getBottom() - 40, 10, 5))
	end
	local spikes = self:spawnBullet("egg_spikes_marble", Game.battle.arena.x, Game.battle.arena:getBottom())
	
	self.timer:every(1, function()
        -- Get a random Y position between the top and the bottom of the arena
        local y = -12

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("egg_drop_spike", Game.battle.soul.x, y, math.rad(90), 8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic