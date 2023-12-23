local BallJumpBall, super = Class(Object)

function BallJumpBall:init(y)
	super.init(self, SCREEN_WIDTH + 20, y)
	
	self.sprite = Sprite("minigames/ball_jump/ball")
	self.sprite:setOrigin(0.5, 0.5)
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	
	self.collider = CircleCollider(self, 0, 0, 10)
end

function BallJumpBall:update()
	super.update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 8
		
		if self.collider:collidesWith(Game.minigame.player.collider) then
			self:remove()
			Game.minigame.score = Game.minigame.score + 200
			Assets.playSound("minigames/ball_jump/correct")
		end
		
		self.sprite.rotation = self.sprite.rotation - DTMULT/4
		if self.x < -50 then
			self:remove()
		end
	end
end

function BallJumpBall:draw()
	super.draw(self)
	if DEBUG_RENDER then
		self.collider:draw(0,1,1,1)
	end
end

return BallJumpBall