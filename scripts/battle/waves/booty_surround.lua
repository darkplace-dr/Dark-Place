local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 20
	self.arena_height = 20
	
	self.time = 10
end

function Basic:onStart()
    self.timer:every(0.8, function()
		local ran = love.math.random(0,7)
		
		-- x = r(cos(rad)), y = r(sin(rad))
		local x = Game.battle.soul.x + 500 * math.cos(math.rad(ran * 45))
		local y = Game.battle.soul.y + 500 * math.sin(math.rad(ran * 45))

		local bullet = self:spawnBullet("boot_cs_2", x, y)

		-- Dont remove the bullet offscreen, because we spawn it offscreen
		bullet.remove_offscreen = false
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic