---@class SimpleText : Object
---@overload fun(...) : SimpleText
local SimpleText, super = Class(Object)

function SimpleText:init(x, y, text)
    super.init(self, x, y)
	
	self.font = Assets.getFont("main")
    self.text = text
end

function SimpleText:draw()
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, 0, 0)
end

return SimpleText