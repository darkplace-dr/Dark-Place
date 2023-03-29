local LightTransitionParticle, super = Class(Sprite)

function LightTransitionParticle:init(x, y)
	super:init(self, "ui/lightparticle", x, y)
	self.physics.speed_y = -2 * DTMULT
	self:setScale(2)
	self.physics.friction = 0.07 * DTMULT
	self.physics.speed_x = (-1 + math.random(0, 2))
end

function LightTransitionParticle:update()
	super:update(self)
	self.alpha = self.alpha - (0.05 * DTMULT)
	if self.alpha <= 0 then self:remove() end
end

return LightTransitionParticle