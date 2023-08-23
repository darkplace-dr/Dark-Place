---@class muslogo : Sprite
---@overload fun(...) : muslogo
local fieldmuslogo, super = Class(Sprite)

function fieldmuslogo:init(logo, x, y, dest_x1, dest_y1, dest_x2, dest_y2)
    logo = logo or "field"
    x = x or 180
    y = y or 100

    super.init(self, logo, x, y, nil, nil, "objects/musiclogos")
    self:setParallax(0, 0)
    self:setScale(2)
    self.alpha = 0

    self.dest_x1 = dest_x1 or (self.x - 28.93)
    self.dest_y1 = dest_y1 or self.y
    self.dest_x2 = dest_x2 or (self.x - 62)
    self.dest_y2 = dest_y2 or self.y

    self.timer = Timer()
    self:addChild(self.timer)
end

function fieldmuslogo:onAdd(_)
    self.timer:tween(1, self, {x = self.dest_x1, y = self.dest_y1}, "out-quad")
    self.timer:tween(20/30, self, {alpha = 1}, "linear")
    self.timer:after(4, function()
        self.timer:tween(1, self, {x = self.dest_x2, y = self.dest_y2}, "out-quad")
        self.timer:tween(1, self, {alpha = 0}, "linear", function ()
            self:remove()
        end)
    end)
end

return fieldmuslogo