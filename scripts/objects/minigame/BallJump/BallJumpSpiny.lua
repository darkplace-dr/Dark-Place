local BallJumpSpiny, super = Class(Object)

function BallJumpSpiny:init()
	super:init(self, SCREEN_WIDTH + 20, 288, 16, 16)
	
	self.sprite = Sprite("minigames/ball_jump/spiny_1")
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	self.sprite:setAnimation({"minigames/ball_jump/spiny", 1/5, true})
	self.layer = Game.minigame.ground.layer + 0.001
	
	self.collider = Hitbox(self, self.width/2, self.height/2, self.width, self.height)
end

function BallJumpSpiny:update()
	super:update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 8
		
		if self.collider:collidesWith(Game.minigame.player.collider) then
			if Game.minigame.player:didThatHurt() then
				Game.minigame.score = Game.minigame.score - 150
				Game.minigame.lives = Game.minigame.lives - 1
				Assets.playSound("minigames/ball_jump/hurt")
				if Game.minigame.lives == 0 then
					Game.minigame:setState("DEAD")
				else
					Game.minigame.player.iframes = 1.5
					Game.minigame.player.sprite.alpha = 0.5
				end
			end
		end
		if self.x < -50 then
			self:remove()
		end
	end
end

function BallJumpSpiny:draw()
	super:draw(self)
	if DEBUG_RENDER then
		self.collider:draw(1,0,0,1)
		self.stomp_collider:draw(0,1,0,1)
	end
end

return BallJumpSpiny