---@class muslogo : Object
---@overload fun(...) : muslogo
local fieldmuslogo, super = Class(Object)

function fieldmuslogo:init(logo, x, y, x1, y2)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.present = true

    self.timer = 0

    self.parallax_x = 0
    self.parallax_y = 0

    local logo_obj = Sprite("objects/musiclogos/" .. (logo or "field"), x or 180, y or 120)
    logo_obj:setScale(2)
    logo_obj.alpha = 0
    self:addChild(logo_obj)

    Game.world.timer:tween(1, logo_obj, {x = x1 or 160, y = y1 or 120, alpha = 1}, "out-sine")

    Game.world.timer:after(4, function()
        Game.world.timer:tween(1, logo_obj, {x = x2 or 140, y = y2 or 120, alpha = 0}, "out-sine")
        self.present = false
    end)
end

function fieldmuslogo:update()
    if self.present == false then
        -- FIXDT??
        self.timer = self.timer + 1
        if self.timer == 32 then self:remove() end
    end
end

return fieldmuslogo