local DiamondMix, super = Class(Bullet)

function DiamondMix:init(x, y, dir)
    super:init(self, x, y, "bullets/rudinn/diamond_mix")
	
	self.alpha = 0
	self:fadeTo(1, 0.1)
    self.physics.direction = dir
    self.physics.speed = -1.2
	self.physics.gravity_direction = dir
	self.physics.gravity = 0.2
end

function DiamondMix:update()
	if (self.scale_x <= 1) or (self.scale_y <= 1) then
		self.graphics.grow = 0
	else
		self.graphics.grow = -0.1
	end
	super:update(self)
end

return DiamondMix