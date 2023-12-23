local BallJumpFinish, super = Class(Object)

function BallJumpFinish:init(y)
	super.init(self, SCREEN_WIDTH + 20, 256)
	
	self.sprite = Sprite("minigames/ball_jump/flag")
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	self.layer = Game.minigame.player.layer - 0.001
	
	self.finished = false
end

function BallJumpFinish:update()
	super.update(self)
	
	if Game.minigame.state == "MAIN" then
		self.x = self.x - DTMULT * 6
		
		if self.x < Game.minigame.player.x then
			Game.minigame:setState("WIN")
			Assets.playSound("minigames/ball_jump/win")
		end
		
		if self.x < -50 then
			self:remove()
		end
	end
end

return BallJumpFinish