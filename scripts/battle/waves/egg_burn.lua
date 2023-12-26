local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 180
	
	self.time = 10
	
	self.left = true
end

function Basic:onStart()
	self:spawnObject(Solid(true, Game.battle.arena:getLeft(), Game.battle.arena:getBottom() - 30, 30, 30))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 30, Game.battle.arena:getBottom() - 30, 30, 30))
	local platform = self:spawnObject(Solid(true, Game.battle.arena.x - 20, Game.battle.arena:getBottom() - 40, 40, 4))
	local spikes = self:spawnBullet("egg_spikes_marble", Game.battle.arena.x, Game.battle.arena:getBottom())
	spikes.layer = platform.layer - 0.01
	
	Game.battle.timer:tween(1, platform, {alpha = 0}, linear, function()
		platform:remove()
	end)
	
	self.timer:every(1.4, function()
        -- Get a random Y position between the top and the bottom of the arena
        local y = -12

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("egg_fire", Game.battle.arena:getLeft() + (self.left and 15 or 165), y, math.rad(90), 8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
		
		self.left = not self.left
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic