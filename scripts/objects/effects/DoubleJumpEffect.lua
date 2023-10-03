local DoubleJumpEffect, super = Class(Object)

function DoubleJumpEffect:init()
    super.init(self)

    self.timer = 0
    self:fadeOutAndRemove(0.3)
    if Game.battle.soul then
        if Game.battle.soul.direction == "down" then
            self.x = Game.battle.soul.x
            self.y = Game.battle.soul.y + 10
        elseif Game.battle.soul.direction == "up" then
            self.x = Game.battle.soul.x
            self.y = Game.battle.soul.y - 10
        elseif Game.battle.soul.direction == "left" then
            self.x = Game.battle.soul.x - 10
            self.y = Game.battle.soul.y
        elseif Game.battle.soul.direction == "right" then
            self.x = Game.battle.soul.x + 10
            self.y = Game.battle.soul.y
        end
    end
    self.layer = BATTLE_LAYERS["soul"] - 1
    --self.alpha = 0.75
    self.color = COLORS.gray

end

function DoubleJumpEffect:update()
    super.update(self)
    self.timer = self.timer + 1
    --self.alphafade = self.alphafade + 0.2

end

function DoubleJumpEffect:draw()
    super.draw(self)
    love.graphics.setLineWidth(2)
    local soul = Game.battle.soul
    if soul.direction == "down" or soul.direction == "up" then
        love.graphics.ellipse("line", 0, 0, 5 + self.timer/2, 2 + self.timer/4, 100)
        love.graphics.ellipse("line", 0, 0, 10 + self.timer, 4 + self.timer/2, 100)
    elseif soul.direction == "left" or soul.direction == "right" then
        love.graphics.ellipse("line", 0, 0, 2 + self.timer/4, 5 + self.timer/2, 100)
        love.graphics.ellipse("line", 0, 0, 4 + self.timer/2, 10 + self.timer, 100)
    end
end

return DoubleJumpEffect