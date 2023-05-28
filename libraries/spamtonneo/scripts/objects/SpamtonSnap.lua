local SnapString, super = Class(Object)

function SnapString:init(x, y, top_x)
    super:init(self, x, y, 1, 400)
    self.layer = -18
    self.color = COLORS.orange

    self.x1, self.y1 = 0,0
    self.x2, self.y2 = top_x,-400
    self.x3, self.x4 = self.x1, self.x2
    self.y3 = self.y1 - 65
    self.y4 = -400

    self.timer = 0
    self.shake = 5
    self.visible_shake = 0
    self.shake_timer = 0
    self.bottom_visible = true
    self.split = false
end

function SnapString:update()
    super:update(self)
    self.timer = self.timer + DTMULT
    if not self.split and self.timer >= 11 then
        self.split = true
        self.y2 = self.y1 - 65
    elseif self.split then
        if self.y3 > self.y4 then
            self.y3 = self.y3 - 2*DTMULT
        end
        if self.y2 < self.y1 then
            self.y2 = self.y2 + 2*DTMULT
            if (math.abs(self.y2 - self.y1) < 8) or self.y2 >= self.y1 then
                self.bottom_visible = false
            end
        end
    end
    if self.shake > 0 then
        self.shake_timer = self.shake_timer + DTMULT
        if self.shake_timer > 2 then
            self.shake_timer = self.shake_timer - 2
            self.shake = self.shake - 1
            self.visible_shake = Utils.random(-self.shake, self.shake)
        end
    else
        self.visible_shake = 0
    end
    if self.timer > 60 then
        self:remove()
    end
end

function SnapString:draw()
    super:draw(self)
    love.graphics.setColor(self:getDrawColor())
    love.graphics.setLineWidth(self.width)
    if self.bottom_visible then
        local x1, y1 = self.x1 + self.visible_shake, self.y1 + self.visible_shake
        local x2, y2 = self.x2 + self.visible_shake, self.y2 + self.visible_shake
        love.graphics.line(x1, y1, x2, y2)
    end
    if self.split then
        love.graphics.line(self.x3, self.y3, self.x4, self.y4)
    end
    if self.timer < 11 then
        love.graphics.setColor(1,1,1)
        love.graphics.line(self.x1, self.y1, self.x2, self.y2)
    end
end

return SnapString