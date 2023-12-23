local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.sidevar = "left"
	
	self.time = 10
	
	self.arena_width = 90
	self.arena_height = 90
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.timer:every(1, function()
        -- Our X position is offscreen, to the right
		local locatvar = math.random(0,2)
        local x = Game.battle.arena:getLeft()
		local y = Game.battle.arena:getTop() + (30 * locatvar)
		local w = 92
		local h = 30
		
		self.timer:script(function(wait)
			-- Spawns the warning and makes it flicker, creating a sound each time it does
			Assets.playSound("mtt_prebomb")
			local bullet = self:spawnBullet("stickthrustwarning", x, y, math.rad(180), 0)
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
			self:spawnBullet("placebulletinstant", x, y, w, h)
			
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

    super.update(self)
end

function Basic:onEnd(death)
	if self.rect then
		self.rect:remove()
	end
end

return Basic