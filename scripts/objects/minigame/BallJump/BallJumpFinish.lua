---@class BallJumpFinish : BallJumpEntity
local BallJumpFinish, super = Class("BallJumpEntity")

function BallJumpFinish:init()
	super.init(self, SCREEN_WIDTH + 20, 256)
	
	self.sprite:set("flag")
	self.layer = Game.minigame.player.layer - 0.001
	
	self.hurtable = false
	self.move_speed = 6
end

function BallJumpFinish:updateMainCollision()
	if self.x < Game.minigame.player.x then
		Game.minigame:setState("WIN")
		Assets.playSound("minigames/ball_jump/win")
	end
end

return BallJumpFinish