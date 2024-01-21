---@class BallJumpFakeBall : BallJumpBall
local BallJumpFakeBall, super = Class("BallJumpBall")

function BallJumpFakeBall:init(y)
    super.init(self, y)

    self.sprite:set("fake_ball")

    self.hurtable = true
    self.collider = CircleCollider(self, 0, 0, 8)
end

function BallJumpFakeBall:updateMainCollision()
    super.super.updateMainCollision(self)
    self.sprite.rotation = self.sprite.rotation - DTMULT/4
end

function BallJumpFakeBall:draw()
    super.draw(self)
    if DEBUG_RENDER then
        self.collider:draw(1,0,0,1)
    end
end

return BallJumpFakeBall