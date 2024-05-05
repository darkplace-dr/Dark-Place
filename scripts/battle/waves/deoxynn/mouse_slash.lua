local Basic, super = Class(Wave)

function Basic:onStart()
    -- Every 0.33 seconds...
	local share = false
	local battlers = Game.battle:getActiveEnemies()
	for k,v in pairs(battlers) do
		if (v.id ~= "rodenteer" and v.id ~= "rodenteer_ex") then
			share = true
		end
	end
	local timeval = 1
	if share then
		timeval = 2
	end
    self.timer:every(timeval, function()
		-- Our X position is offscreen, to the right
		local locatvar = math.random(0,2)
		local x = Game.battle.arena:getLeft()
		local y = Game.battle.arena:getTop() + (24 * locatvar)
		local w = Game.battle.arena.width
		local h = 24
		
		self.timer:script(function(wait)
			-- Spawns the warning and makes it flicker, creating a sound each time it does
			Assets.playSound("mtt_prebomb")
			local bullet = self:spawnBullet("deoxynn/mousethrustwarning", x + 71, y + 12, math.rad(180), 0)
			wait(0.1)
			Assets.playSound("mtt_prebomb")
			wait(0.1)
			Assets.playSound("mtt_prebomb")
			wait(0.1)
			Assets.playSound("mtt_prebomb")
			wait(0.1)
			Assets.playSound("mtt_prebomb")
			wait(0.1)
			Assets.playSound("mtt_prebomb")
			wait(0.1)
			bullet:remove()
			Assets.playSound("laz_c")
			
			-- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
			self:spawnBullet("deoxynn/placebulletinstant", x, y, w, h)
			
			local a = 1
	
			self.rect = Rectangle(x, y, w, h)
			self.rect.layer = Game.battle.soul.layer - 1
			self.rect.color = {1,1,1}
			self.rect.alpha = a
			Game.battle:addChild(self.rect)
			
			while a > 0 do
				a = a - 0.05
				self.rect.alpha = a
				wait(0.01)
			end
			
			self.rect:remove()
		end)
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super:update(self)
end

function Basic:onEnd(death)
	if self.rect then
		self.rect:remove()
	end
end

return Basic