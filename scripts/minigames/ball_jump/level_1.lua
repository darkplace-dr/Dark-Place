---@class BallJumpLv1 : BallJump
local BallJumpLv1, super = Class(BallJump)

function BallJumpLv1:init()
    super.init(self)

    self.name = self.name .. ": Level 1"

    self.req_score = 5000

    self.flag = "acj_game_win"
    self.hs_flag = "ball_jump_1_hs"
end

function BallJumpLv1:update()
    super.update(self)

    if self.state == "MAIN" and self.state_timer > 1 and self.entity_count < 1 then
        self:addCountedEntity(BallJumpBall(200))
    end
    if self.state == "MAIN" and self.state_timer > 2 and self.entity_count < 2 then
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 3 and self.entity_count < 3 then
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 4 and self.entity_count < 4 then
        self:addCountedEntity(BallJumpBall(200))
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 4.7 and self.entity_count < 6 then
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 5.4 and self.entity_count < 7 then
        self:addCountedEntity(BallJumpSpikeF())
        self:addCountedEntity(BallJumpFastBall(285))
    end
    if self.state == "MAIN" and self.state_timer > 7 and self.entity_count < 9 then
        self:addCountedEntity(BallJumpBall(200))
        self:addCountedEntity(BallJumpFakeBall(285))
    end
    if self.state == "MAIN" and self.state_timer > 7.6 and self.entity_count < 11 then
        self:addCountedEntity(BallJumpBall(285))
        self:addCountedEntity(BallJumpFakeBall(200))
    end
    if self.state == "MAIN" and self.state_timer > 8.2 and self.entity_count < 13 then
        self:addCountedEntity(BallJumpBall(200))
        self:addCountedEntity(BallJumpFakeBall(285))
    end
    if self.state == "MAIN" and self.state_timer > 9.2 and self.entity_count < 15 then
        self:addCountedEntity(BallJumpGoomba())
    end
    if self.state == "MAIN" and self.state_timer > 10 and self.entity_count < 16 then
        self:addCountedEntity(BallJumpGoomba())
    end
    if self.state == "MAIN" and self.state_timer > 10.7 and self.entity_count < 17 then
        self:addCountedEntity(BallJumpSCoin(140, 1))
    end
    if self.state == "MAIN" and self.state_timer > 10.8 and self.entity_count < 18 then
        self:addCountedEntity(BallJumpGoomba())
    end
    if self.state == "MAIN" and self.state_timer > 13 and self.entity_count < 19 then
        self:addCountedEntity(BallJumpBullet(240))
    end
    if self.state == "MAIN" and self.state_timer > 14 and self.entity_count < 20 then
        self:addCountedEntity(BallJumpBullet(253))
        self:addCountedEntity(BallJumpBullet(285))
    end
    if self.state == "MAIN" and self.state_timer > 14.5 and self.entity_count < 22 then
        self:addCountedEntity(BallJumpBullet(221))
        self:addCountedEntity(BallJumpBullet(189))
        self:addCountedEntity(BallJumpBullet(157))
        self:addCountedEntity(BallJumpBullet(125))
        self:addCountedEntity(BallJumpBullet(93))
        self:addCountedEntity(BallJumpBullet(61))
        self:addCountedEntity(BallJumpSCoin(140, 2))
    end
    if self.state == "MAIN" and self.state_timer > 15 and self.entity_count < 29 then
        self:addCountedEntity(BallJumpBullet(253))
        self:addCountedEntity(BallJumpBullet(285))
    end
    if self.state == "MAIN" and self.state_timer > 15.2 and self.entity_count < 31 then
        self:addCountedEntity(BallJumpBullet(253))
    end
    if self.state == "MAIN" and self.state_timer > 16.5 and self.entity_count < 32 then
        self:addCountedEntity(BallJumpSpiny())
    end
    if self.state == "MAIN" and self.state_timer > 17.3 and self.entity_count < 33 then
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 18.9 and self.entity_count < 34 then
        self:addCountedEntity(BallJumpChuck())
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 22 and self.entity_count < 36 then
        self:addCountedEntity(BallJumpBackChuck())
        self:addCountedEntity(BallJumpBall(180))
    end
    if self.state == "MAIN" and self.state_timer > 23.7 and self.entity_count < 38 then
        self:addCountedEntity(BallJumpBullet(253))
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 24 and self.entity_count < 40 then
        self:addCountedEntity(BallJumpSCoin(30, 3))
    end
    if self.state == "MAIN" and self.state_timer > 24.5 and self.entity_count < 41 then
        self:addCountedEntity(BallJumpBullet(221))
    end
    if self.state == "MAIN" and self.state_timer > 25.25 and self.entity_count < 42 then
        self:addCountedEntity(BallJumpBullet(189))
    end
    if self.state == "MAIN" and self.state_timer > 26 and self.entity_count < 43 then
        self:addCountedEntity(BallJumpSpikeF())
    end
    if self.state == "MAIN" and self.state_timer > 26.5 and self.entity_count < 44 then
        self:addCountedEntity(BallJumpFinish())
    end
end

return BallJumpLv1