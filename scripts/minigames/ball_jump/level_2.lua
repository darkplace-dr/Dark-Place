---@class BallJumpLv1 : BallJump
local BallJumpLv1, super = Class(BallJump)

function BallJumpLv1:init()
    super.init(self)

    self.name = self.name .. ": Level 2"

    -- self.req_score = 5000			-- We'll figure this out when it comes time

    self.flag = "ball_jump_2_win"
    self.hs_flag = "ball_jump_2_hs"
	
    self.coins = 4
    self.coins_gotten = {false, false, false, false}
end

function BallJumpLv1:levelScript(wait)
    wait(1)
    self:addEntity(BallJumpBall(200))
    wait(1)
    self:addEntity(BallJumpBall(200))
    wait(1)
    self:addEntity(BallJumpBallGold(200))
    self:addEntity(BallJumpGoomba())
    wait(0.8)
    self:addEntity(BallJumpGoomba())
    wait(1.8)
    self:addEntity(BallJumpSCoin(140, 1))
	wait(0.7)
    self:addEntity(BallJumpBackChuck())
end

return BallJumpLv1