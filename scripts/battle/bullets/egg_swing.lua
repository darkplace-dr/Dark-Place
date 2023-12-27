local WreckingBall, super = Class(Bullet)

function WreckingBall:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/eggman/wrecking_ball")
	
	self:setOriginExact(24, 8)
	self:setScale(1,1)
	
	self.destroy_on_hit = false
	
	self.siner = 0
	self.cosiner = 0
	
	self.collider = CircleCollider(self, 24, 140, 24)
end

function WreckingBall:update()
	super.update(self)
    self.siner = self.siner + DT
    self.cosiner = self.cosiner + DT * 1.25
	
	self.rotation = math.sin(self.siner)/2
	self.x = Game.battle.arena.x + math.cos(self.cosiner) * 71
end

return WreckingBall