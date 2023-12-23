local BallDudeBullet, super = Class(Bullet)

function BallDudeBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/balldudebullet")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	
	self.destroy_on_hit = false
	
	-- god I wish for the sweet release of death
	self.supertimer = 0
	
	--self.collider = Collider(self, Hitbox(self, 0, 0, 16, 16))
end

function BallDudeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
	
	if self.supertimer < 30 then
        local x, y = self:getRelativePos(self.width/2, self.height/2)
        self.physics.direction = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
		self.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
	elseif self.supertimer == 30 then
		self.physics.speed = 5
	end
	
	if self.x < Game.battle.arena:getLeft() then
		self.physics.direction = self.physics.direction + 90
	end
	if self.x > Game.battle.arena:getRight() then
		self.physics.direction = self.physics.direction + 90
	end
	if self.y < Game.battle.arena:getTop() then
		self.physics.direction = self.physics.direction + 90
	end
	if self.y > Game.battle.arena:getBottom() then
		self.physics.direction = self.physics.direction + 90
	end
	
	if (not self.wave.racket1bullet == nil) and self.collider:collidesWith(self.wave.racket1bullet) then
		self.physics.direction = self.physics.direction + 90
	end
	
	if (not self.wave.racket2bullet == nil) and self.collider:collidesWith(self.wave.racket2bullet) then
		self.physics.direction = self.physics.direction + 90
	end
	
	
	self.supertimer = self.supertimer + 1

    super.update(self)
end

return BallDudeBullet