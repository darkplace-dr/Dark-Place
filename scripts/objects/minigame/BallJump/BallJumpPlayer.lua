local BallJumpPlayer, super = Class(Object)

function BallJumpPlayer:init()
	super:init(self, -30, 284, 16, 20)
	
	self.sprite = Sprite("minigames/ball_jump/player_idle_1")
	self.sprite:setOrigin(0.25, 0.25)
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	self.sprite:setAnimation({"minigames/ball_jump/player_idle", 1/8, true})
	self.layer = Game.minigame.ground.layer + 0.001
	
	self.collider = Hitbox(self, self.width/4 - 5, self.height/4, self.width/2 + 10, self.height + 3)
	
	self.on_ground = true
	
	self.velocity = 0
	
	self.iframes = 0
	
	self.stomp_combo = 0
end

function BallJumpPlayer:handleJump()
	if self.on_ground then
		self.on_ground = false
		self.velocity = -10
		self.sprite:setSprite("minigames/ball_jump/player_jump")
		Assets.playSound("minigames/ball_jump/jump")
	end
end

function BallJumpPlayer:update()
	super:update(self)
	
	if not self.on_ground then
		self.y = self.y + self.velocity
		self.velocity = self.velocity + DTMULT
	end
	if not self.on_ground and self.velocity > 0 and self.y > 284 then
		self.on_ground = true
		self.velocity = 0
		self.y = 284
		self.sprite:setAnimation({"minigames/ball_jump/player_idle", 1/8, true})
		self.stomp_combo = 0
	end
	if Game.state == "WIN" or Game.state == "DEAD" then
		self.sprite.alpha = 1
	end
	self.iframes = self.iframes - DT
end

function BallJumpPlayer:didThatHurt()
	if self.iframes > 0 then
		return false
	end
	return true
end

function BallJumpPlayer:draw()
	super:draw(self)
	if DEBUG_RENDER then
		self.collider:draw(0,1,0,1)
	end
end

return BallJumpPlayer