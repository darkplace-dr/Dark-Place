local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.time = 10
end

function Basic:onStart()
    self.timer:every(0.8, function()
        local x = love.math.random(Game.battle.arena:getLeft(), Game.battle.arena:getRight())
        local y = 500

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("egg_spikeball", x, y)

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