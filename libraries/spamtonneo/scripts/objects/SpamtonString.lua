local String, super = Class(Object)

function String:init(x, y, fg, top_x)
    super:init(self, x, y, fg and 1 or 0.5, 400)
    self.layer = fg and -20 or -25
    self.fg = fg
    self.top_x = x - (top_x or x)
    self.color = fg and COLORS.green or {0,0.2,0}
    self.inherit_color = true
    self.swing_speed = 0.5
    self.siner = Utils.random(math.pi*2*30)
    self.line_rotation = -math.pi/2
end

function String:update()
    super:update(self)
    if self.swing_speed > 0 then
        self.siner = self.siner + self.swing_speed*DTMULT
    end
end

function String:draw()
    super:draw(self)
    love.graphics.setColor(self:getDrawColor())
    love.graphics.setLineWidth(self.width)
    love.graphics.line(math.cos(self.siner/30)*2,0, self.top_x,-400)
end

return String