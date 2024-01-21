---@class BallJumpLv1 : BallJump
local BallJumpLv1, super = Class(BallJump)

function BallJumpLv1:init()
    super.init(self)

    self.name = self.name .. ": Level 1"

    self.req_score = 5000

    self.flag = "acj_game_win"
    self.hs_flag = "ball_jump_1_hs"
end

function BallJumpLv1:levelScript(wait)
    wait(1)
    self:addEntity(BallJumpBall(200))

    wait(1)
    self:addEntity(BallJumpSpikeF())

    wait(1)
    self:addEntity(BallJumpSpikeF())

    wait(1)
    self:addEntity(BallJumpBall(200))
    self:addEntity(BallJumpSpikeF())

    wait(0.7)
    self:addEntity(BallJumpSpikeF())

    wait(0.7)
    self:addEntity(BallJumpSpikeF())
    self:addEntity(BallJumpFastBall(285))

    wait(1.6)
    self:addEntity(BallJumpBall(200))
    self:addEntity(BallJumpFakeBall(285))

    wait(0.6)
    self:addEntity(BallJumpBall(285))
    self:addEntity(BallJumpFakeBall(200))

    wait(0.6)
    self:addEntity(BallJumpBall(200))
    self:addEntity(BallJumpFakeBall(285))

    wait(1)
    self:addEntity(BallJumpGoomba())

    wait(0.8)
    self:addEntity(BallJumpGoomba())

    wait(0.7)
    self:addEntity(BallJumpSCoin(140, 1))

    wait(0.1)
    self:addEntity(BallJumpGoomba())

    wait(2.2)
    self:addEntity(BallJumpBullet(240))

    wait(1)
    self:addEntity(BallJumpBullet(253))
    self:addEntity(BallJumpBullet(285))

    wait(0.5)
    self:addEntity(BallJumpBullet(221))
    self:addEntity(BallJumpBullet(189))
    self:addEntity(BallJumpBullet(157))
    self:addEntity(BallJumpBullet(125))
    self:addEntity(BallJumpBullet(93))
    self:addEntity(BallJumpBullet(61))
    self:addEntity(BallJumpSCoin(140, 2))

    wait(0.5)
    self:addEntity(BallJumpBullet(253))
    self:addEntity(BallJumpBullet(285))

    wait(0.2)
    self:addEntity(BallJumpBullet(253))

    wait(1.3)
    self:addEntity(BallJumpSpiny())

    wait(0.8)
    self:addEntity(BallJumpSpikeF())

    wait(1.6)
    self:addEntity(BallJumpChuck())
    self:addEntity(BallJumpSpikeF())

    wait(3.1)
    self:addEntity(BallJumpBackChuck())
    self:addEntity(BallJumpBall(180))

    wait(1.7)
    self:addEntity(BallJumpBullet(253))
    self:addEntity(BallJumpSpikeF())

    wait(0.3)
    self:addEntity(BallJumpSCoin(30, 3))

    wait(0.5)
    self:addEntity(BallJumpBullet(221))

    wait(0.75)
    self:addEntity(BallJumpBullet(189))

    wait(0.75)
    self:addEntity(BallJumpSpikeF())

    wait(0.5)
    self:addEntity(BallJumpFinish())
end

return BallJumpLv1