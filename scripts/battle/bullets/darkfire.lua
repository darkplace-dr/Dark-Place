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
	self:setScale(1,1)
	self.collider = Hitbox(self, self.width/6, self.height/6, self.width*4/6, self.height*4/6)
end

function SmallBullet:update()
	if not self.stopped then
		Object.startCache()
		for _,bullet in ipairs(self.wave.bullets) do
			if bullet:collidesWith(self) and bullet ~= self then
				self.collided_with_another = true
				break
			end
		end
		Object.endCache()

		if self.y > Game.battle.arena:getBottom() - 7 or self.collided_with_another then
			self.physics.speed = 0
			if not self.stopped then
				Assets.playSound("noise")
			end
			self.stopped = true
		end
	end

	super.update(self)
end

return SmallBullet