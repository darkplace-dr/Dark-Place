---@class BallJumpBall : BallJumpEntity
local BallJumpBall, super = Class("BallJumpEntity")

function BallJumpBall:init(y)
    super.init(self, SCREEN_WIDTH + 20, y)

    self.sprite:set("ball")
    self.sprite:setOrigin(0.5, 0.5)

    self.move_speed = 8
    self.collider = CircleCollider(self, 0, 0, 10)

    self.hurtable = false
end

function BallJumpBall:updateMainCollision()
    if self.collider:collidesWith(Game.minigame.player.collider) then
        Game.minigame.score = Game.minigame.score + 200
        Assets.playSound("minigames/ball_jump/correct")
        self:remove()
		return
    end

    self.sprite.rotation = self.sprite.rotation - DTMULT/4
end

return BallJumpBall