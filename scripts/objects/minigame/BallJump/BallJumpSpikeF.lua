---@class BallJumpSpikeF : BallJumpEntity
local BallJumpSpikeF, super = Class("BallJumpEntity")

function BallJumpSpikeF:init()
    super.init(self, SCREEN_WIDTH + 20, 304)

    self.sprite:set("floor_spike")

    self.move_speed = 6
    self.collider = Hitbox(self, 3, self.height/4, 22, self.height)
end

return BallJumpSpikeF