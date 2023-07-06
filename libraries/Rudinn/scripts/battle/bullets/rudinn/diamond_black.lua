local DiamondBlack, super = Class(Bullet)

function DiamondBlack:init(x, y)
    super.init(self, x, y, "bullets/rudinn/diamond_black")

	self.alpha = 0
	self:fadeTo(1, 0.1)
    self.rotation = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
    self.physics.speed = 0
	self.physics.match_rotation = true
	self.graphics.grow = -0.1
	self.targeting = true
end

function DiamondBlack:update()
	if self.targeting then
		self.rotation = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
	end
	super.update(self)
end

return DiamondBlack