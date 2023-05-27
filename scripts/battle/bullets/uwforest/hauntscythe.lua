local HauntScythe, super = Class(Bullet)

function HauntScythe:init(x, y, retx, rety, dir, speed, duration)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/hscythe")
	-- fucknging whatever
	self:setSprite("battle/bullets/hscythe", 0.1, true)
	
	self.element = "scythe"
	
	self.retx = retx
	self.rety = rety
	
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
	self.startdir = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	self.triggered = false
	
	self.destroy_on_hit = false
	self.remove_offscreen = false
	
	self.physics.friction = 0.2
	
	Game.battle.timer:after(duration, function()
	
		Game.battle.timer:every(0.004, function()
		
			self.physics.direction = self.physics.direction + math.rad(1)
		
		end, 180)
	
	end)
	
end

function HauntScythe:update()
    -- For more complicated bullet behaviours, code here gets called every update
	
	if self.physics.speed < 7 then
		self.physics.friction = 0
	end
	
	if not triggered and self.physics.direction >= self.startdir + math.rad(179) then
		self.triggered = true
		self:slideToSpeed(self.retx, self.rety, self.physics.speed, function() self:remove() end)
		self.physics.speed = 0
		self.physics.direction = 0
	end
	
    super.update(self)
end

return HauntScythe