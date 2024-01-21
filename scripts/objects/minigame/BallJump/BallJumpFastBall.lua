---@class BallJumpFastBall : BallJumpBall
local BallJumpFastBall, super = Class("BallJumpBall")

function BallJumpFastBall:init(y)
	super.init(self, y)

	self.move_speed = 12
	Assets.playSound("minigames/ball_jump/fastball")
end

return BallJumpFastBall