local MarbleSpikes, super = Class(Bullet)

function MarbleSpikes:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/eggman/spikes_marble")
	
	self:setOrigin(0.5, 1)
	self:setScale(1,1)
	
	self.destroy_on_hit = false
	
	self.collider = Hitbox(self, 0, 2, 180, 20)
end

function MarbleSpikes:update()
	super.update(self)
end

return MarbleSpikes