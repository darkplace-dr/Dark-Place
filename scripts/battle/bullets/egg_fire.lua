local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/flame_1")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	
	self.destroy_on_hit = false
	self.remove_offscreen = false
	self.sprite:setAnimation({"battle/bullets/flame", 0.25, true})
	self.collider = Hitbox(self, self.width/6, self.height/6, self.width*4/6, self.height*4/6)
	self.end_timer = 0
end

function SmallBullet:update()
	-- For more complicated bullet behaviours, code here gets called every update
	super.update(self)
	
	for _,bullet in ipairs(self.wave.bullets) do
		if bullet:collidesWith(self) and bullet ~= self then
			self.collided_with_another = true
		end
	end

	if self.y > Game.battle.arena:getBottom() - 37 or self.collided_with_another then
		self.physics.speed = 0
		if not self.stopped then
			self.stopped = true
			Assets.playSound("noise")
		end
		self.end_timer = self.end_timer + DT
		self.alpha = 1 - self.end_timer
		if self.end_timer >= 1 then
			self:remove()
		end
	end
end

return SmallBullet