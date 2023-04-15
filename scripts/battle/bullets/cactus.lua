local Cactus, super = Class(Bullet)

function Cactus:init(x, y, dir, speed)
    super.init(self, x, y)

    self.physics.direction = dir
    self.physics.speed = speed
    self:setScale(1)
	self:setOrigin(0.5, 1)
    self.destroy_on_hit = false
	
	self.type = 0
end

function Cactus:update()
    if self.type == 0 then
	    self:setSprite("battle/bullets/cactus")
		self:setHitbox(2, 5, 15, 30)
    end
    if self.type == 1 then
	    self:setSprite("battle/bullets/bigcactus")
		self:setHitbox(4, 10, 10, 40)
    end
    if self.type == 2 then
	    self:setSprite("battle/bullets/bigcactus_double")
		self:setHitbox(4, 10, 45, 40)
    end
    if self.type == 3 then
	    self:setSprite("battle/bullets/bigcactus_group")
		self:setHitbox(4, 10, 65, 40)
    end

    super.update(self)
end

return Cactus