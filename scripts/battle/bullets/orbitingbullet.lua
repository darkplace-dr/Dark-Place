local OrbBullet, super = Class(Bullet)

function OrbBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/smallbullet")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
	
    --self.physics.speed = 0
	
	self.destroy_on_hit = false
	
	-- is this bad practice?
	-- this is probably bad practice.
	--
	-- lmao
	self.crushma = 100
	self.crushma2 = 100
	
	self.crushmaultimate = 100
	
	self.supertimer = 0
	
	self.speedbutnot = speed
	
end

function OrbBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
	
	self.x = (SCREEN_WIDTH/2) + (math.cos(math.rad(self.physics.direction)) * self.crushma)
	self.y = ((SCREEN_HEIGHT/2) - 70) + (math.sin(math.rad(self.physics.direction)) * self.crushma2)
	
	self.crushma = math.cos(self.supertimer / 30) * self.crushmaultimate
	--self.crushma2 = math.sin(self.supertimer / 50) * self.crushmaultimate
	
	
	self.physics.direction = self.physics.direction + self.speedbutnot
	
	if self.supertimer < 100 then
		self.alpha = self.supertimer/100
	end
	
	self.supertimer = self.supertimer + 1
	
    super.update(self)
end

function OrbBullet:onCollide(soul)
	if self.supertimer > 100 and soul.inv_timer == 0 then
		self:onDamage(soul)
	end
end

return OrbBullet