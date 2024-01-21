---@class BallJumpBackChuck : BallJumpChuck
local BallJumpBackChucc, super = Class("BallJumpChuck")

function BallJumpBackChucc:init()
	super.init(self, -30, 266, 16, 16)
	
	self.sprite.flip_x = true
	
	self.collider = Hitbox(self, self.width/2, self.height/2, self.width, self.height)
	self.stomp_collider = Hitbox(self, self.width/2, 0, self.width, 0)
	
	self.move_speed = -2

	Assets.playSound("minigames/ball_jump/whistle")
end

return BallJumpBackChucc