local BallJumpSCoin, super = Class(Object)

function BallJumpSCoin:init(y, index)
	super:init(self, SCREEN_WIDTH + 20, y)
	
	self.sprite = Sprite("minigames/ball_jump/starcoin")
	self.sprite:setOrigin(0.5, 0.5)
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	
	self.index = index
	
	self.collider = CircleCollider(self, 0, 0, 28)
end

function BallJumpSCoin:update()
	super:update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 6
		
		if self.collider:collidesWith(Game.minigame.player.collider) then
			self:remove()
			Game.minigame.score = Game.minigame.score + 200
			Assets.playSound("minigames/ball_jump/coin_special")
			Game.minigame.coins_gotten[self.index] = true
		end
		
		if self.x < -50 then
			self:remove()
		end
	end
end

function BallJumpSCoin:draw()
	super:draw(self)
	if DEBUG_RENDER then
		self.collider:draw(1,1,0,1)
	end
end

return BallJumpSCoin