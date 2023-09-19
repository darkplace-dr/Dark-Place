---@class SharpSliceSpade : Object
---@overload fun(...) : SharpSliceSpade
local SharpSliceSpade, super = Class(Object)

function SharpSliceSpade:init(x, y)
    super.init(self, x, y)

    self.snowflake = Assets.getTexture("effects/cardspell/spade")

    self.siner = 0
    self.timer = 0
    self.alpha = 1
end

function SharpSliceSpade:update()
    super.update(self)
    self.timer = self.timer + DTMULT
    self.siner = self.siner + DTMULT

    if (self.timer >= 30) then
        self:remove()
    end
end

function SharpSliceSpade:draw()
    super.draw(self)

    Draw.draw(self.snowflake, 0, 0, 0, (math.sin(self.siner) * 2), 2, self.snowflake:getWidth() / 2, self.snowflake:getHeight() / 2)
    Draw.draw(self.snowflake,  (math.sin((self.siner / 3)) * 30), 0, 0, (math.sin((self.siner / 3)) * 2), 2, self.snowflake:getWidth() / 2, self.snowflake:getHeight() / 2)
    Draw.draw(self.snowflake, -(math.sin((self.siner / 3)) * 30), 0, 0, (math.sin((self.siner / 3)) * 2), 2, self.snowflake:getWidth() / 2, self.snowflake:getHeight() / 2)
end

return SharpSliceSpade