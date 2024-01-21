---@class BallJumpSCoin : BallJumpEntity
local BallJumpSCoin, super = Class("BallJumpEntity")

function BallJumpSCoin:init(y, index)
    super.init(self, SCREEN_WIDTH + 20, y)

    self.sprite:set("starcoin")
    self.sprite:setOrigin(0.5, 0.5)

    self.move_speed = 6
    self.collider = CircleCollider(self, 0, 0, 28)

    self.hurtable = false

    self.index = index
end

function BallJumpSCoin:updateMainCollision()
    if self.collider:collidesWith(Game.minigame.player.collider) then
        Game.minigame.score = Game.minigame.score + 200
        Assets.playSound("minigames/ball_jump/coin_special")
        Game.minigame.coins_gotten[self.index] = true
        self:remove()
    end
end

return BallJumpSCoin