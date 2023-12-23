local HomingBullet, super = Class(Bullet)

function HomingBullet:init(x, y, texture)
    super.init(self, x, y, texture)

    self.can_home = true
	self.homing_timer = 0
	self.cd = 1
	self.home_health = 1
	
	self.color = {0,0,1,1}
	
	self.home_tp = 2
end

function HomingBullet:update()
	super.update(self)
	
	if self.homing_timer > 0 then
		self.homing_timer = self.homing_timer - DT
	end
end

function HomingBullet:onHome()
    self.home_health = self.home_health - 1
    if self.home_health <= 0 then
        self:destroy()
    end
end

function HomingBullet:destroy()
    if self.shot_tp ~= 0 then
        Game:giveTension(self.home_tp)
    end
    self:remove()
end

function HomingBullet:canHome()
	return self.can_home and self.homing_timer <= 0
end

function HomingBullet:onCollide(soul)
	if self.homing_timer <= 0 then
		if soul.inv_timer == 0 then
			self:onDamage(soul)
		end

		if self.destroy_on_hit then
			self:remove()
		end
	end
end

function HomingBullet:deselect()
	self.color = {0,0,1,1}
end

return HomingBullet