---@class DarkTransitionLine : Object
---@overload fun(...) : DarkTransitionLine
local DarkTransitionLine, super = Class(Object)

function DarkTransitionLine:init(x)
    super.init(self, x, 260)

    local h = (6 + Utils.round(40))
    self.image_xscale = 2
    self.image_yscale = (4 * h)
    self.vspeed = (-16 - math.random(4))
    self.depth = -100

end

function DarkTransitionLine:update()
    self:move(0, self.vspeed * DTMULT)
    if (self.y >= 400) then
        self.parent:removeChild(self)
    end
    super.update(self)
end

function DarkTransitionLine:draw()
    love.graphics.setLineWidth(self.image_xscale)
    love.graphics.setLineStyle("rough")
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(0, 0, 0, self.image_yscale)
    --love.graphics.setColor(1,1,1,1)
    --love.graphics.draw(Assets.getTexture("kristal/doorvortex"), 0, 0, rot, xscale, yscale, SCREEN_WIDTH, SCREEN_HEIGHT)

    super.draw(self)
end

return DarkTransitionLine