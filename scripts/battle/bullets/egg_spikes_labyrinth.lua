local MarbleSpikes, super = Class(Bullet)

function MarbleSpikes:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/eggman/spikes_marble")
	
	self:setOrigin(0.5, 1)
	self:setScale(1,1)
	
	self.destroy_on_hit = false
	
	-- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = math.pi*3/2
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = 1.5
	
	self.collider = Hitbox(self, 0, 2, 180, SCREEN_HEIGHT)
end

function MarbleSpikes:update()
	super:update(self)
end

function MarbleSpikes:draw()
	super:draw(self)
	love.graphics.setColor(1,1,1)
	love.graphics.rectangle("fill", 0, 20, 180, SCREEN_HEIGHT)
end

return MarbleSpikes