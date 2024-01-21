local BallJumpBackChucc, super = Class("BallJumpChuck")

function BallJumpBackChucc:init()
	super.init(self, -30, 266, 16, 16)
	
	self.sprite = Sprite("minigames/ball_jump/chuck_1")
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
	self.sprite:setAnimation({"minigames/ball_jump/chuck", 1/10, true})
	self.sprite.flip_x = true
	self.layer = Game.minigame.ground.layer + 0.001
	
	self.collider = Hitbox(self, self.width/2, self.height/2, self.width, self.height)
	self.stomp_collider = Hitbox(self, self.width/2, 0, self.width, 0)
	
	Assets.playSound("minigames/ball_jump/whistle")
	
	self.move_speed = -2
end

return BallJumpBackChucc