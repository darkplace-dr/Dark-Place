local BallJumpFakeBall, super = Class(Object)

function BallJumpFakeBall:init(y)
	super.init(self, SCREEN_WIDTH + 20, y)
	
	self.sprite = Sprite("minigames/ball_jump/fake_ball")
	self.sprite:setOrigin(0.5, 0.5)
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	
	self.collider = CircleCollider(self, 0, 0, 8)
end

function BallJumpFakeBall:update()
	super.update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 8
		
		if self.collider:collidesWith(Game.minigame.player.collider) then
            Game.minigame.player:tryHurt()
		end
		
		self.sprite.rotation = self.sprite.rotation - DTMULT/4
		if self.x < -50 then
			self:remove()
		end
	end
end

function BallJumpFakeBall:draw()
	super.draw(self)
	if DEBUG_RENDER then
		self.collider:draw(1,0,0,1)
	end
end

return BallJumpFakeBall