---@class BallJumpBullet : BallJumpEntity
local BallJumpBullet, super = Class("BallJumpEntity")

function BallJumpBullet:init(y)
    super.init(self, SCREEN_WIDTH + 20, y, 16, 16)

    self.sprite:set("bullet")
    self.layer = Game.minigame.ground.layer + 0.001

    self.collider = Hitbox(self, self.width/2, self.height/2, self.width, self.height)
    self.stomp_collider = Hitbox(self, self.width/2, 0, self.width, 0)

    self.move_speed = 12
    Assets.playSound("minigames/ball_jump/bullet")
end

return BallJumpBullet