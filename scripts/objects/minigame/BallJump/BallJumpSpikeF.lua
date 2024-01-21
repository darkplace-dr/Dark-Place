local BallJumpSpikeF, super = Class(Object)

function BallJumpSpikeF:init()
	super.init(self, SCREEN_WIDTH + 20, 304)
	
	self.sprite = Sprite("minigames/ball_jump/floor_spike")
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	
	self.collider = Hitbox(self, 3, self.height/4, 22, self.height)
end

function BallJumpSpikeF:update()
	super.update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 6
		
		if self.collider:collidesWith(Game.minigame.player.collider) then
            Game.minigame.player:tryHurt()
		end
		if self.x < -50 then
			self:remove()
		end
	end
end

function BallJumpSpikeF:draw()
	super.draw(self)
	if DEBUG_RENDER then
		self.collider:draw(1,0,0,1)
	end
end

return BallJumpSpikeF