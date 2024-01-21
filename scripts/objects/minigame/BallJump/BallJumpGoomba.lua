---@class BallJumpGoomba : BallJumpEntity
local BallJumpSpikeF, super = Class("BallJumpEntity")

function BallJumpSpikeF:init()
	super.init(self, SCREEN_WIDTH + 20, 288, 26, 27)
	
	self.sprite:set("goomba")
	self.sprite:play(1/5, true)
	self.layer = Game.minigame.ground.layer + 0.001
	
	self.move_speed = 8
	self.collider = Hitbox(self, self.width/2, self.height/2, self.width, self.height)
	self.stomp_collider = Hitbox(self, self.width/2, 0, self.width, 0)
end

return BallJumpSpikeF