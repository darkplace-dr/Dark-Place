local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/eggman/spikeball")

    self.dx = Utils.random(-2,2)
	
	self.dy = -4
end

function SmallBullet:update()
	super.update(self)
    self.x = self.x + self.dx * DT * 30
    self.y = self.y + self.dy * DT * 30
	
	if self.y < Game.battle.arena:getBottom() then
		self.dy = self.dy + 0.05
	end
end

return SmallBullet