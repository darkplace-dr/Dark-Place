local BallJumpBall, super = Class("BallJumpBall")

function BallJumpBall:init(y)
	super.init(self, y)
	
	Assets.playSound("minigames/ball_jump/fastball")
end

function BallJumpBall:update()
	super.super.update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 12
		
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
end

return BallJumpBall