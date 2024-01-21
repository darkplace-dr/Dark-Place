---@class BallJumpSpiny : BallJumpEntity
local BallJumpSpiny, super = Class("BallJumpEntity")

function BallJumpSpiny:init()
    super.init(self, SCREEN_WIDTH + 20, 288, 16, 16)

    self.sprite:set("spiny")
    self.sprite:play(1/5, true)
    self.layer = Game.minigame.ground.layer + 0.001

    self.move_speed = 8
    self.collider = Hitbox(self, self.width/2, self.height/2, self.width, self.height)
end

return BallJumpSpiny