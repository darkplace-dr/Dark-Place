---@class BallJumpEntity : Object
---@field sprite Sprite
---@field collider Collider
---@field stomp_collider? Collider
---@field move_speed number
---@field hurtable? boolean
local BallJumpEntity, super = Class(Object)

function BallJumpEntity:init(...)
    super.init(self, ...)

    self.sprite = Sprite("bullet", 0, 0, nil, nil, "minigames/ball_jump")
    self.sprite:setScale(2, 2)
    self:addChild(self.sprite)
    self.move_speed = 6
end

function BallJumpEntity:update()
    super.update(self)
    local minigame = Game.minigame ---@type BallJump
    if minigame.state ~= "MAIN" then return end
    self:updateMain()
end

function BallJumpEntity:updateMain()
    if self.x < -50 then
        self:remove()
        return
    end

    self:updateMainCollision()

    self.x = self.x - DTMULT * self.move_speed
end
function BallJumpEntity:updateMainCollision()
    if self.stomp_collider and self.stomp_collider:collidesWith(Game.minigame.player.collider) then
        Game.minigame.score = Game.minigame.score + 300 + 150 * Game.minigame.player.stomp_combo
        Game.minigame.player.stomp_combo = Game.minigame.player.stomp_combo + 1
        if Game.minigame.player.stomp_combo >= 8 then
            Assets.playSound("minigames/ball_jump/1up")
            Game.minigame.lives = Game.minigame.lives + 1
        end
        Assets.playSound("minigames/ball_jump/stomp")
        Game.minigame.player.velocity = -12
        self:remove()
    elseif self.hurtable ~= false and self.collider and self.collider:collidesWith(Game.minigame.player.collider) then
        Game.minigame.player:tryHurt()
    end
end

function BallJumpEntity:draw()
    super.draw(self)
    if DEBUG_RENDER then
        if self.collider then
            self.collider:draw(1,0,0,1)
        end
        if self.stomp_collider then
            self.stomp_collider:draw(0,1,0,1)
        end
    end
end

return BallJumpEntity